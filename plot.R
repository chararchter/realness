library(stringr)
library(tidyr)
library(dplyr)
library(ggplot2) # plots
library(viridis) # color palette
library(wesanderson) # color palette
library(lattice) # heatmap plot
library(grDevices) # custom color palette

data = read.csv("tweets.csv")

# remove \n
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

theme_set(theme_minimal(base_size = 12))
theme_replace(axis.text = element_text(colour = "grey10"),
	plot.subtitle = element_text(colour = "grey20", size = 8),
	plot.caption = element_text(colour = "grey20", size = 8))

title = "Ranking of concepts in order of how real they are"
caption = "Analysis: @chararchter, Source: twitter.com/QiaochuYuan/status/1248811329340592128"
labels = c("1"="less real", "2"="", "3"="", "4"="", "5"="more real")
ylab = "realness (5 = most real)"
pal <- wes_palette("Zissou1", 100, type = "continuous")
pal2 <- colorRampPalette(c("#3B9AB2",  "#F21A00"))

export_lattice <- function(filename){
	jpeg(paste0("plots/", filename,'.jpeg'), width = 15.5, height = 15, unit = "cm", res = 1200, pointsize = 2)
}

export_gg = function(filename, plot, height = 11.12, width = 18){
	ggsave(paste0("plots/", filename,'.jpeg'), plot = plot, height=height, width=width, dpi = 600, units = "cm")
}

data_count = data %>%
	count(concept, realness, sort = TRUE, name = "n")

p = ggplot(data, aes(realness, concept, colour=concept, size=n)) +
	geom_jitter(alpha=0.4) +
	scale_size(range=c(0.5, 5), name="size") +
	scale_color_viridis(discrete=TRUE)+
	scale_fill_viridis(discrete=TRUE) +
	scale_x_continuous(breaks=seq(1,5,1), labels = labels) +
	labs(title = title, caption = caption) +
	theme(legend.position="none")

export_gg("bubbleplot", p)

d = ggplot(data_count, aes(realness, n, fill=concept)) +
    geom_bar(stat = "identity") +
	scale_fill_viridis(discrete=TRUE) +
	scale_x_continuous(limits=c(0.5, 5.5), breaks=seq(1,5,1), labels = labels) +
	labs(title = title, caption = caption)

export_gg("boxplot", d)

h = ggplot(data_count, aes(concept, realness, fill= n)) + 
	geom_tile() +
	scale_fill_gradientn(colours = pal) +
	# scale_fill_viridis() +
	labs(title = title, caption = caption, x = NULL, y = ylab)

export_gg("heatmap0", h, 12, 14)

mysettings <- trellis.par.set()
mysettings$par.sub.text$col.sub = "grey20"
mysettings$par.sub.text$font.sub = 1

export_lattice("heatmap1")
levelplot(n ~ concept*realness, data=data_count, main=title,
	col.regions = pal2(70),
	ylab = ylab, sub = list(caption, fontsize=10))
dev.off()

export_lattice("heatmap2")
levelplot(n ~ concept*realness, data=data_count, main=title,
	col.regions = viridis_pal(option = "D")(70),
	ylab = ylab, sub = list(caption, fontsize=10))
dev.off()

export_lattice("heatmap3")
levelplot(n ~ concept*realness, data=data_count, main=title,
	col.regions = pal,
	ylab = ylab, sub = list(caption, fontsize=10))
dev.off()