## Vizualisation of realness

1. first [create your twitter app](https://developer.twitter.com/en/apps)
1. update auth.R with [your keys](https://rtweet.info/articles/auth.html#access-tokensecret-method)
1. make sure you have necessary libraries
```
# install packages
install.packages(rtweet)
install.packages(stringr)
install.packages(tidyr)
install.packages(dplyr)
install.packages(ggplot2)
install.packages(viridis)
install.packages(lattice)

# read packages
library(rtweet)
library(stringr)
library(tidyr)
library(dplyr)
library(ggplot2)
library(viridis)
library(lattice)
```
1. run
	1. auth.R
	1. scrapTwitter.R
	1. plot.R

### Results

The most interesting part in this comparison is the relationship between the realest concept and the realness attributed to the money. The majority of group which rank love as the realest, rank money as least real. In contrast - the group who rank intelligence as the realest, rank money as second realest concept.

The realness of morality is equally fascinating - the love group ranked morality as somewhat in the middle, wheras the intelligence group consistently ranked it as least real.

![Bubble plot of realness](https://github.com/chararchter/realness/blob/master/plots/bubbleplot.jpeg)
<!-- ![Box plot of realness](https://github.com/chararchter/realness/blob/master/plots/boxplot.jpeg) -->
<!-- ![Heatmap of realness](https://github.com/chararchter/realness/blob/master/plots/heatmap3.jpeg) -->
<!-- ![Heatmap of realness](https://github.com/chararchter/realness/blob/master/plots/heatmap1.jpeg) -->
![Comparison of groups who rank love and intelligence as most real](https://github.com/chararchter/realness/blob/master/plots/heatmap_comp.jpeg)
![Heatmap of realness](https://github.com/chararchter/realness/blob/master/plots/heatmap3.jpeg)

### Data source:
[twitter survey](https://twitter.com/QiaochuYuan/status/1248811329340592128)