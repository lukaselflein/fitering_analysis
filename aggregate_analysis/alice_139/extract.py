""" Extracts and normalizes the Ragni (2016) data.

Copyright 2018 Cognitive Computation Lab
University of Freiburg
Nicolas Riesterer <riestern@tf.uni-freiburg.de>

"""

import pandas as pd
import numpy as np

# Import the raw data
data_df = pd.read_csv('syllo64_dataFil_raw.csv', sep=';')

# Construct normalized response column
data_df['response'] = data_df[['ConclQ', 'ConclDir']].apply(
    lambda x: x[0] + x[1].lower(), axis=1)
data_df['response'] = data_df['response'].replace('NVCnvc', 'NVC')

# Drop the uninteresting columns
uninteresting_columns = [
    'ACC', 'ACCinKJL', 'breaktype', 'cid', 'code', 'ConclDir', 'ConclQ',
    'correctness', 'datetime', 'givenanswer',
    'givenanswertext', 'model', 'N', 'nouns', 'ordering', 'ordertext',
    'sdTimeACC', 'time_ACC', 'time_all', 'validConclusions',
    'vpid'
]
data_df = data_df.drop(uninteresting_columns, axis=1)

# Normalize column names
data_df = data_df.rename(columns={
    'syllog': 'task',
    'subj': 'id',
    'time': 'rt_ms',
    'edu': 'education'
})

# Remove test trials
data_df['task'] = data_df['task'].apply(
    lambda x: np.nan if '_' in x else x)
data_df = data_df.dropna()

# Normalize data
data_df['task_text'] = data_df[['p1', 'p2']].apply(
    lambda x: '\"{};{}\"'.format(x[0][11:], x[1][11:]), axis=1)
data_df.drop(['p1', 'p2'], axis=1, inplace=True)


def normalize_education(education):
    lowed = education.replace(',', ' ')
    lowed = education.replace('.', '')
    lowed = lowed.lower().split()

    if np.any([x in ['bachelors', 'bachelor', 'ba', 'bs', 'bsc', 'b.s.'] for x in lowed]):
        return 'Bachelor'
    if np.any([x in ['masters', 'master', 'ma', 'ms', 'msc', 'm.s.', 'm.sc', 'diploma'] for x in lowed]):
        return 'Master'
    if np.any([x in ['phd'] for x in lowed]):
        return 'Phd'
    if np.any([x in ['school', 'college', 'high'] for x in lowed]):
        return 'School'

    return np.nan


data_df['education'] = data_df['education'].apply(normalize_education)

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
    'response_order', 'age', 'gender', 'education', 'affinity', 'experience', 'domain',
    'possible_responses']]

# Write the table to a file
data_df.to_csv('Ragni2016.csv', index=False)
