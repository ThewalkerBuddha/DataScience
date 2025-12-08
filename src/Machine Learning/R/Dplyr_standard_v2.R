getwd()

setwd("E:\\Locker\\Sai\\SaiHCourseNait\\DecBtch\\R_Datasets")

mydata = read.csv("sampledata.csv")

nrow(mydata)
ncol(mydata)
head(mydata)
mydata
#Selecting Random N Rows
"The sample_n function selects random rows from a data frame (or table). 
The second parameter of the function tells R the number of rows to select."
sample_n(mydata,3)
library(dplyr)

#Selecting Random Fraction of Rows
"The sample_frac function returns randomly N% of rows. 
it returns randomly 10% of rows."
sample_frac(mydata,0.1)

"Remove Duplicate Rows based on all the variables (Complete Row)
The distinct function is used to eliminate duplicates."
x1 = distinct(mydata)
x1

"Remove Duplicate Rows based on a variable
The .keep_all function is used to retain all other variables in the output 
data frame."
x2 = distinct(mydata, Index, .keep_all= TRUE)
x2

"Remove Duplicates Rows based on multiple variables
In the example below, we are using two variables - Index, Y2010 to determine 
uniqueness."
x2 = distinct(mydata, Index, Y2010, .keep_all= TRUE)
x2

"select( ) Function
It is used to select only desired variables.
select() syntax : select(data , ....)
Selecting Variables (or Columns)
select variables "Index", columns from State to Y2008."
head(mydata)
mydata2 = select(mydata, Index, State:Y2008)
head(mydata2)

"Dropping Variables
The minus sign before a variable tells R to drop the variable."
head(mydata)
mydata22 = select(mydata, -Index, -State)
head(mydata22)
mydata23 = select(mydata, -c(Index,State))
head(mydata23)

"Example 8 : Selecting or Dropping Variables starts with 'Y'
The starts_with() function is used to select variables starts with an alphabet.
#mydata3 = select(mydata, starts_with("Y"))
Adding a negative sign before starts_with() implies dropping the variables 
starts with 'Y'"
head(mydata)
mydata33 = select(mydata, -starts_with("Y"))
head(mydata33)

"The following functions helps you to select variables based on their names.
Helpers	Description
starts_with()	Starts with a prefix
ends_with()	Ends with a prefix
contains()	Contains a literal string
matches()	Matches a regular expression
num_range()	Numerical range like x01, x02, x03.
one_of()	Variables in character vector.
everything()	All variables."

"Selecting Variables contain 'I' in their names"
head(mydata)
mydata4 = select(mydata, contains("Y"))
head(mydata4)

"Reorder Variables
keep variable 'State' in the front and the remaining variables follow that."
head(mydata)
mydata5 = select(mydata, State, everything())
head(mydata5)


"rename( ) Function
It is used to change variable name.
rename() syntax : rename(data , new_name = old_name)
data : Data Frame
new_name : New variable name you want to keep
old_name : Existing Variable Name
Rename Variables
The rename function can be used to rename variables.
In the following code, we are renaming 'Index' variable to 'Index1'."
mydata6 = rename(mydata, Index1=Index)
head(mydata6)

"filter( ) Function
It is used to subset data with matching logical conditions.
filter() syntax : filter(data , ....)
data : Data Frame
.... : Logical Condition
Filter Rows
Suppose you need to subset data. You want to filter rows and retain only 
those values in which Index is equal to A."
mydata7 = filter(mydata, Index == "A")
head(mydata7)

"Multiple Selection Criteria
The %in% operator can be used to select multiple items. 
In the following we are telling R to select rows against 'A' and 'C' in 
column 'Index'."
mydata7 = filter(mydata, Index %in% c("A", "C"))
head(mydata7)


"'AND' Condition in Selection Criteria
Suppose you need to apply 'AND' condition. In this case, we are picking data 
for 'A' and 'C' in the column 'Index' and income greater than 1.3 million 
in Year 2002."
mydata8 = filter(mydata, Index %in% c("A", "C") & Y2002 >= 1300000 )
head(mydata8)

"'OR' Condition in Selection Criteria
The 'I' denotes OR in the logical condition. It means any of the two conditions."
mydata9 = filter(mydata, Index %in% c("A", "C") | Y2002 >= 1300000)
head(mydata9)


"NOT Condition
The "!" sign is used to reverse the logical condition."
mydata10 = filter(mydata, !Index %in% c("A", "C"))
head(mydata10)
head(mydata)


"CONTAINS Condition
The grepl function is used to search for pattern matching. 
look for records wherein column state contains 'Ar' in their name."
mydata10 = filter(mydata, grepl("Ar", State))
head(mydata10)



"summarise( ) Function
It is used to summarize data.
summarise() syntax : summarise(data , ....)
data : Data Frame
..... : Summary Functions such as mean, median etc
Summarize selected variables
Calculate mean and median for the variable Y2015."
summarise(mydata, Y2015_mean = mean(Y2015), Y2015_med=median(Y2015))



"Summarize Multiple Variables
Calculating number of records, mean and median for variables Y2005 and Y2006. 
The summarise_at function allows us to select multiple variables by their names."
summarise_at(mydata, vars(Y2005, Y2006), funs(n(), mean, median))


"Summarize with Custom Functions
we are computing the number of records, number of missing values, mean and median 
for variables Y2011 and Y2012. 
The dot (.) denotes each variables specified in the second argument of the 
function."
summarise_at(mydata, vars(Y2011, Y2012),
             funs(n(), missing = sum(is.na(.)), 
                                  mean(., na.rm = TRUE), 
                                  median(.,na.rm = TRUE)))

"Non-Standard Functions
subtract mean from its original value and then calculate variance of it."
set.seed(222)
mydata <- data.frame(X1=sample(1:100,100), X2=runif(100))
mydata
summarise_at(mydata,vars(X1,X2), function(x) var(x - mean(x)))


"Summarize all Numeric Variables
The summarise_if function allows you to summarise conditionally."
summarise_if(mydata, is.numeric, funs(n(),mean,median))


"Alternative Method 
First, store data for all the numeric variables"
numdata = mydata[sapply(mydata,is.numeric)]
"Second, the summarise_all function calculates summary statistics for all the 
columns in a data frame"
summarise_all(numdata, funs(n(),mean,median))



"Summarize Factor Variable
We are checking the number of levels/categories and count of missing 
observations in a categorical (factor) variable."
#summarise_all(mydata["Index"], funs(nlevels(.), sum(is.na(.))))
#***



"arrange() function :
  Use : Sort data
arrange(data_frame, variable(s)_to_sort)
or
data_frame %>% arrange(variable(s)_to_sort)
To sort a variable in descending order, use desc(x).
Sort Data by Multiple Variables
The default sorting order of arrange() function is ascending. "
mydata = read.csv("sampledata.csv")
head(mydata)
arrange(mydata, Index, Y2011)

"Suppose you need to sort one variable by descending order and 
other variable by ascending oder."
arrange(mydata, desc(Index), Y2011)




"Pipe Operator %>%
dplyr utilizes pipe operator from another package (magrittr).
It allows you to write sub-queries like we do it in sql.
Note : All the functions in dplyr package can be used without the pipe operator. 
it lets to wrap multiple functions together with the use of  %>%.

Syntax :
  filter(data_frame, variable == value)
or
data_frame %>% filter(variable == value)
The %>% is NOT restricted to filter function. It can be used with any function. "
#selecting 10 random observations of two variables "Index" "State" 
#from the data frame "mydata".
dt = sample_n(select(mydata, Index, State),10)
dt
or 
dt = mydata %>% select(Index, State) %>% sample_n(10)
dt




"group_by() function :
  Use : Group data by categorical variable
  group_by(data, variables)
or
data %>% group_by(variables)
Summarise Data by Categorical Variable
We are calculating count and mean of variables Y2011 and Y2012 by variable Index."
t = summarise_at(group_by(mydata, Index), vars(Y2011, Y2012), 
                 funs(n(), mean(., na.rm = TRUE)))
t
#can also be written like
t = mydata %>% group_by(Index) %>%
  summarise_at(vars(Y2011:Y2015), funs(n(), mean(., na.rm = TRUE)))
t




"do() function :
  Use : Compute within groups
Syntax :
  do(data_frame, expressions_to_apply_to_each_group)
Note : The dot (.) is required to refer to a data frame.
Filter Data within a Categorical Variable
Suppose you need to pull top 2 rows from 'A', 'C' and 'I' categories of variable Index." 
t = mydata %>% filter(Index %in% c("A", "C","I")) %>% group_by(Index) %>%  do(head( . , 2))
t



"Selecting 3rd Maximum Value by Categorical Variable
We are calculating third maximum value of variable Y2015 by variable Index. 
Select only two variables Index and Y2015. 
Then it filters the variable Index with 'A', 'C' and 'I' and then it groups 
the same variable and sorts the variable Y2015 in descending order. 
At last, it selects the third row."
t = mydata %>% select(Index, Y2015) %>%
  filter(Index %in% c("A", "C","I")) %>%
  group_by(Index) %>%
  do(arrange(.,desc(Y2015))) %>%  slice(3)
t
#The slice() function is used to select rows by position.


"Window Functions
Like SQL, dplyr uses window functions that are used to subset data within a group. 
It returns a vector of values. We could use min_rank() function that calculates 
rank "
t = mydata %>% select(Index, Y2015) %>%
  filter(Index %in% c("A", "C","I")) %>%
  group_by(Index) %>%
  filter(min_rank(desc(Y2015)) == 3)
t
t = mydata %>% select(Index, Y2015) %>%
  filter(Index %in% c("A", "C","I")) %>%
  group_by(Index) %>%
  filter(min_rank(desc(Y2015)) == 2)
t




"Summarize, Group and Sort Together 
Computing mean of variables Y2014 and Y2015 by variable Index. 
Then sort the result by calculated mean variable Y2015."
t = mydata %>%
  group_by(Index)%>%
  summarise(Mean_2014 = mean(Y2014, na.rm=TRUE),
            Mean_2015 = mean(Y2015, na.rm=TRUE)) %>%
  arrange(desc(Mean_2015))
t


"mutate() function :
  Use : Creates new variables
Syntax :
  mutate(data_frame, expression(s) )
or
data_frame %>% mutate(expression(s))
Create a new variable
#Calculate division of Y2015 by Y2014 and name it 'change' ".
head(mydata)
mydata1 = mutate(mydata, change=Y2015/Y2014)
head(mydata1)





"Multiply all the variables by 1000
It creates new variables and name them with suffix _new."
mydata11 = mutate_all(mydata, funs("new" = .* 1000))
head(mydata11)
"Note - The above  returns the following error messages -
  Warning messages:
  1: In Ops.factor(c(1L, 1L, 1L, 1L, 2L, 2L, 2L, 3L, 3L, 4L, 5L, 6L,  :
                       '*' not meaningful for factors
                     2: In Ops.factor(1:51, 1000) : '*' not meaningful for factors
                     
                     It implies you are multiplying 1000 to string(character) values which are stored as factor variables. These variables are 'Index', 'State'. It does not make sense to apply multiplication operation on character variables. For these two variables, it creates newly created variables which contain only NA.
                     
                     Solution : Apply multiplication on only numeric variables"
                     
"Calculate Rank for Variables
Suppose you need to calculate rank for variables Y2008 to Y2010."
head(mydata)
mydata12 = mutate_at(mydata, vars(Y2008:Y2010), funs(Rank=min_rank(.)))
head(mydata12)


"By default, min_rank() assigns 1 to the smallest value and high number to the largest value.
In case, we need to assign rank 1 to the largest value of a variable, use min_rank(desc(.))"
mydata13 = mutate_at(mydata, vars(Y2008:Y2010), funs(Rank=min_rank(desc(.))))
head(mydata13)




"Select State that generated highest income among the variable 'Index'"
out = mydata %>% group_by(Index) %>% filter(min_rank(desc(Y2015)) == 1) %>%
 select(Index, Y2015)
out


"Cumulative Income of 'Index' variable
The cumsum function calculates cumulative sum of a variable. 
With mutate function, we insert a new variable called 'Total' which contains values of 
cumulative income of variable Index."
out2 = mydata %>% group_by(Index) %>% mutate(Total=cumsum(Y2015)) %>%
 select(Index, Y2015, Total)
out2





"join() function :
 Use : Join two datasets
Syntax :
 inner_join(x, y, by = )
left_join(x, y, by = )
right_join(x, y, by = )
full_join(x, y, by = )
semi_join(x, y, by = )
anti_join(x, y, by = )
x, y - datasets (or tables) to merge / join
by - common variable (primary key) to join by.
Common rows in both the tables
create two data frames say df1 and df2."
df1 <- data.frame(ID = c(1, 2, 3, 4, 5),
          w = c('a', 'b', 'c', 'd', 'e'),
          x = c(1, 1, 0, 0, 1),
          y=rnorm(5),
          z=letters[1:5])
df1
df2 <- data.frame(ID = c(1, 7, 3, 6, 8),
          a = c('z', 'b', 'k', 'd', 'l'),
          b = c(1, 2, 3, 0, 4),
          c =rnorm(5),
          d =letters[2:6])
df2

"INNER JOIN returns rows when there is a match in both tables. 
In this example, we are merging df1 and df2 with ID as common variable (primary key)."
df3 = inner_join(df1, df2, by = "ID")
df3

"If the primary key does not have same name in both the tables, try:"
#inner_join(df1, df2, by = c("ID"="ID1"))





"Applying LEFT JOIN
LEFT JOIN : It returns all rows from the left table, 
even if there are no matches in the right table."
left_join(df1, df2, by = "ID")






"Combine Data Vertically
intersect(x, y)
Rows that appear in both x and y.
union(x, y)
Rows that appear in either or both x and y.
setdiff(x, y)
Rows that appear in x but not y.
Applying INTERSECT"
head(mtcars)
rownames(mtcars)
mtcars$model <- rownames(mtcars)
head(mtcars)
first <- mtcars[1:20, ]
second <- mtcars[10:32, ]
#INTERSECT selects unique rows that are common to both the data frames.
i1 <- intersect(first, second)
i1

"Applying UNION
UNION displays all rows from both the tables and removes duplicate records from 
the combined dataset. By using union_all function, it allows duplicate rows in the 
combined dataset."
x=data.frame(ID = 1:6, ID1= 1:6)
x
y=data.frame(ID = 1:6,  ID1 = 1:6)
y
union(x,y)
union_all(x,y)



"Rows appear in one table but not in other table"
setdiff(first, second)




"IF ELSE Statement
Syntax :
if_else(condition, true, false, missing = NULL)
true  : Value if condition meets
false : Value if condition does not meet
missing : Value if missing cases.It will be used to replace missing values (Default : NULL)
"
df <- c(-10,2, NA)
df2 <- if_else(df < 0, "negative", "positive", missing = "missing value")
df2

#Create a new variable with IF_ELSE
"If a value is less than 5, add it to 1 and if it is greater than or equal to 5, 
add it to 2. Otherwise 0."
df =data.frame(x = c(1,5,6,NA))
df
df %>% mutate(newvar=if_else(x<5, x+1, x+2,0))



"Nested IF ELSE
Multiple IF ELSE statement can be written using if_else() function. "
mydf =data.frame(x = c(1:5,NA))
mydf
mydf %>% mutate(newvar= if_else(is.na(x),"I am missing",
                        if_else(x==1,"I am one",
                        if_else(x==2,"I am two",
                        if_else(x==3,"I am three","Others")))))







"SQL-Style CASE WHEN Statement
use case_when() function to write nested if-else queries. 
In case_when(), you cannot use variables directly within case_when() wrapper 
so it should be written like .$x which is equivalent to mydf$x. TRUE refers to 
ELSE statement."
mydf %>% mutate(flag = case_when(is.na(.$x) ~ "I am missing",
                                    .$x == 1 ~ "I am one",
                                    .$x == 2 ~ "I am two",
                                    .$x == 3 ~ "I am three",
                                    TRUE ~ "Others"))
#Make sure you set is.na() condition at the beginning in nested ifelse.
#Otherwise, it would not be executed.




"Apply ROW WISE Operation 
Suppose you want to find maximum value in each row of variables 
2012, 2013, 2014, 2015. 
The rowwise() function allows you to apply functions to rows."
df = mydata %>%
      rowwise() %>% mutate(Max= max(Y2012:Y2015)) %>%
      select(Y2012:Y2015,Max)
df





"Combine Data Frames
Combine two data frames."
df1=data.frame(ID = 1:6,  x=letters[1:6])
df1
df2=data.frame(ID = 7:12, x=letters[7:12])
df2

"Input Datasets
The bind_rows() function combine two datasets with rows. 
So combined dataset would contain 12 rows (6+6) and 2 columns."
xy = bind_rows(df1,df2)
xy
#It is equivalent to base R function rbind.
xy = rbind(df1,df2)
xy

"The bind_cols() function combine two datasets with columns.
So combined dataset would contain 4 columns and 6 rows."
xy = bind_cols(x,y)
#or
xy = cbind(x,y)









"Calculate Percentile Values
The quantile() function is used to determine Nth percentile value. 
Compute percentile values by variable Index."
mydata %>% group_by(Index) %>%
 summarise(Pecentile_25=quantile(Y2015, probs=0.25),
           Pecentile_50=quantile(Y2015, probs=0.5),
           Pecentile_75=quantile(Y2015, probs=0.75),
           Pecentile_99=quantile(Y2015, probs=0.99))

#The ntile() function is used to divide the data into N bins.
x= data.frame(N= 1:10)
x
x = mutate(x, pos = ntile(x$N,2))
x

x= data.frame(N= 1:10)
x
x = mutate(x, pos = ntile(x$N,5))
x





"if() Family of Functions
It includes functions like select_if, mutate_if, summarise_if. 
They come into action only when logical condition meets. 
Select only numeric columns
The select_if() function returns only those columns where logical condition is TRUE. 
The is.numeric refers to retain only numeric variables."
head(mydata)
mydata2 = select_if(mydata, is.numeric)
head(mydata2)

"for selecting factor columns - "
mydata3 = select_if(mydata, is.factor)
head(mydata3)







"Number of levels in factor variables
Like select_if() function, summarise_if() function lets you to summarise 
only for variables where logical condition holds."
summarise_if(mydata, is.factor, funs(nlevels(.)))
#It returns 19 levels for variable Index and 51 levels for variable State.



"Multiply by 1000 to numeric variables"
mydata11 = mutate_if(mydata, is.numeric, funs("new" = .* 1000))
head(mydata11)



"Convert value to NA
we are converting "" to NA using na_if() function."
k <- c("a", "b", "", "d")
na_if(k, "")


#***

flight <- read.csv("airline.csv")

attach(flight)

library(dplyr)

#install.packages("hflights")

library(hflights)

head(hflights)

str(hflights)

glimpse(hflights)

#There are over a quarter of a million records and 21 variables, 
#converting it to a tbl_df object gives a nice summary view of the 
#data:

#dplyr can work directly with data frames but also provides a 
#convenient wrapper, tbl_df(), which will only print the first 
#few rows and as many columns as will fit on one line when called. 
#There are also wrappers for data tables (tbl_dt()) and 
#remote data sources (tbl()).
hflights_df <- tbl_df(hflights)

hflights_df
#It prints sample data appropriate foir the window size.


"data subsetting, 
defining new columns, 
sorting or otherwise manipulating the data. 
dplyr has five functions (verbs) for such actions, 
that all start with a data.frame or tbl_df and produce another one.
filter
"

f_df <- filter(hflights_df, Month == 1, UniqueCarrier == "AA")
f_df
"we get the January flights for AA. 
This is like subset but the syntax is a little different. 
We don't need & it is added to comma separated conditions." 
#For an "or" you add | explicitly."


filter(hflights_df, UniqueCarrier == "AA" | UniqueCarrier == "UA")

"arrange
This function reorders the data based on specified columns."
arrange(hflights_df, Month, DayofMonth, desc(AirTime))


"select
This works like the select option to subset."
select(hflights_df, Year:DayOfWeek, TailNum, ActualElapsedTime)

"mutate
This adds new columns, often computed on old ones. 
But you can refer to new coilumns you just created."
ncol(hflights_df)
df<-mutate(hflights_df, gain = ArrDelay - DepDelay, 
           gain_per_hour = gain/(AirTime/60))
ncol(df)

"summarize
This produces a summary statistic, 
"

"Grouping
A major strength of dplyr is the ability to group the data 
by a variable or variables 
and then operate on the data by group. 

Problem: Compute mean arrival delay by plane, 
along with other useful data.
"
planes <- group_by(hflights_df, TailNum)
planes

select(planes,TailNum,Year,Month)

select(planes,TailNum,UniqueCarrier:Distance)

"Shows all the data but indicates a group.
The information we want are summary statistics by plane. 
"
delay2 <- dplyr::summarize(planes, 
                      count = n(), 
                      dist = mean(Distance, na.rm = T), 
                      delay = mean(ArrDelay, na.rm = T))
delay2
"Giving us nice summary statistics per plane. 
The syntax is easier to understand and it's faster."

destinations <- group_by(hflights_df, Dest)
destinations

dplyr::summarise(destinations, 
                 planes = n_distinct(TailNum), 
                 flights = n())

"Grouping by multiple variables
When we do this we have the ability to easily compute summary stats 
by different combinations of the grouping variables.

Suppose we group the data into daily flights."

daily <- group_by(hflights_df, Year, Month, DayofMonth)
# To get the number of flights per day
per_day <-dplyr::summarize(daily, number_flights = n())
per_day

"We have access to each of the grouping variables. 
Notice that in the summary data.frame, we have Year and Month as 
grouping variables. 
We can get the number of flights per month by summarizing as follows."
per_month <- dplyr::summarize(per_day, number_flights = sum(number_flights))
per_month

"Now the only grouping variable is year. 
We backed out of the grouping variables by granularity. 
This is OK for counts and sums but for variances, e.g., this wouldn't work. 
You need to compute on the raw variables."

"Chaining

There is a nice way to pass the result of one function to another. 
This is possible because so many dplyr functions take a data table 
as input and output another data table.

For example:"

a1 <- group_by(hflights, Year, Month, DayofMonth)
a2 <- select(a1, Year:DayofMonth, ArrDelay, DepDelay)
a3 <- dplyr::summarise(a2, arr = mean(ArrDelay, na.rm = TRUE), dep = mean(DepDelay, 
                                                                   na.rm = TRUE))
a4 <- filter(a3, arr > 30 | dep > 30)

hflights %>% 
  group_by(Year, Month, DayofMonth) %>% 
  select(Year:DayofMonth, ArrDelay, DepDelay) %>% 
  dplyr::summarise(arr = mean(ArrDelay, na.rm = TRUE), 
            dep = mean(DepDelay, na.rm = TRUE)) %>% 
  filter(arr > 30 | dep > 30)

"Working with databases

dplyr has been written to work with data.frames and 
connections to remote databases 
in a variety of formats. This permits handling very large amounts of 
data with a standard syntax.

SQLite database. 
dplyr contains all we need to set up a sample database on disk and 
connect to it."
#install.packages("dbplyr")
library(dbplyr)
sessionInfo()
#install.packages("RSQLite")
library(RSQLite)


library(dplyr)
library(ggplot2)
library(data.table)

year_start=2013
year_last=2015

filenames <- list.files(pattern="^demo.*.csv", full.names=TRUE)

?fread
demography = rbindlist(lapply(filenames, fread,
                              select=c("primaryid","caseid","age","age_cod","event_dt",
                                       "sex","wt","wt_cod","occr_country"),data.table=FALSE))

str(demography)
dim(demography)

filenames <- list.files(pattern="^drug.*.csv", full.names=TRUE)

drug = rbindlist(lapply(filenames, fread,
                        select=c("primaryid","drug_seq","drugname","route"
                        ),data.table=FALSE))

str(drug)
dim(drug)


filenames <- list.files(pattern="^indi.*.csv", full.names=TRUE)
indication = rbindlist(lapply(filenames, fread,
                              select=c("primaryid","indi_drug_seq","indi_pt"
                              ),data.table=FALSE))

str(indication)

filenames <- list.files(pattern="^outc.*.csv", full.names=TRUE)
outcome = rbindlist(lapply(filenames, fread,
                           select=c("primaryid","outc_cod"),data.table=FALSE))

str(outcome)

filenames <- list.files(pattern="^reac.*.csv", full.names=TRUE)
reaction = rbindlist(lapply(filenames, fread,
                            select=c("primaryid","pt"),data.table=FALSE))

str(reaction)

my_database<- src_sqlite("adverse_events", create = TRUE) # create =TRUE creates a new database

head(demography)
copy_to(my_database,demography,temporary = FALSE) # uploading demography data
copy_to(my_database,drug,temporary = FALSE)       # uploading drug data
copy_to(my_database,indication,temporary = FALSE) # uploading indication data
copy_to(my_database,reaction,temporary = FALSE)   # uploading reaction data
copy_to(my_database,outcome,temporary = FALSE)     #uploading outcome data

my_db <- src_sqlite("adverse_events", create = FALSE)
# create is false now because I am connecting to an existing database

src_tbls(my_db)

demography = tbl(my_db,"demography" )

class(demography)

head(demography,3)

US = filter(demography, occr_country=='US')  # Filtering demography of patients from the US

explain(US)

drug = tbl(my_db,"drug" )
indication = tbl(my_db,"indication" )
outcome = tbl(my_db,"outcome" )
reaction = tbl(my_db,"reaction" )

head(indication,3)

#tail(indication,3)

#Find the top ten countries with the highest number of adverse events
demography%>%group_by(Country= occr_country)%>% 
  dplyr::summarize(Total=n())%>%      
  dplyr::arrange(desc(Total))%>%       
  filter(Country!='')%>% head(10)



"demography%>%group_by(Country= occr_country)%>% #grouped by country
  dplyr::summarize(Total=n())%>%    # found the count for each country
  dplyr::arrange(desc(Total))%>%    # sorted them in descending order
  dplyr::filter(Country!='')%>%     # removed reports that does not have country information
  head(10)%>%                   # took the top ten
  mutate(Country = factor(Country,levels = Country[order(Total,decreasing =F)]))%>%
  ggplot(aes(x=Country,y=Total))+geom_bar(stat='identity',color='skyblue',fill='#b35900')+
  xlab("")+ggtitle('Top ten countries with highest number of adverse event reports')+
  coord_flip()+ylab('Total number of reports')  
"
#Find the most common drug
drug%>%group_by(drug_name= drugname)%>% #grouped by drug_name
  dplyr::summarize(Total=n())%>%    # found the count for each drug name
  dplyr::arrange(desc(Total))%>%    # sorted them in descending order
  head(1)                   # took the most frequent drug


#What are the top 5 most common outcomes?
head(outcome,3)  # to see the variable names
outcome%>%group_by(Outcome_code= outc_cod)%>% #grouped by Outcome_code
  dplyr::summarize(Total=n())%>%    # found the count for each Outcome_code
  dplyr::arrange(desc(Total))%>%    # sorted them in descending order
  head(5)                   # took the top five

#What are the top ten reactions?
head(reaction,3)  # to see the variable names
#table7
reaction%>%group_by(reactions= pt)%>% # grouped by reactions
  dplyr::summarize(Total=n())%>%    # found the count for each reaction type
  dplyr::arrange(desc(Total))%>%    # sorted them in descending order
  head(10)                   # took the top ten

"Joins
Let's join demography, outcome and reaction based on primary id:"
inner_joined = demography%>%
  inner_join(outcome, by='primaryid',copy = TRUE)%>%
  inner_join(reaction, by='primaryid',copy = TRUE)
head(inner_joined)

"We can also use primary key and secondary key in our joins. 
Let's join drug and indication using two keys (primary and secondary keys)."
"drug_indication= indication%>%rename(drug_seq=indi_drug_seq)%>%
  inner_join(drug, by=c("primaryid","drug_seq"))
head(drug_indication)"

#***
getwd()
system.time(dt <- read.csv("drug2015q3.csv"))
?fread
system.time(DT <- fread("drug2015q3.csv"))
system

#***

#dplyr vs data.table comparions

#Benchmark 1 - subsetting from a large dataframe






suppressMessages(library(dplyr))
suppressMessages(library(data.table))
### create large data source -----------
database <- data.frame(expand.grid(ID = 1:50, TIME = seq(0, 100, 1), REP = 1:250))
head(database)
tail(database)
sample(database)
database <- database[order(database$REP, database$ID, database$TIME), ]
database <- within(database, {
  CONC <- runif(nrow(database), 1, 10)
  DV <- runif(nrow(database), 1, 10)
  IPRED <- runif(nrow(database), 1, 10)
  PRED <- runif(nrow(database), 1, 10)
  ISM <- ifelse(ID%%2 == 0, 1, 0)
})

# 
database_dt <- data.table(database)

head(database)

### functions
generate_samples <- function(ID, REP, num_inds) {
  id <- sample(x = ID, size = num_inds, replace = TRUE)
  rep <- sample.int(REP, size = num_inds, replace = FALSE)
  data.frame(ID = id, REP = rep)
}

# test key
generate_samples(unique(database$ID), REP = length(unique(database$REP)), num_inds = 10)

generate_dataset_dt <- function(database_dt, inds) {
  num_inds <- inds
  m <- generate_samples(unique(database_dt$ID), REP = length(unique(database_dt$REP)), 
                        num_inds = num_inds)
  setkey(database_dt, ID, REP)
  database_subset <- database_dt[J(m)]
  return(database_subset)
}

generate_dataset_dplyr <- function(database, inds) {
  num_inds <- inds
  m <- generate_samples(unique(database$ID), REP = length(unique(database$REP)), 
                        num_inds = num_inds)
  database_subset <- semi_join(database, m)
  return(database_subset)
}
suppressMessages(library(ggplot2))
suppressMessages(library(microbenchmark))

# check varying subset sizes 20 - 200 individuals
tm <- microbenchmark(suppressMessages(generate_dataset_dplyr(database, 20)), 
                     generate_dataset_dt(database_dt, 20), suppressMessages(generate_dataset_dplyr(database, 
                                                                                                   50)), generate_dataset_dt(database_dt, 50), suppressMessages(generate_dataset_dplyr(database, 
                                                                                                                                                                                       100)), generate_dataset_dt(database_dt, 100), suppressMessages(generate_dataset_dplyr(database, 
                                                                                                                                                                                                                                                                             200)), generate_dataset_dt(database_dt, 200), times = 500L)
tm

autoplot(tm)

sessionInfo()

