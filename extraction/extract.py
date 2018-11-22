""" Extracts and normalizes the Ragni (2016) data.

Copyright 2018 Cognitive Computation Lab
University of Freiburg
Author: Nicolas Riesterer <riestern@tf.uni-freiburg.de>
Modified: Lukas Elflein <elfleinl@cs.uni-freiburg.de>

"""

import pandas as pd
import numpy as np

# Import the raw data
data_df = pd.read_csv('syllog.csv', sep=';')

data_df = data_df.dropna()

# Construct normalized response column
data_df['response'] = data_df[['ConclQ', 'ConclDir']].apply(
    lambda x: x[0] + x[1].lower(), axis=1)
data_df['response'] = data_df['response'].replace('NVCnvc', 'NVC')

# Drop the uninteresting columns
uninteresting_columns = [
    'breaktype', 'code', 'ConclDir', 'ConclQ',
    'correctness', 'givenanswer',
    'givenanswertext', 'nouns', 'ordering', 'ordertext',
    'validConclusions', 'vpid'
]
data_df = data_df.drop(uninteresting_columns, axis=1)

# Normalize column names
data_df = data_df.rename(columns={
    'syllog': 'task',
    'cid': 'id',
    'time': 'rt_ms',
    'edu': 'education'
})

# Remove test trials
data_df['task'] = data_df['task'].apply(
    lambda x: np.nan if '_' in x else x)
data_df['p1'] = data_df['p1'].apply(
    lambda x: x if 'Premise' in x else np.nan)
data_df = data_df.dropna()

# Normalize data
data_df['task_text'] = data_df[['p1', 'p2']].apply(
    lambda x: '\"{};{}\"'.format(x[0][11:], x[1][11:]), axis=1)
data_df.drop(['p1', 'p2'], axis=1, inplace=True)


# Fill missing columns with na
data_df['response_order'] = np.nan
data_df['affinity'] = np.nan
data_df['experience'] = np.nan
data_df['week'] = 1
data_df['domain'] = 'syllogistic'
data_df['possible_responses'] = 'Aac;Iac;Eac;Oca;Aca;Ica;Eca;Oca;NVC'

# Sort the columns
data_df = data_df[[
    'id', 'week', 'sequence', 'task', 'response', 'rt_ms', 'task_text',
    'response_order', 'domain',
    'possible_responses']]

# How many participants are left?
nr_participants = len(data_df.id.unique())
print('Total unique participant ids: {}'.format(nr_participants))

# Write the table to a file
data_df.to_csv('Ragni2016_{}.csv'.format(nr_participants), index=False)
