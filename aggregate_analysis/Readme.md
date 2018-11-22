# Re-Analysis of the Ragni2016 dataset
As the main basis for all our models of syllogistic reasoning, we relie on a filetered subset of the Ragni2016 dataset.
If this dataset is corrupt, all of our analyses to date are at stake.


It appears as if the filtering criteria introduce bias towards more logical reasoners. In this project, I analyze the aggregate data.

### Content
`alice_filetered_agg_Ragni2016.ods`: Aggregated 64-syllogism table of alice's 139 dataset

`raw_agg_Ragni2016.ods`: Aggregated 64-syllogsim table without filtering

`filtered_139_data`: the filtered 139 dataset with extraction scripts

`raw_analysis`: the raw alice dataset with modified extraction scripts

### Methods
Example tasks (underscore _ in task name) were removed.

#### Filtered dataset
I extracted and aggregated the individual data into a color-coded table.

##### Filtering process
The filtering process is not documented, but according to Nico and Marco,
participants scoring lower than some threshold (14%?) in logical correctness were dropped.
Maybe also participants with low reaction times were dropped.

#### Raw dataset
I removed participants with empty premise information in addition to the test tasks.
Then I went on with extracting and aggregating the data.
This procedure is not well-tested and may contain errors.
279 participants were considered - this was also the maximum number of answers for a syllogism.
218 participants answered every single syllogism.

### Conclusions
The 279-dataset has a substantially higher entropy, compared to the filtered 139-dataset.
Also, the NVC answer is less frequent in the 279 dataset.

### Contributions
* Data by Alice
* Analysis by Lukas
