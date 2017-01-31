library(rvest)
library(dplyr)


wiki <- read_html("https://en.wikipedia.org/wiki/List_of_RAL_colors")

ral <- 
  wiki %>% 
  html_table(fill=TRUE) %>% 
  .[1:9] %>%  # first 9 tables contain RAL colors
  bind_rows %>% 
  select(-Sample) %>% 
  mutate(Number = sub("RAL ", "", Number) %>% as.integer())

colors_ral <- 
  wiki %>% 
  html_nodes("td[title]") %>% 
  html_attr("title") %>% 
  sub("color.", "", .)

ral$color <- colors_ral

ral <- 
  ral %>% 
  select(RAL=Number, color = color, name=`English Name`, german_name=`German Name`, description=`Description, examples`)


#write.csv(ral, "./data/ral.csv", row.names = FALSE, na="")
ral_colors <- setNames(ral$color, paste0("RAL", ral$RAL))

devtools::use_data(ral, ral_colors, pkg=".", overwrite = TRUE)

