# KNN
#install.packages(c("class", "gmodels"))

## collecting data
wbcd <- read.csv("/home/francisco/learn/MLwR/9781782162148_code/2148OS_code/chapter 3/wisc_bc_data.csv",
                 stringsAsFactors = F)
wbcd <- wbcd[-1]
wbcd$diagnosis <- factor(wbcd$diagnosis, labels=c("Benigno", "Maligno"), levels = c("B", "M"))

## exploring and preparing the data
normalize <- function(x){
    return ((x - min(x)) / (max(x) - min(x)))
}

wbcd_n <- as.data.frame(lapply(wbcd[-1], normalize))

wbcd_train <- wbcd_n[1:469,]
wbcd_test  <- wbcd_n[470:569,]

wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels  <- wbcd[470:569, 1]

## training a model on the data
library(class)
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=21)

## evaluating model performance
library(gmodels)
CrossTable(x = wbcd_test_labels, 
           y=wbcd_test_pred,
           prop.r = F, 
           prop.t = F, 
           prop.chisq = F)
