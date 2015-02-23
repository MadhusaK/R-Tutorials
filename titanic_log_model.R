titanic = read.csv("H:/R tutorial/train.csv")
test = read.csv("H:/R tutorial/test.csv")
print(names(titanic))

# Create a logistic model with the features:Sex, Age, Fare, Pclass
# family="binomial" makes sure Logistic Regression is run, else R defaults to a guassian process                                   
attach(titanic)
log_mod = glm(Survived~Sex+Age+Pclass,family="binomial") 

# Now we create our list of probabilities using 
prob = predict(log_mod, titanic, type="response")

# Create a vector to store the outcomes with default "0" values
pred = rep(0,891)

# Filter by our predictor
pred[prob > 0.5]= 1

# The leading diagonal shows how much we got right, 
# whilst the off diagonal shows how many we got wrong
print(table(pred, Survived))

# Or more conveniently...
print(mean(pred==Survived))
detach(titanic)

# Now lets try with our test data
attach(test)
prob = predict(log_mod, test, type = "response")

pred = rep(0,418)

pred[prob > 0.5] = 1

print(NROW(pred[pred==1]))

test_resulsts = cbind(test$PassengerId,pred)
colnames(test_resulsts) <- c("PassengerID","Survived")
write.csv(test_resulsts, file = "H:/R tutorial/Test_Results.csv", row.names = FALSE)
detach(test)




