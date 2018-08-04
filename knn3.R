wbcd <- read.csv("/home/francisco/learn/MLwR/9781782162148_code/2148OS_code/chapter 3/wisc_bc_data.csv",
                 stringsAsFactors = F)
wbcd <- wbcd[-1]

normalize <- function(x){
    ((x - min(x)) / (max(x) - min(x)))
}

wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

wbcd_train <- wbcd_n[1:469,]
wbcd_test  <- wbcd_n[470:569,]

wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels  <- wbcd[470:569, 1]

library(class)
library(gmodels)

wbcd_test_pred <- knn(wbcd_train, wbcd_test, cl=wbcd_train_labels, k=21)

CrossTable(
    x=wbcd_test_labels,
    y=wbcd_test_pred,
    prop.chisq = F,
    prop.r = F,
    prop.t = F
)
