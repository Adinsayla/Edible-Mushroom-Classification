#Import libraries 

#Read data
mushroom <- read.csv("mushrooms.csv", stringsAsFactors = TRUE)
names(mushroom)
str(mushroom)
mushroom = mushroom[-1,]
library(tidyverse)

#Data Transformation
summary(mushroom)
# Rename the variables
colnames(mushroom) <- c("cap_shape", "cap_surface", 
                        "cap_color", "bruises", "odor", 
                        "gill_attachement", "gill_spacing", "gill_size", 
                        "gill_color", "stalk_shape", "stalk_root", 
                        "stalk_surface_above_ring", "stalk_surface_below_ring", "stalk_color_above_ring", 
                        "stalk_color_below_ring", "veil_type", "veil_color", 
                        "ring_number", "ring_type", "spore_print_color", 
                        "population", "habitat","edibility")
names(mushroom)

## We redefine each of the category for each of the variables
levels(mushroom$edibility) <- c("edible", "poisonous")
levels(mushroom$cap_shape) <- c("bell", "conical", "flat", "knobbed", "sunken", "convex")
levels(mushroom$cap_color) <- c("buff", "cinnamon", "red", "gray", "brown", "pink", 
                                "green", "purple", "white", "yellow")
levels(mushroom$cap_surface) <- c("fibrous", "grooves", "scaly", "smooth")
levels(mushroom$bruises) <- c("no", "yes")
levels(mushroom$odor) <- c("almond", "creosote", "foul", "anise", "musty", "none", "pungent", "spicy", "fishy")
levels(mushroom$gill_attachement) <- c("attached", "free")
levels(mushroom$gill_spacing) <- c("close", "crowded")
levels(mushroom$gill_size) <- c("broad", "narrow")
levels(mushroom$gill_color) <- c("buff", "red", "gray", "chocolate", "black", "brown", "orange", 
                                 "pink", "green", "purple", "white", "yellow")
levels(mushroom$stalk_shape) <- c("enlarging", "tapering")
levels(mushroom$stalk_root) <- c("missing", "bulbous", "club", "equal", "rooted")
levels(mushroom$stalk_surface_above_ring) <- c("fibrous", "silky", "smooth", "scaly")
levels(mushroom$stalk_surface_below_ring) <- c("fibrous", "silky", "smooth", "scaly")
levels(mushroom$stalk_color_above_ring) <- c("buff", "cinnamon", "red", "gray", "brown", "pink", 
                                             "green", "purple", "white", "yellow")
levels(mushroom$stalk_color_below_ring) <- c("buff", "cinnamon", "red", "gray", "brown", "pink", 
                                             "green", "purple", "white", "yellow")
levels(mushroom$veil_type) <- "partial"
levels(mushroom$veil_color) <- c("brown", "orange", "white", "yellow")
levels(mushroom$ring_number) <- c("none", "one", "two")
levels(mushroom$ring_type) <- c("evanescent", "flaring", "large", "none", "pendant")
levels(mushroom$spore_print_color) <- c("buff", "chocolate", "black", "brown", "orange", 
                                        "green", "purple", "white", "yellow")
levels(mushroom$population) <- c("abundant", "clustered", "numerous", "scattered", "several", "solitary")
levels(mushroom$habitat) <- c("wood", "grasses", "leaves", "meadows", "paths", "urban", "waste")
glimpse(mushroom)


#Check classes each variable
#Checking missing values
map_dbl(mushroom, function(.x) {sum(is.na(.x))})

table(mushroom$edibility)
plot(mushroom$edibility)


#number of rows, number of levels 
number_class <- function(x){
  x <- length(levels(x))
}
#drop factor variable with only one level
mushroom <- mushroom %>% select(- veil_type)
View(mushroom)

# Draw the histogram
library(ggplot2)
library(gridExtra)

ggplot(data = mushroom) + geom_bar(mapping = aes(x = cap_color))
ggplot(data = mushroom) + geom_histogram(mapping = aes(x = odor), binwidth = 0.2)

library(knitr)
mush_features <- colnames(mushroom)[-1]
grid <- expand.grid(mush_features, mush_features, stringsAsFactors = FALSE)
grid = grid %>% filter(Var1 != Var2)
chunk <- nrow(grid)/length(mush_features)
gp <- invisible(lapply(mush_features, function(x) { 
  ggplot(data=mushroom, aes(x = eval(parse(text=x)), fill = edibility)) + geom_bar() + xlab(x) + scale_fill_manual("legend", values = c("e" = "darkgreen", "p" = "red")) + ggtitle("")}))
grob_plots <- invisible( lapply (opts_chunk$set (1, length(gp), 4), function(x) {
  marrangeGrob(grobs=lapply(gp[x], ggplotGrob), nrow=2, ncol=2)}))
grob_plots

table_res <- lapply(mush_features, function(x) {table(mushroom$edibility, mushroom[,x])})
names(table_res) <- mush_features
table_res



m1 <- ggplot(aes(x = cap_shape), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Cap Shape")

m3 <- ggplot(aes(x = cap_color), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Cap Color")

m2 <- ggplot(aes(x = cap_surface), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Cap Surface")

m4 <- ggplot(aes(x = bruises), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Bruises")

m5 <- ggplot(aes(x = odor), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Odor")

m6 <- ggplot(aes(x = gill_attachement), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Gill Attachemnt")
grid.arrange(m1, m2, m3, m4, m5, m6, ncol = 2)

m7 <- ggplot(aes(x = gill_spacing), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Gill Spacing")

m8 <- ggplot(aes(x = gill_size), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Gill Size")

m9 <- ggplot(aes(x = gill_color), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Gill Color")

m10 <- ggplot(aes(x = stalk_shape), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Stalk  Shape")

m11 <- ggplot(aes(x = stalk_root), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Stalk Root")

m12 <- ggplot(aes(x = stalk_surface_above_ring), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Stalk Surface Above Ring")

grid.arrange(m7, m8, m9, m10, m11, m12, ncol = 2)

m13 <- ggplot(aes(x = stalk_surface_below_ring), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Stalk Surface Below Ring")

m14 <- ggplot(aes(x = stalk_color_above_ring), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Stalk Color Above Ring")

m15 <- ggplot(aes(x = stalk_color_below_ring), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Stalk Color Below Ring")

m16 <- ggplot(aes(x = veil_type), data = mushroom) +
  geom_histogram(stat = "count") +
  xlab("Veil Type")

m17 <- ggplot(aes(x = veil_color), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Veil Color")

m18 <- ggplot(aes(x = ring_number), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Ring Number")
grid.arrange(m13, m14, m15, m16, m17, m18, ncol = 2)

m19 <- ggplot(aes(x = ring_type), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Ring Type")

m20 <- ggplot(aes(x = spore_print_color), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Spore Print Color")

m21 <- ggplot(aes(x = population), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Population")

m22 <- ggplot(aes(x = habitat), data = mushroom) +
  geom_histogram(stat = "count") +
  facet_wrap(~edibility) +
  xlab("Habitat")
grid.arrange(m19, m20, m21, m22, ncol = 2)


#multivariate EDA for categorical variables 
#chi square test
library(MASS)

tbl1 <- table(mushroom$edibility, mushroom$cap.shape)
chisq.test(tbl1)


library(ggplot2)
ggplot(data = mushroom) + geom_count(mapping = aes(x = cap_surface, y = cap_color)) 
ggplot(mushroom, aes(x = cap_surface, y = cap_color, col = edibility)) + 
  geom_jitter(alpha = 0.5) + 
  scale_color_manual(breaks = c("edible", "poisonous"), 
                     values = c("green", "red"))
ggplot(data = mushroom) + geom_count(mapping = aes(x = cap_shape, y = cap_color)) 
ggplot(mushroom, aes(x = cap_shape, y = cap_color, col = edibility)) + 
  geom_jitter(alpha = 0.5) + 
  scale_color_manual(breaks = c("edible", "poisonous"), 
                     values = c("green", "red"))

ggplot(data = mushroom) + geom_count(mapping = aes(x = gill_color, y = cap_color)) 
ggplot(mushroom, aes(x = gill_color, y = cap_color, col = edibility)) + 
  geom_jitter(alpha = 0.5) + 
  scale_color_manual(breaks = c("edible", "poisonous"), 
                     values = c("green", "red"))

ggplot(data = mushroom) + geom_count(mapping = aes(x = edibility, y = odor)) 
ggplot(mushroom, aes(x = edibility, y = odor, col = edibility)) + 
  geom_jitter(alpha = 0.5) + 
  scale_color_manual(breaks = c("edible", "poisonous"), 
                     values = c("green", "red"))

ggplot(data = mushroom) + geom_count(mapping = aes(x = cap_color, y = odor)) 
ggplot(mushroom, aes(x = cap_color, y = odor, col = edibility)) + 
  geom_jitter(alpha = 0.5) + 
  scale_color_manual(breaks = c("edible", "poisonous"), 
                     values = c("green", "red"))



#split the data into a training and testing set
set.seed(1810)
mushsample <- caret::createDataPartition(y = mushroom$edibility, times = 1, p = 0.8, list = FALSE)
train_mushroom <- mushroom[mushsample, ]
test_mushroom <- mushroom[-mushsample, ]

#use of SVM
library(e1071)
model_svm <- svm(edibility ~. , data=train_mushroom, cost = 1000, gamma = 0.01)


#Check the prediction
test_svm <- predict(model_svm, newdata = test_mushroom %>% na.omit())
yo <- test_mushroom %>% na.omit()
table(test_svm, yo$edibility)

install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)

#Decision Tree
model_tree <- rpart(edibility ~ ., data = train_mushroom, method = "class")
model_tree
rpart.plot(model_tree, extra = 106)
caret::confusionMatrix(data=predict(model_tree, type = "class"), 
                       reference = train_mushroom$edibility, 
                       positive="edible")
model_nb <- naiveBayes(edibility ~. , data=train_mushroom)
model_nb

#Check the prediction
test_nb <- predict(model_nb, newdata = test_mushroom %>% na.omit())
yo <- test_mushroom %>% na.omit()
table(test_nb, yo$edibility)

TN <- 3367
FN <- 38
FP <- 0
TP <- 3095

Acc <- (TP + TN) / (TP + TN + FP + FN)
View(Acc)
