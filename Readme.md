# Re-Analysis of the Ragni2016 dataset
As the main source of information on human syllogstic reasoning behavior, we relie on a dataset of Marco and Alice (2016). It consists of 139 participants.

This dataset is based on a filetered subset of the Ragni2016 dataset.
This project analyzes if the filtering procedure is adequate.

### Content
* `reproduce_filtering`: Reproduce the filtering approach by Marco and Alice; Compare resulting distributions
* `aggregate_analysis`: Compare the filtered and raw datasets on the aggregate level
* `extraction`: basic extraction scripts
* `raw`: Archieved data left by Alice


### Methods
To reproduce the filtered dataset, we remove
* incomplete answer patterns
* participants with less than 17% correctness according to FOL
* test tasks

Also, we calculate entropy and aggregate the data.

### Conclusion
Filtering leads to a substantial decrease in entropy.

The filtering can be reproduced, but does not seem warranted.
* `reproduce.py` shows that removing incomplete data and participants with low correctness leads to nearly exactly the same distribution of correctnesses
* Two participants are filtered out additionally, there seems to be be  another filtering criterion
* Filtering out participants with low correctness leads to a massive loss of information
* We expect that this loss of information leads to substantial bias in modeling human reasonig
* We already observed that the ranking of cognitive models (Khemlani table) depends strongly on which of the filtered datasets is used

![Alt text](reproduce_filering/correctness_plot.png?raw=true "Title")


We recommend discontinuing the use of correctness criteria for detection of anomalous users.

### Contributions
* Data by Alice and Marco
* Filtering by Alice and Marco
* Analysis by Lukas
