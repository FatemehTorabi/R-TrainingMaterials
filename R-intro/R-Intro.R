################################################
# Introduction to R
#By:    Fatemeh Torabi
#Date:  2021
################################################
#you need to install required packages in R
install.packages("readxl")
install.packages("tidyverse")
install.packages("arsenal")
install.packages("ggplot2")
install.packages("ggthemes")
install.packages("ggrepel")
install.packages("ggpubr")
install.packages("broom")

#load the packages into R

library(readxl)
library(tidyverse)
library(arsenal)
library(ggplot2)
library(ggthemes)
library(ggrepel)
library(ggpubr)
library(broom)
###################################################
getwd()
#set your working directory: 
#Note: if you are copying directory straight from file directory: you have to change "\" to "/"

setwd()

###################################################

#replace the file directory with where you placed the data sheet in:
Data <- read_excel("C:/Users/fatemah.torabi/Desktop/Data-R/Data.xls")

#look at the data table and variables 
View(Data)
dim(Data)
colnames(Data)

#summary of data
str(Data)
glimpse(Data)

#summary of your data
summary(Data)

#summary of a single variable
table(Data$Sex)

#assign value labels: 1=Male | 2=Females
Data$Sex <- replace(Data$Sex, Data$Sex==1, "Male")
Data$Sex <- replace(Data$Sex, Data$Sex==2, "Female")

#run the above summary again and see the labels:
table(Data$Sex)

#value labeling for Education variable
#Education	
#1 = GCSE / O Level	
#2 = A Level	
#3 = Degree	
#4 = Masters	
#5 = PhD	
#6 = Vocational qualification	
#7 = HNC / HND	
#8 = Postgraduate diploma	
#9 = Professional qualification	
#10 = MPhil	
#11 = PGCE	
#12 = Other

Data$Education <- replace(Data$Education, Data$Education==1 , "GCSE / O Level")
Data$Education <- replace(Data$Education, Data$Education==2 , "A Level")
Data$Education <- replace(Data$Education, Data$Education==3 , "Degree")
Data$Education <- replace(Data$Education, Data$Education==4 , "Masters")
Data$Education <- replace(Data$Education, Data$Education==5 , "PhD")
Data$Education <- replace(Data$Education, Data$Education==6 , "Vocational qualification")
Data$Education <- replace(Data$Education, Data$Education==7 , "HNC / HND")
Data$Education <- replace(Data$Education, Data$Education==8 , "Postgraduate diploma")
Data$Education <- replace(Data$Education, Data$Education==9 , "Professional qualification")
Data$Education <- replace(Data$Education, Data$Education==10 , "MPhil")
Data$Education <- replace(Data$Education, Data$Education==11 , "PGCE")
Data$Education <- replace(Data$Education, Data$Education==12 , "Other")

table(Data$Education)

#removing first column
Data.cut<-Data[,3:10]
view(Data.cut)
Data.cut$Sex<-as.factor(Data.cut$Sex)
tableOne<-tableby(Sex ~., data=Data.cut)

summary(tableOne)

##########################################################
##Visualising your data:
##########################################################
#pie chart
##########################################################

GenderData <-   Data %>% 
                  count(Sex)

GenderData<- GenderData%>%
                mutate(total=sum(n))%>%
                mutate(percent=n/total *100)

bar<-
  ggplot(GenderData, aes(x="", y=n, fill=Sex))+
  geom_bar(width=1 , stat="identity")

bar 

pie<- bar + coord_polar("y", start = 0)

pie

#adding a theme:
pie+theme_void()


#editing chart labling and colours
pie+theme_void()+
  scale_fill_manual(values=c("#58A4B0","#F3C178"))+
  geom_text(y=c(30,20),label=percent(GenderData$percent/100),size=5, hjust=0.5,vjust=-8)

#add the labels outside chart:

pie+theme_void()+
  scale_fill_manual(values=c("#58A4B0","#F3C178"))+
  geom_label_repel(y=c(30,20),aes(label = percent(GenderData$percent/100)), size=5, show.legend = F, nudge_x = 1) 


##########################################################
##Pie chart education
##########################################################
EduData <-   Data %>% 
              count(Education)

EduData<- EduData%>%
  mutate(total=sum(n))%>%
  mutate(percent=n/total *100)

bar<-
  ggplot(EduData, aes(x="", y=n, fill=Education))+
  geom_bar(width=1 , stat="identity")

bar 

pie<- bar + coord_polar("y", start = 0)

pie

#adding a theme:
pie+theme_void()


#editing chart labling and colours
pie(table(Data$Education), labels=paste(EduData$Education, "=", EduData$percent, "%", sep=""), col=heat.colors(7), main="Education")

###############################################################
#bar chart: age / gender
###############################################################
AgeData<-Data%>%
    count(Age)
      
ggplot(aes(x=Age,y=n), data=AgeData)+
  geom_col(fill="#58A4B0")+
  theme_light()

###breakdown by gnder:

AgeGender<-Data %>%
            group_by(Sex)%>%
            count(Age)


ggplot(aes(Age,n, fill=Sex), data=AgeGender)+
  geom_col(stat="dodge")+
  theme_light()

###########################################################
##scatter plot:
###########################################################

ggplot(data=Data, aes(x=ST1, y=ST2))+
  geom_point()+
  geom_smooth(method="lm")+
  theme_light()

############################################################
##create long dataset for analysis:
############################################################
head(Data)

Data <- Data%>%
        select(`Pt no.`,ST1,ST2)

AnalyseData<- gather(Data, ST_SEQ, ST, -`Pt no.`)

##visulasing:

ggboxplot(AnalyseData, x = "ST_SEQ", y = "ST", 
          color = "ST_SEQ", palette = c("#00AFBB", "#E7B800"),
          order = c("ST1", "ST2"),
          ylab = "compeletion time", xlab = "ST1:Before mindfulness ST2: after mindfulness")


############################################################
##compare mean of compeletion time before and after mindfulness session 
############################################################
#one way ANOVA:
aov<-aov(ST ~ ST_SEQ, data=AnalyseData)

summary(aov)

