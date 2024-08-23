Individual homework 8
================

## Please push your assignment to GitHub by 10:00 pm (Central) Wednesday, May 24.

You are currently in the GitHub repository (repo) for `hw8_username`.
The assignment prompt is shown below (i.e. in `README.Rmd`). You can
view this online in your homework 8 GitHub repository as a Markdown
file(`README.md`) or a pdf.

Please **use `hw8.Rmd` to complete this assignment**. Be sure to **knit
your file to PDF before your final push to GitHub**.

## Homework process

For help on the homework process, review

- [Assignments in Stat
  220](https://stat220-spring23.netlify.app/assignments.html) for
  content/formatting questions.

- [GitHub Guide for Students in Stat
  220](https://stat220-spring23.netlify.app/github.html) for Git and
  Github instructions.

When you are done with your homework, **don’t forget to push your
changes to ALL files back to GitHub**! (e.g. commit and push all files,
not just your final pdf/html)

------------------------------------------------------------------------

## Assignment prompt

## Problem 1: Random guessing

Suppose you have $n$ observations and you would like to construct a
classifier to predict positive outcomes. We know that $n_N$ are actually
negative cases and $n_P$ are actually positive cases.

Suppose we are a lazy data scientist and don’t actually build a model
with predictors to classify our cases. Instead, we use a fair coin to
classify negative and positive cases! This “coin classifier” will result
in an even split between *expected* positive and negative predictions:

$$
\hat{n}_N = \hat{n}_P = \dfrac{n}{2}
$$ Using the same logic, half of the actual failures will be successes
and failures: $$
TN = FP = \dfrac{n_N}{2}
$$ and half of the actual successes will be successes and failures: $$
FN = TP = \dfrac{n_P}{2}
$$

| confusion matrix | truth negative      | truth positive       | total                     |
|------------------|---------------------|----------------------|---------------------------|
| predict negative | $TN=\dfrac{n_N}{2}$ | $FN= \dfrac{n_P}{2}$ | $\hat{n}_N =\dfrac{n}{2}$ |
| predict positive | $FP=\dfrac{n_N}{2}$ | $TP= \dfrac{n_P}{2}$ | $\hat{n}_P =\dfrac{n}{2}$ |
| total            | $n_N$               | $n_P$                | $n$                       |

### a.

Use the “coin classifier” confusion matrix above to compute accuracy,
precision, sensitivity, and specificity for this fair coin prediction
method.

### b.

Consider another classification method that doesn’t actually build a
model with predictors to classify our cases. Instead, we now predict all
cases to be positive! (e.g. a biased coin that lands “positive” with
probability 1)

Construct the confusion matrix for this classifier and compute accuracy,
precision, sensitivity, and specificity.

### c. 

Under what conditions in part (b) will accuracy of this classifier be
highest? Under what conditions in part (b) will accuracy of this
classifier be lowest?

### d. 

Describe the trade-off in part (b) in specificity vs sensitivity. What
would these values be if instead of classifying every case as positive,
you classified all cases as negative?

------------------------------------------------------------------------

## Problem 2: Spam using k-nn

This example looks at a data set of about 4600 emails that are
classified as spam or not spam, along with over 50 variables measuring
different characteristic of the email. Details about these variables are
found on the [Spambase
example](http://archive.ics.uci.edu/ml/datasets/Spambase) on the machine
learning data archive. The dataset linked to below is a slightly cleaned
up version of this data. The only extra column in the data is `rgroup`
which is a randomly assigned grouping variable (groups 0 through 99)
which we will eliminate from the data.

Read the data in using the commands below to create a response `class`
variable that contains the factor levels `spam` and `nonspam` with
`spam` the first level.

``` r
# tsv = tab separated values!
spam <- read_delim("https://raw.githubusercontent.com/deepbas/statdatasets/main/spam.txt", 
        delim="\t")

# some clean up
spam <- spam %>% 
  mutate(class = fct_recode(
    spam, 
    spam = "spam" , 
    nonspam = "non-spam"), # rename levels because caret doesn't like "non-spam" 
    class = fct_relevel(class, "spam") # make "spam" the first level (our "positive")
    ) %>%  
  select(-rgroup, -spam) # don't need random group variable and  spam variable
levels(spam$class)  # verify "spam" is level 1
```

### a.

What proportion of cases are spam in this data set? The variable `class`
is the true classification of an email.

### b.

We want to fit a k-nn classifier for `spam` using the 57 quantitative
predictors (columns 1-57) from the spam data to an 80%/20% training and
test set split. Create the training and test sets to do this.

Use the following seed and the `sample` command generate training data
(this *should* mean your train/test split should be the same as the
solution key!):

``` r
set.seed(757302859)  # set a seed
```

### c. 

Make a recipe for fitting k nearest-neighbor algorithm to the training
data by inputting the formula and the preprocessing steps.

### d. 

Specify the nearest neighbor model to fit a classification model using
10 neighbors.

### e.

Define the workflow object feeding in the recipe and model
specification. Then, fit the model to the training data.

### f.

Evaluate the model on the test dataset and predict `class` for the test
data set.

### g.

Compute the accuracy, sensitivity, specificity and precision for
predicting test set responses. Which rate(s) would you like to be high
as a user of this spam filter?

### h.

Use the `tidymodels` package to do 10-fold cross validation as follows:

- use the 80% training data split from part b.
- tune your knn spam classifier based on accuracy
- consider neighborhood sizes ranging from size 1 to 31

Use the `results` to get the training set cross-validated estimates of
the accuracy, precision, sensitivity and specificity of your final
(“best”) classifier.

And use the following seed before running your `train` command:

``` r
set.seed(30498492)
```

### i.

Use the `results` object from your CV fit from part (i) to plot the
accuracy, precision, sensitivity and specificity for the values of $k$
that you tuned over. Comment on which neighborhood sizes are “best” in
terms of these four metrics (your answer may depend on the metric).

------------------------------------------------------------------------

## Problem 3: Incoming student characteristic

We will look at a “classic” college data set of a random sample of
colleges and universities. To simplify our look at this data, we will
filter to only look at MN, MA, and CA schools

``` r
colleges <- read_csv("https://raw.githubusercontent.com/deepbas/statdatasets/main/Colleges.csv")
names(colleges)
colleges2 <- colleges %>% 
  filter(State %in% c("MN","MA","CA"))
colleges2 %>% count(State)
```

We will also just focus on student body characteristics (incoming class
averages) for SAT and the HS variables (which are are the proportion of
the incoming class that is in the top 10% or 25% of their HS class).
Here we select just these characteristics and college name and state.

``` r
colleges2 <- colleges2 %>% select(1,2,3,4,5,6,7,8)
colleges2
```

Let’s cluster schools by their incoming class characteristics.

### (a)

Why should we standardize the variables of interest before using a
clustering method?

### (b)

Standardize the four quantitative clustering variables (`SATM`, `SATV`,
`HStop10`, `HStop25`).

### (c)

Fit a k-means cluster algorithm to standardized predictors from (b)
using k=5 group centers and 20 different starting locations. Extract the
total within cluster and total sums of squares. Set a seed to make your
results reproducible.

### (d)

Suppose we run `kmeans` with k=3. Will the within cluster variation go
up or down compared to k=5? Explain your answer.

### (e)

Use a `map` family of command to fit 20 different kmean algorithms from
$K=1$ to $K=20$ clusters. Plot the total within cluster SS against the
number of clusters. Which choice of $K$ looks best for grouping these
schools?

### (f)

Fit a k-means clustering with $K = 3$, then add the cluster ID to the
`college2` data frame. Make sure to make this ID a character vector.

### (g)

Clustering methods don’t just determine clusters based on individual
variable values, but how these variables combine will all other
variables (e.g. clusters in $R^4$ space for this problem). We can also
look at a 2-d view of the data using a scatterplot matrix. We will use
the ggplot “add on” package called `GGally`

``` r
library(GGally)   # install if needed
colleges2 %>% 
  ggpairs(aes(color = cluster_km3), 
          columns=c("SATM", "SATV", "HStop10", "HStop25"))
```

Use the graphical EDA above as a starting point to describe the k-means
cluster assignments. (e.g. how to the cluster groupings relate SAT
scores, type of college, etc).
