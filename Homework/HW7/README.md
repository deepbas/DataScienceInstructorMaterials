Individual homework 7
================

## Please push your assignment to GitHub by 10:00 pm (Central) Tuesday, May 21.

You are currently in the GitHub repository (repo) for `hw7-username`.
The assignment prompt is shown below (i.e. in `README.Rmd`). You can
view this online in your homework 7 GitHub repository as a Markdown
file(`README.md`) or a pdf.

Please **use `hw7.Rmd` to complete this assignment**. Be sure to **knit
your file to `pdf` before your final push to GitHub**.

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
test set split. Create the training and test sets to do this. Please use
the following seed.

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

## Problem 3: Logistic Regression

In this problem, you will create a classification model that can predict
the presence of heart disease in individuals based on physical
attributes and test results. By accurately predicting heart disease, the
model can potentially help in reducing the need for more invasive
diagnostic procedures.

``` r
heart_data <- read_csv("https://raw.githubusercontent.com/deepbas/statdatasets/main/heart.csv")
```

### a.

Load and prepare the dataset. Perform necessary preprocessing steps such
as handling missing values, normalizing data, and encoding categorical
variables. Split the dataset into training and testing sets to ensure
the model can be accurately evaluated. The variable `target` is the
outcome with 0 for no presence of heart disease and 1 for presence of
heart disease. Please use the given seed.

``` r
library(tidymodels)
set.seed(123322324)
```

### b.

Fit a logistic regression model using the `tidymodels` framework in R.
Use the `target` variable ‘presence of heart disease’ and include
relevant predictors based on the dataset.

### c.

Plot the confusion matrix. Evaluate your model’s performance by
calculating metrics such as accuracy, sensitivity, specificity, and the
Area Under the Curve (AUC). These metrics will provide insights into how
well the model can distinguish between patients with and without heart
disease.

### d.

Explore the impact of varying classification thresholds on the
prediction of heart disease. Plot the ROC curve, identifying the optimal
threshold by evaluating sensitivity and specificity across a range of
values. Discuss the clinical implications of selecting this threshold,
particularly in terms of balancing false positives and false negatives.

------------------------------------------------------------------------
