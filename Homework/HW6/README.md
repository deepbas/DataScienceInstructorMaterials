Individual homework 6
================

## Please push your assignment to GitHub by 10:00 pm (Central) Tuesday, May 14.

You are currently in the GitHub repository (repo) for `hw6-username`.
The assignment prompt is shown below (i.e. in `README.Rmd`). You can
view this online in your homework 6 GitHub repository as a Markdown
file(`README.md`) or a pdf.

Please **use `hw6.Rmd` to complete this assignment**. You may **knit to
html** or just push the .Rmd and other associated files for this
assignment.

## Homework process

For help on the homework process, review

- [Assignments in Stat
  220](https://stat220-spring24.netlify.app/assignments) for
  content/formatting questions.

- [GitHub Guide for Students in Stat
  220](https://stat220-spring24.netlify.app/github_tutorial) for Git and
  Github instructions.

When you are done with your homework, **don’t forget to push your
changes to ALL files back to GitHub!** This means you should commit and
push all related files, not just your final PDF. Additionally, ensure
you post the link to your **GitHub repository to Gradescope for the
final submission and grading**. This step is crucial as it allows for a
comprehensive review of both your code and the rendered output

------------------------------------------------------------------------

## Assignment prompt

## Problem 1: Crimes

Scrape the table of data found at
<https://en.wikipedia.org/wiki/List_of_United_States_cities_by_crime_rate>
and create a plot showing property crime rate (total property crime)
vs. violent crime rate (total violent crime). Identify outlier cities by
using a plotting command similar to the one below. (Don’t blindly use
this without thinking about the column names.)

``` r
ggplot(crimes, aes(x = violent_crime, y = property_crime, label = city)) +
    geom_point() +
    geom_text(
      data = filter(crimes, violent_crime > 1500 | property_crime > 6500), 
      check_overlap = TRUE, size = 2.5, nudge_y = 40
    )
```

Hints:

- After reading in the table using `html_table()`, create a data frame
  with just the columns you want using column numbers. Otherwise, R gets
  confused (and will likely crash) since it appears as if several
  columns all have the same column name. It may also be useful to use
  `tibble::as_tibble(.name_repair = "unique")` for duplicate column
  names and `janitor::clean_names()` for clean names. Use informative
  column names, get rid of unneeded rows, parse columns into proper
  format, etc.

------------------------------------------------------------------------

## Problem 2: Movie scraping

The web site [Box Office Mojo](http://www.boxofficemojo.com) gives
statistics on box office earnings of movies. In addition to daily
earnings, the web site also maintains lists of yearly and all time
record holders.

We will start with a look at the movies in the top 100 of all time movie
worldwide grosses in box office receipts. In particular, we will scrape
the data from [Box Office Mojo: All Time Box
Office](https://www.boxofficemojo.com/chart/ww_top_lifetime_gross/?offset=0&area=XWW).
The dollar amounts are in millions of dollars and the years marked with
“^” indicate that the movie had multiple releases.

### a.

Read in the data from page 1 using the `read_html` command, extract the
html tables, then parse them into data frames. How many HTML tables are
on the page?

``` r
url <- "https://www.boxofficemojo.com/chart/ww_top_lifetime_gross/?offset=0&area=XWW"
```

### b.

Extract the box office earnings data frame from the list found in (a).
Clean up variable names by renaming columns to be: “rank”, “title”,
“world_dollars”,“domestic_dollars”, “domestic_percentage”,
“overseas_dollars”, “overseas_percentage”, “year”.

### c. 

Most columns with numeric type variables are actually character columns
because of extra characters (dollar or percent signs, commas, other
random characters). Clean up the columns with these issues and change
their type to numeric rather than character.

### d. 

Using `html_nodes` to pull the anchor tags `a` from the html table of
box office earnings that you found in part (a) (before turning it into a
data frame table). Then use `html_attr` to get the url link (`href`) for
the movie Titanic. (Note: the link is a page on
`http://www.boxofficemojo.com`) Report the position number in the anchor
or url vector that contains the Titanic URL and report the entire URL.

### e.

The website contains 5 pages of the “top slightly more than 1000”
grossing movies (about 200 per page). The basic format for their url
links is shown in `tempUrl` where `#` is just a placeholder for starting
movie rank where a `#` of 0 starts with top ranking of 1, a `#` of 200
starts with a top ranking of 201. (Fill in a 200 in the `#` spot and
verify that the url works to get movies 201-400. )

``` r
temp_url <- "https://www.boxofficemojo.com/chart/ww_top_lifetime_gross/?offset=#&area=XWW"
```

Write a function called that `pull_table` that returns a data frame
constructed from one of these pages. This function should have input and
outputs:

- input: a url (like `temp_url` but with a \# plugged in)
- output: a parsed data frame with column names as defined in part (c)
  and with *all* columns parsed as numbers *except* for `title`
  - you can directly parse columns 3-7 into numbers
  - one of the pages will result in a character data type for `rank`
    (because of commas) but others will be integer. Create a condition
    in your function that checks for a character data type for `rank`
    and parses it to a number (with `parse_number`) if needed. (Note:
    `parse_integer` can’t parse a number like “1,000” so we need to use
    `parse_number`)

Test your function on the first page with \# of 800 in `temp_url`

### f. 

Create a vector containing the URLs for the 5 pages of the “top slightly
more than 1000” grossing movies, then use a `purrr` mapping function to
create a data frame of all top movies. Do not use a `for` loop for this
question.

- use a function from `stringr` to create the vector of URLs with the \#
  replaced by the values 0, 200, 400, 600, and 800. (don’t type out all
  URLS by hand)
- make sure your data frame is a `tibble` and print out a `glimpse` of
  it

## Problem 3: Penguins

Let’s revisit the Palmer penguins data. The following scatterplot
compares bill length to body mass using a Shiny app structure. This
isn’t an interactive graph yet, and below you will be modifying this
basic app structure to create interactive versions of this graph.

``` r
ui <- fluidPage(
  plotOutput("plot", height = 500)
)

server <- function(input, output){
  output$plot <- renderPlot({
    g <- ggplot(penguins, aes(x = bill_length_mm, y = body_mass_g)) 
    g + geom_point()
  })
}

# you can modify the height to avoid scrolling
shinyApp(ui, server, options = list(height = 600))
```

### a.

Copy the code above to your homework answers .Rmd, then modify the app
to include a checkbox input that allows you to toggle between the graph
with and without points colored by `species`. The main steps of this
should be:

- Add the `checkboxInput` input object in the `ui` that will allow you
  to add (or omit) color. Run this app to make sure your input object
  works.
- Then using the input value from the checkbox to modify the graph
  rendered, to include color when checked and exclude color when
  unchecked.

### b.

Copy your part (a) code here, then modify it to use `varSelectInput` to
select x- and y-axis variables from columns 3-6 in `penguins`. Recall
the Intro to Shiny example, you will need to use the `!!` (“bang-bang”)
to substitute the server input value with a variable from the data frame
used in a ggplot.

### c. 

Again, copy your app code from part (b) to this question. The goal of
this part is to allow the app user to click on a point to see the data
associated with the case (or cases) near the clicked region.

- Check the help file for `plotOutput` and look at the `click` argument
  option.
  - This option allows a user to *interact* with a rendered object
    (plot).
  - If we let `click = "my_click"`, then `input$my_click` will be an
    **input** value return returned by the click action that contains
    the coordinations (x/y) of the clicked point.
  - The function `nearPoints(my_data, input$my_click)` will return a
    data frame of data cases “near” the input coordinates.
- Use the `dataTable` render and output commands to add a data table of
  data points near your click below your scatterplot.

### d. 

Again, copy your app code from part (c) to this question. The goal of
this part is to allow the app user to **brush** a region to see the data
associated with the case (or cases) inside the brushed region.

To do this, modify your part (c) code to change from a “click” to a
“brush”. Use the `brushedPoints` function instead of `nearPoints`.

------------------------------------------------------------------------

## Probelm 4: Storm paths

Revisit the storm path problem from homework 2. Here is the basic map
without a year facet and color.

``` r
ctry <- map_data("world", 
                 region = c(
                   "usa",
                   "mexico",
                   "canada",
                   "uk"
                 ))
base_map <- ggplot(ctry) +  
  geom_polygon(aes(x = long,  y = lat, group = group)) + 
  labs( 
    x = "longitude", 
    y = "latitude", 
    title = "Atlantic storms paths"
    )  

base_map + 
  geom_path(data = storms, aes(x = long, y = lat, group = name), color = "red") +  
  coord_map(xlim  = c(min(storms$long), max(storms$long)),
            ylim  = c(min(storms$lat), max(storms$lat)))
```

### a.

Select one storm and filter your data to that storm and add in an
elapsed time (hour) variable that measures the number of hours that has
elapsed since the first lat/lon measurement. The trace the path of the
storm with an animated `sliderInput`.

### b.

Use `selectInput` to draw a storm path map that lets the user select the
storm of interest. You don’t need to animate this path. Note that the
input value returned by this input option is a character string. (Use
this info to filter the data based on the user selected storm.)
