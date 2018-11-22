# Reproduce Ragni 2016 dataset
This project reproduces the filtering approach to outlier detection done by Alice.

### Content
* `syllog.csv`: the raw data exported from the web experiment data base
* `syllo64_dataFil_raw.csv`: data filtered by alice, N=139, used in all our papers

* `Ragni2016_raw.csv`: minimally processed data (removed training tasks)
* `Ragni2016_complete.csv`: exclusively the participants who answered to exactly 64 syllogisms
* `Ragni2016_filtered.csv`: complete datasets with a correctness-rate above 17% (binomal test for random guessing)

* `reproduce.py`: script to extract, filter and visualize the above datasets

### Conclusion
We can reproduce the filtering, but it does not seem warranted.
* `reproduce.py` shows that removing incomplete data and participants with low correctness leads to nearly exactly the same distribution of correctnesses
* Two participants are filtered out additionally, there seems to be be  another filtering criterion
* Filtering out participants with low correctness leads to a massive loss of information
* We expect that this loss of information leads to substantial bias in modeling human reasonig
* We already observed that the ranking of cognitive models (Khemlani table) depends strongly on which of the filtered datasets is used
* We recommend discontinuing the use of correctness criteria for detection of anomalous users

### Author
* Analysis: Lukas Elflein <elfleinl@cs.uni-freiburg.de>
