***Copyright Matthew Dobson
***MIT License 2019

***Building a small logit model to identify factors that may have contributed to fatalities on the titanic
import delimited /Users/mdobs/projects/titanic/train.csv, clear 

***Generate our variables
gen is_male = (sex == "male")
gen is_female = (is_male == 0)
gen is_adult = (age > 16)
gen no_parents = (is_adult == 0 & parch == 0)
gen has_children = (is_adult & parch > 0)
gen travel_with_family = (sibsp > 0)

**Run a simple logit using the SES proxy and if there is any parents on board
logit survived pclass no_parents
estat class

**Run a more complex logit with a few interactions for females with different 
**Levels of family
logit survived pclass is_adult c.is_female##c.parch c.is_female##c.sibsp 

**Look at marginal change
margins, dydx(sibsp) at(parch=(3(1)8)) noatlegend

**Make a marginsplot
marginsplot
