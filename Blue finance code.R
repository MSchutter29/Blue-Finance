#### code used for stacked bar plot (Figure 2) ####

install.packages("ggplot2")
library(ggplot2)

install.packages("forcats")
library(forcats)

dat2 = read.csv("Relative investment stacked_updated.csv")
dat2 = as.data.frame(dat2)

p = ggplot(dat2, aes(x = reorder(Industry, Value), y = Value, fill = Source)) +
  xlab("Industry") +
  ylab ("Size of blue economy finance relative to industry size") +
  geom_col() +
  scale_fill_manual(values = c("#7fcdbb","#225ea8","#0c2c84","#1d91c0")) +
  scale_y_continuous(labels = scales::percent) +
  theme(
    text = element_text(size=18),
    panel.background = element_rect(fill = 'white',
                                    linewidth = 0.5, linetype = "solid"),
    panel.grid.major = element_line(linewidth = 0.5, linetype = 'solid',
                                    colour = 'white'), 
    panel.grid.minor = element_line(linewidth = 0.25, linetype = 'solid',
                                    colour = 'grey')
  )
p + coord_flip()

##### code used for world map with bubbles (Figure 3) ####
install.packages('scatterpie')
library(scatterpie)

library(ggplot2)

d = read.csv("mapdata_redflags.csv")
world <- map_data('world')
p = map %>%
  ggplot() +
  geom_polygon(data = map, aes(x=long, y = lat, group = group), fill="skyblue", alpha=0.3) +
  coord_quickmap()
p = p + geom_scatterpie(aes(x=long, y=lat, group=region, r=0.2*total),
                        data=d, cols=c("Enclosure",	"Exclusion",	"Encroachment",	"Entrenchment"), color=NA, alpha=9/10)+
  scale_fill_manual(values=c("#084594","#4292c6","#deebf7","#9ecae1")) +
  geom_text(data=d, aes(x=long, y=lat, label = region), position = position_stack(vjust=1.32)) +
  theme_void() + 
  theme(
    text = element_text(color = "#22211d", size = 14),
    legend.position = "bottom",
    plot.background = element_rect(fill = "white", color = NA), 
    panel.background = element_rect(fill = "white", color = NA),
    plot.title = element_text(size= 18, hjust=0.1, color = "#4e4d47", margin = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
  ) +
  guides(fill=guide_legend("Type of red flag"))
p
