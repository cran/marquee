## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dev = "ragg_png",
  fig.width = 6,
  out.width = "98%",
  fig.align = "center",
  dpi = 300
)
should_eval <- getRversion() >= "4.3"
has_gt_gtable <- "as_gtable" %in% getNamespaceExports("gt")

## ----setup--------------------------------------------------------------------
library(marquee)
library(grid)
library(ggplot2)

## ----eval=should_eval---------------------------------------------------------
md_text <- 
"# Lorem Ipsum
Lorem ipsum dolor sit amet, *consectetur* adipiscing elit, sed do eiusmod tempor incididunt ut
labore et dolore magna **aliqua**. Ut enim ad minim veniam, quis nostrud exercitation ullamco
laboris nisi ut aliquip ex ea commodo _consequat_. Duis aute irure dolor in reprehenderit in
voluptate velit esse cillum dolore eu fugiat nulla ~pariatur~. Excepteur sint occaecat
cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

grob <- marquee_grob(md_text, classic_style())

grid.draw(grob)

## ----eval=should_eval---------------------------------------------------------
new_style <- classic_style(body_font = "serif", header_font = "mono", hanging = em(1))

new_style <- modify_style(
  new_style, 
  "str", 
  background = "lightgrey", 
  border_radius = 3, 
  padding = trbl(em(0.2))
)

grid.draw(
  marquee_grob(md_text, new_style)
)

## ----eval=should_eval---------------------------------------------------------
md_text_custom <- 
"# Lorem Ipsum
Lorem ipsum dolor {.red sit amet, *consectetur* adipiscing elit, sed do} eiusmod tempor
incididunt ut labore et dolore magna **aliqua**. Ut enim ad minim {#2af veniam}, quis nostrud
exercitation ul lamcolaboris nisi ut aliquip ex ea commodo _consequat_. Duis aute irure dolor
in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla ~pariatur~. Excepteur
sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est
laborum."

grid.draw(
  marquee_grob(md_text_custom, classic_style())
)

## ----eval=should_eval---------------------------------------------------------
grid.draw(
  marquee_grob(md_text_custom, modify_style(classic_style(), "red", tracking = 400))
)

## ----eval=should_eval---------------------------------------------------------
fancy_font <- classic_style(
  weight = "semibold",
  features = systemfonts::font_feature(
    ligatures = c("standard", "discretionary"),
    letters = c("stylistic", "swash", "historical")
  )
)
ggplot(mtcars, aes(disp, mpg, label = rownames(mtcars))) + 
  geom_marquee(style = fancy_font, size = 2.5, family = "spectral") # You may not have this font

## ----eval=should_eval---------------------------------------------------------
cars <- sub("(\\w+)", "{.red ***\\1***}", rownames(mtcars))
cars

ggplot(mtcars) + aes(disp, mpg, label = cars) + 
  geom_marquee()

## ----eval=should_eval---------------------------------------------------------
text_box_style <- modify_style(
  classic_style(base_size = 2),
  "body",
  padding = skip_inherit(trbl(10)),
  border_radius = 3
)

ggplot(mtcars) + aes(disp, mpg, label = cars) + 
  geom_marquee(size = 2) + 
  annotate(GeomMarquee, 
    label = md_text, 
    x = 450, 
    y = 35, 
    style = text_box_style, 
    size = 2, 
    fill = "lightgrey",
    width = 0.3, 
    hjust = "right",
    vjust = "top"
  )

## ----eval=should_eval---------------------------------------------------------
ggplot(mtcars) + aes(disp, mpg, label = cars) + 
  geom_marquee(size = 2) + 
  ggtitle(md_text) + 
  theme(plot.title = element_marquee(size = 9))

## ----fig.asp=0.8, eval=should_eval--------------------------------------------
ggplot(mtcars) + aes(disp, mpg, label = cars) + 
  geom_marquee(size = 2) + 
  ggtitle(md_text) + 
  theme(plot.title = element_marquee(size = 9, width = 1))

## ----eval=should_eval---------------------------------------------------------
md_text_fig <- 
"# Lorem Ipsum ![](https://cran.r-project.org/Rlogo.svg)
Lorem ipsum dolor {.red sit amet, *consectetur* adipiscing elit, sed do} eiusmod tempor
incididunt ut labore et dolore magna **aliqua**. Ut enim ad minim {#2af veniam}, quis nostrud
exercitation ul lamcolaboris nisi ut aliquip ex ea commodo _consequat_. Duis aute irure dolor
in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla ~pariatur~. Excepteur
sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est
laborum."

grid.draw(marquee_grob(md_text_fig, classic_style()))

## ----fig.asp=1.3, eval=should_eval--------------------------------------------
md_text_fig2 <- 
"# Lorem Ipsum 

![](https://cran.r-project.org/Rlogo.svg)

Lorem ipsum dolor {.red sit amet, *consectetur* adipiscing elit, sed do} eiusmod tempor
incididunt ut labore et dolore magna **aliqua**. Ut enim ad minim {#2af veniam}, quis nostrud
exercitation ul lamcolaboris nisi ut aliquip ex ea commodo _consequat_. Duis aute irure dolor
in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla ~pariatur~. Excepteur
sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est
laborum."

grid.draw(marquee_grob(md_text_fig2, classic_style()))

## ----fig.asp=1.1, eval=should_eval--------------------------------------------
p <- ggplot(mtcars) + 
  geom_histogram(aes(x = gear))


md_text_plot <- 
"# Lorem Ipsum 

![](p)

Lorem ipsum dolor {.red sit amet, *consectetur* adipiscing elit, sed do} eiusmod tempor
incididunt ut labore et dolore magna **aliqua**. Ut enim ad minim {#2af veniam}, quis nostrud
exercitation ul lamcolaboris nisi ut aliquip ex ea commodo _consequat_. Duis aute irure dolor
in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla ~pariatur~. Excepteur
sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est
laborum."

grid.draw(marquee_grob(md_text_plot, classic_style()))

## ----collapse=TRUE------------------------------------------------------------
library(gt)
airquality_m <- airquality[1:10, ]
airquality_m$Year <- 1973L
table <- gt(airquality_m)
table <- tab_header(table, 
  title = "New York Air Quality Measurements",
  subtitle = "Daily measurements in New York City (May 1-10, 1973)"
)
table <- tab_spanner(table, 
  label = "Time",
  columns = c(Year, Month, Day)
)
table <- tab_spanner(table,
  label = "Measurement",
  columns = c(Ozone, Solar.R, Wind, Temp)
)

## ----fig.asp=1.1, eval=should_eval--------------------------------------------
md_text_table <- 
"# Lorem Ipsum 
Below we have a table created with gt

![](table)

*Such tables, much cells*"

grid.draw(marquee_grob(md_text_table, classic_style()))

