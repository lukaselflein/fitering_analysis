""" Extracts and filters human data from a syllogistic experiment.

Copyright 2018 Cognitive Computation Lab
University of Freiburg
Author: Lukas Elflein <elfleinl@cs.uni-freiburg.de>
Based on: Nicolas Riesterer <riestern@tf.uni-freiburg.de>

"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Bins for plotting
BINS = np.linspace(0, 1, 64)

# Import the raw data
raw_df = pd.read_csv('syllog.csv', sep=';')

raw_df = raw_df.dropna()

# Construct normalized response column
raw_df['response'] = raw_df[['ConclQ', 'ConclDir']].apply(
    lambda x: x[0] + x[1].lower(), axis=1)
raw_df['response'] = raw_df['response'].replace('NVCnvc', 'NVC')

# Drop the uninteresting columns
uninteresting_columns = [
    'breaktype', 'code', 'ConclDir', 'ConclQ',
    'givenanswer',
    'givenanswertext', 'nouns', 'ordering', 'ordertext',
    'validConclusions', 'vpid'
]
raw_df = raw_df.drop(uninteresting_columns, axis=1)

# Normalize column names
raw_df = raw_df.rename(columns={
    'syllog': 'task',
    'cid': 'id',
    'time': 'rt_ms',
    'edu': 'education'
})

# Remove test trials
raw_df['task'] = raw_df['task'].apply(
    lambda x: np.nan if '_' in x else x)
raw_df['p1'] = raw_df['p1'].apply(
    lambda x: x if 'Premise' in x else np.nan)
raw_df = raw_df.dropna()

# Normalize data
raw_df['task_text'] = raw_df[['p1', 'p2']].apply(
    lambda x: '\"{};{}\"'.format(x[0][11:], x[1][11:]), axis=1)
raw_df.drop(['p1', 'p2'], axis=1, inplace=True)

# How many participants are left?
nr_participants = len(raw_df.id.unique())
print('Total unique participant ids: {}'.format(nr_participants))

# Exclude incomplete response patterns
# How many tasks did each participant complete?
task_nr_series = raw_df.groupby('id')['task'].count()
# Select complete participant ids
complete_part = task_nr_series[task_nr_series == 64]
# Filter data to contain only complete answer patterns
complete_data = raw_df[raw_df['id'].isin(complete_part.index.tolist())]
print('Participants with 64 tasks: {}'.format(len(complete_data['id'].unique())))
# Exclude participants who answered less than x% of all answers correclty
raw_df['correctness'] = raw_df['correctness'].apply(pd.to_numeric)
# How correct is each participants on average?
correctness_means = raw_df.groupby('id')['correctness'].mean()

# Plot Correctness
correctness_means.hist(bins=BINS, label='Raw data, N={}'.format(correctness_means.size), alpha=0.5)

# Now, only use complete data
raw_df = complete_data
# Exclude participants who answered less than x% of all answers correclty
raw_df['correctness'] = raw_df['correctness'].apply(pd.to_numeric)
# How correct is each participants on average?
correctness_means = raw_df.groupby('id')['correctness'].mean()

# Plot Correctness
correctness_means.hist(bins=BINS, label='Complete answer patterns, N={}'.format(correctness_means.size), alpha=0.5)

# Filtering criterion: Answers must be more logical than random chance:
threshold = 1 / 9
threshold = 0.16
threshold = 0.176470588235  # Alice value
logical_part = correctness_means[correctness_means > threshold]
logical_part.hist(bins=BINS, label='correctness>{}, n={}'.format(threshold, logical_part.size), alpha=0.5)
print(len(logical_part.unique()))


# Compare to Alice
# ================
alice_df = pd.read_csv('alice_139/syllo64_dataFil_raw.csv', sep=';')

# Construct normalized response column
alice_df = alice_df.rename(columns={
    'syllog': 'task',
    'cid': 'id',
    'time': 'rt_ms',
    'edu': 'education'
})

# Remove test trials
alice_df['task'] = alice_df['task'].apply(
    lambda x: np.nan if '_' in x else x)
alice_df['p1'] = alice_df['p1'].apply(
    lambda x: x if 'Premise' in x else np.nan)
alice_df = alice_df.dropna()

alice_df['correctness'] = alice_df['correctness'].apply(pd.to_numeric)
alice_means = alice_df.groupby('id')['correctness'].mean()
alice_means.hist(bins=BINS, label='alice, N={}'.format(len(alice_df['id'].unique())), histtype=u'step')

plt.legend(loc='upper right')
plt.show()

# Write the table to a file
raw_df.to_csv('Ragni2016_{}.csv'.format(nr_participants), index=False)
