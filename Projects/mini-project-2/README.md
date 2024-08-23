
# Mini Project 2: Web Scraping and Interactive Visualization with Shiny

## Due date

This mini project is due on GitHub by Sunday, May 26, at midnight.

## Project Description

In this integrated project, you and a partner will collaborate to both
scrape data from the web and create an interactive Shiny application
that narrates a compelling story with the data. This project aims to
leverage both web scraping techniques and interactive visualization to
provide insightful analysis and presentation.

**Objectives:**

1.  **Web Scraping**: Define your own research questions based on an
    interesting topic of your choice. Utilize web scraping techniques to
    gather data from one or more of the suggested webpages. This data
    should form the basis for the analysis in your Shiny app.

2.  **Shiny Application**: Develop a Shiny app that utilizes the data
    obtained from your web scraping effort. The app should include at
    least one interactive visualization and one interactive data table.
    Each component should add depth to the story you are telling with
    your data.

**Project Workflow:**

- **Data Acquisition**: Use the `rvest` and `polite` packages to scrape
  data. Ensure that you scrape data into a form that can be directly
  utilized in your Shiny app.
- **Data Processing**: Clean and prepare your data using the techniques
  learned in this course. The data should be well-organized and ready
  for visualization.
- **Shiny App Development**: Use `shiny`, `shinydashboard`,`ggplotly`,
  `DT`, and other R packages to create interactive visualizations and
  tables. The app should be user-friendly and informative, providing
  insights into the data you have collected.
- **Narrative and Analysis**: Within your Shiny app, include textual
  descriptions or a dedicated tab that explains the data and your
  analysis. This should tell a story and answer the research questions
  you’ve posed.

## Final Submission

Upload both your R Markdown (.Rmd) file used for data scraping and the
Shiny app code to GitHub. Additionally, deploy your Shiny app using
platforms such as shinyapps.io and provide a link to the live app in
your GitHub repository. Ensure that the repository contains clear README
documentation on how the app can be run locally and what each file in
the repository is used for.

## Data

You could use any of the following webpages for data scraping:

- [Sports Reference](https://www.sports-reference.com/)
- [MLB Batting
  Leaders](https://www.espn.com/mlb/history/leaders/_/breakdown/season/year/2022/)
- [MLB Team Payrolls](http://www.stevetheump.com/Payrolls.htm)
- [NBA Reference](https://www.basketball-reference.com/)
- [NFL Player Stats](https://www.nfl.com/stats/player-stats/)
- [Premier League
  Stats](https://fbref.com/en/comps/9/stats/Premier-League-Stats)
- [USA Facts](https://usafacts.org/)
- [Yahoo Finance](https://finance.yahoo.com/)
- [Market
  Watch](https://www.marketwatch.com/tools/stockresearch/globalmarkets/intindices.asp)
- [Wikipedia: Your favorite
  series](https://en.wikipedia.org/wiki/List_of_CSI:_Crime_Scene_Investigation_episodes)
- [FRED Economic Data: Federal Reserve Bank of
  St. Louis](https://fred.stlouisfed.org/)
- [International Monetary Fund: World Economic Outlook
  Database](https://www.imf.org/en/Publications/SPROLLs/world-economic-outlook-databases)
- [FiveThirtyEight](https://data.fivethirtyeight.com/)
- [Global economy](https://www.theglobaleconomy.com/)
- [World Bank Open Data](https://data.worldbank.org/)
- [Eurostat Statistics](https://ec.europa.eu/eurostat/web/main)
- [The Global Economy](https://www.theglobaleconomy.com/)
- [Statista](https://www.statista.com/)
- [U.S. Census Bureau](https://www.census.gov/data.html)

This is not an exhaustive list of webpages from which you can scrape
data. You are allowed to use any other legally scrapable webpages that
are not on this list.

## Grading Rubric

Each component contributes to a combined total of 100 points. Points are
distributed to emphasize both the technical execution and the effective
communication of the project’s results.

### Technical aspects (40 points)

| Topic                            | Excellent: 10                                                                     | Good: 7.5                                                     | Satisfactory: 5                                        | Needs work: 2.5                                      |
|----------------------------------|-----------------------------------------------------------------------------------|---------------------------------------------------------------|--------------------------------------------------------|------------------------------------------------------|
| Coding Style                     | Code is well commented, adheres to style guidelines, demonstrates sophistication. | Mostly adheres to style, minor inconsistencies.               | Code readable, some errors in style and substance.     | Many style errors, difficult to read.                |
| Coding Strategy                  | Efficient, correct, minimal code, appropriate structures, error checking.         | Mostly efficient, minimal deviations, appropriate structures. | Correct but verbose, some inappropriate structures.    | Repetitive, inefficient, error-prone.                |
| Achievement, Mastery, Creativity | Beyond expected scope, extraordinary effort, advanced techniques.                 | High level of mastery, high effort.                           | Competent use of tools, conservative ambition.         | Limited scope, insufficient mastery.                 |
| Ease of Access and Compliance    | Code runs flawlessly, excellent adherence to submission conventions.              | Minor issues in running code, mostly adheres to conventions.  | Some issues with code execution, acceptable adherence. | Significant issues with code execution or adherence. |

### Data Wrangling and Web Scraping (20 points)

| Topic          | Excellent: 10                                       | Good: 7.5                                     | Satisfactory: 5                                | Needs work: 2.5                                |
|----------------|-----------------------------------------------------|-----------------------------------------------|------------------------------------------------|------------------------------------------------|
| Web Scraping   | Extraordinary effort, advanced scraping techniques. | Competent and creative use of scraping tools. | Basic scraping correctly implemented.          | Struggles with basic scraping techniques.      |
| Data Wrangling | Advanced manipulation and transformation of data.   | Effective use of wrangling techniques.        | Basic data manipulation correctly implemented. | Basic manipulation techniques poorly executed. |

### Shiny App (20 points)

| Section       | Excellent: 10                                                | Good: 7.5                                          | Satisfactory: 5                                 | Needs work: 2.5                                  |
|---------------|--------------------------------------------------------------|----------------------------------------------------|-------------------------------------------------|--------------------------------------------------|
| Interactivity | Advanced interactivity, sophisticated use of Shiny features. | Effective interactivity, creative use of features. | Basic interactivity implemented correctly.      | Limited or flawed interactivity.                 |
| Layout        | Exceptionally well-designed layout and user experience.      | Well-designed layout, minor issues.                | Acceptable layout, some user experience issues. | Poor layout, significant user experience issues. |

### Communication (20 points)

| Topic             | Excellent: 5                                                                  | Good: 3                                          | Satisfactory: 2                                            | Needs work: 1                                  |
|-------------------|-------------------------------------------------------------------------------|--------------------------------------------------|------------------------------------------------------------|------------------------------------------------|
| Data Introduction | Engaging and clear data introduction and story setup.                         | Clear introduction, slightly lacking engagement. | Introduction present but lacks clarity or engagement.      | Vague or missing introduction.                 |
| Results           | Clear, engaging explanation of results, insightful discussion of limitations. | Clear results, minor issues in discussion.       | Results explained, limitations mentioned but not explored. | Unclear results, no discussion of limitations. |
