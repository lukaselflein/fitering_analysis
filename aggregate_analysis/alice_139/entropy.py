""" Calculate entropy on Ragni2016 dataset

Copyright 2018 Cognitive Computation Lab
University of Freiburg
Lukas Elflein <elfleinl@cs.uni-freiburg.de>

"""

import pandas as pd
import numpy as np

# Import the raw data
df = pd.read_csv('aggregated_Ragni2016.csv', sep=',')
df = df.set_index(df.columns[0])
df.index.name = ''


def entropy(x):
    if x == 1 or x == 0:
        return 0
    elif x < 1 and x > 0:
        return - x * np.log(x)
    else:
        raise ValueError('{} invalid argument for entropy p * log(p)'.format(x))


def row_entropy(row):
    total_entropy = 0
    total = 0
    for frequency in row:
        total += frequency
        total_entropy += entropy(frequency)

    if total < 0.99 or total > 1.01:
        raise ValueError('Row not normalized, sums to {}'.format(frequency))

    return total_entropy


df['entropy'] = df.apply(row_entropy, axis=1)
df = df.sort_values('entropy', ascending=False)

df.to_csv('entropy_Ragni2016.csv', index=True)
