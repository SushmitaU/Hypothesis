#-------------------------------------------------------------------------------------------

hypothesis<-function(data,vect=c(),y=NULL,mu=NULL, tail="two.sided", alpha=0.05)
{
  if (is.null(vect)&& is.data.frame(data))
  {
    print("Hypothesis testing cannot be performed as only dataframe is given, please provide column number in c(1,2,..etc) ")
  }
  if (!is.null(vect)&& length(vect)==1)
  {
    if (is.numeric(data[,vect[1]]))
    {
      if (is.null(mu))
      {
        print("Please provide Population mean as mu=Value for hypothesis testing")
      }
      else
      {
        print(paste("t test for single population",names(data)[vect[1]]))
        print(t.test(data[,vect[1]],mu=mu,alternative = tail,conf.level = (1-alpha)))
      }
      
    }
    else
    {
      print(paste("Chi square test for",names(data)[vect[1]]))
      print(chisq.test(table(data[,vect[1]])))
    }
  }
  if (!is.null(vect)&& length(vect)>=2)
  {
    if (is.numeric(vect[1])&&is.numeric(vect[1]) && length(vect)==2 )
    {
      print(paste("t test for two population",names(data)[vect[1]],"and",names(data)[vect[2]]))
      print(t.test(data[,vect[1]],data[,vect[2]]))
    }
    if (class(data[,vect[1]])!="factor" && length(unique(data[,vect[2]]))==2)
    {
      n=length(unique(data[,vect[2]]))
      if (n==2)
      {
        a<-data[,vect[1]][data[,vect[2]]==unique(data[,vect[2]])[1]]
        b<-data[,vect[1]][data[,vect[2]]==unique(data[,vect[2]])[2]]
        print(t.test(a,b))
      }
      
    }
    else if(!is.null(y))
    {
      print("Anova Test")
      print(aov(y~as.matrix(data)))
    }
  }
  else
  {
    print("No test possible")  
  }
  
}

#-----------------------------------------------------------------------