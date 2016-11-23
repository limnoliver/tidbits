# ==================================
# PURPOSE
# This code generates an effect size for predictors from
# a random forest model. This approach was used in 
# Read et al. (2015) Ecological Applications 25(4), 943-955
# ==================================

# set data and model
# mod = randomForest model
# d.var = dependent or response variable
# i.var = independent or predictor variable
# dat = dataframe used as input to randomForest model

# calculate the interquartile range of the response variable
# IQR is somewhat arbitrary - can be customized 
dvar.iqr = quantile(d.var,c(.25,.75)) 
dvar.range <- dvar.iqr[2]-dvar.iqr[1]

# save the partial plot output
pplot<-partialPlot(mod,dat,i.var)

# find the range of the response from each partial plot
# this is the range in the response where the predictor
# has an effect

pplot.range <- range(pplot$y)
pplot.range <- pplot.range[2]-pplot.range[1]

# calculate the effect size as the ratio of the 
# range at which the predictor affects the response to the
# range in predictor 

effect size <- pplot.range/dvar.range
