##Vizualisation of realness

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

# read packages
library(rtweet)
library(stringr)
library(tidyr)
library(dplyr)
library(ggplot2)
library(viridis)
```
1. run
	1. auth.R
	1. scrapTwitter.R
	1. plot.R

###Results
![Bubble plot of realness](https://github.com/chararchter/realness/blob/master/real.jpg)


###Data source:
[twitter survey](https://twitter.com/QiaochuYuan/status/1248811329340592128)