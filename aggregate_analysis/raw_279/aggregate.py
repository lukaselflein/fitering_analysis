""" Aggregates the Ragni 2016 data

Copyright 2018 Cognitive Computation Lab
University of Freiburg
Lukas Elflein <elfleinl@cs.uni-freiburg.de>

"""

import pandas as pd

# Import the raw data
df = pd.read_csv('Ragni2016.csv', sep=',')
df = df[['id', 'task', 'response']]

answers = ['Aac', 'Iac', 'Eac', 'Oac', 'Aca', 'Ica', 'Eca', 'Oca', 'NVC']
syllogs = []
quants = ['A', 'I', 'E', 'O']
for q1 in quants:
    for q2 in quants:
        for fig in [1, 2, 3, 4]:
            syllogs += [q1 + q2 + str(fig)]
agg = pd.DataFrame(0, columns=answers, index=syllogs)

# Iterate over all rows, sum data
for num, line in df.iterrows():
    agg[line.response][line.task] += 1

# Normalize data: number of answers / 139
print('Participants were aggregated:', agg.sum(axis=1))
print('Min: {}\nMax: {}'.format(agg.sum(axis=1).min(), agg.sum(axis=1).max()))
print('Total participants: {}'.format(len(df.id.unique())))
agg = agg.div(agg.sum(axis=1), axis=0)

agg.to_csv('aggregated_Ragni2016.csv', index=True)
