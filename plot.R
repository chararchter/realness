library(stringr)
library(tidyr)
library(dplyr)
library(ggplot2)
library(viridis)

data = read.csv("tweets.csv")

data$text = str_squish(data$text)
data$text = str_to_lower(data$text)
data$text = str_extract_all(data$text, "(love|intelligence|gender|money|morality)")

data = unnest_wider(data, text)

# select rows with just 5 values which means 7th col is NA
# else some words appear twice & context is required to correctly determine ranks
data = filter(data, is.na(data[7]))
data = data[,1:6]
# ranks from most to least real
names(data) <- c('screen_name', 5, 4, 3, 2, 1)

data = data %>%
	pivot_longer(-screen_name, names_to = "realness", values_to = "concept")

data$realness = as.integer(data$realness)
data$concept = as.factor(data$concept)

data = data %>%
	add_count(concept, realness, sort = TRUE)

p = ggplot(data, aes(realness, concept, colour=concept, size=n)) +
	geom_jitter(alpha=0.4) +
	scale_size(range=c(0.5, 5), name="size") +
	scale_color_viridis(discrete=TRUE, option="D")+
	scale_fill_viridis(discrete=TRUE) +
	scale_x_continuous(name="realness", limits=c(0.5, 5.5), breaks=seq(1,5,1),
		labels = c("1"="less real", "2"="", "3"="", "4"="", "5"="more real")) +
	labs(title = "Ranking of concepts in order of how real they are",
       caption = "Analysis by @chararchter, Source: twitter.com/QiaochuYuan/status/1248811329340592128") +
	theme_minimal(base_size=12) +
	theme(legend.position="none", axis.text = element_text(colour = "grey10"),
		plot.caption = element_text(colour = "grey20", size = 8))

ggsave(filename = "real.pdf", plot = p, height=11.12, width=18, dpi = 600, units = "cm")