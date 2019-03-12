# Clear the environmen

rm(list=ls())

# Load libraries

library(forecast)
library(tseries)

# Load the dataset - replace the address with the one you have put the example csv files in 

df_train = read.csv('C:/Users/raihan.shafique/Documents/R Projects/20190227 Time Series Forecasting Using Neural Net for GitHub/Neural Net/train.csv')
df_test = read.csv('C:/Users/raihan.shafique/Documents/R Projects/20190227 Time Series Forecasting Using Neural Net for GitHub/Neural Net/test.csv')


# Conversion of Data frame into time series dataset

df_train_ts = ts(df_train, start=1,frequency = 7)


plot(df_train_ts)


set.seed(34)

# Train the dataset

fit = nnetar(ts(df_train$Y, start=1,frequency = 7),xreg = df_train$X)

# Forecast based on trained model

nnetforecast <- forecast(fit, h = 28, xreg = df_test$X)

# Visualize forecasted data

library(ggplot2)

autoplot(nnetforecast)

# Observe the predicted value
nnetforecast$mean

# Convert predicted value to a Dataframe

prediction = as.data.frame(nnetforecast$mean)

colnames(prediction) = 'Predicted'

prediction = cbind(df_test$DATE, prediction)

# Write predicted value in a csv file

write.csv(prediction,'C:/Users/raihan.shafique/Documents/R Projects/20190227 Time Series Forecasting Using Neural Net for GitHub/Neural Net/prediction.csv')
