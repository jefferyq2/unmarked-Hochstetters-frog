#--- Correlation script ---#

setwd("C:/Users/herbersa/OneDrive - Victoria University of Wellington - STAFF/Claires thesis pub")
getwd()
#[1] "C:/Users/herbersa/OneDrive - Victoria University of Wellington - STAFF/Claires thesis pub"

  
CMR2021<-read.csv("Appendix_4A_CMR_2021.csv",header=T)
Nmix2021<-read.csv("Appendix_4B_N-mixture_2021.csv",header=T)
UncNmix<-read.csv("Appendix_4C_Unconst_N-mix_2012-21.csv",header=T)
TTNmix<-read.csv("Appendix_4D_Time-trend_N-mix_2012-21.csv",header=T)
SC<-read.csv("Appendix_4E_Single_count_2012-21.csv",header=T)
UncOcc<-read.csv("Appendix_4F_Unconst_occupancy_2012-21.csv",header=T)
TTOcc<-read.csv("Appendix_4G_Time-trend_occupancy_2012-21.csv",header=T)

Syear<-cbind(CMR2021[1:15,3],Nmix2021[1:15,3])
colnames(Syear)<-c("CMR","Nmix")

shapiro.test(log(Syear[,1])) #is log normal
shapiro.test(log(Syear[,2])) #is log normal

cor.test(Syear[,1],Syear[,2],method="spearman") #data are lognormal, but used Spearman test so more comparable to other tests

Myear<-cbind(UncNmix[2:45,4],TTNmix[2:45,4],SC[2:45,4],UncOcc[52:95,4],TTOcc[52:95,4],UncOcc[2:45,4],TTOcc[2:45,4])
colnames(Myear)<-c("UncNmix","TTNmix","SC","UncOcc","TTOcc","UncOcc.N","TTOcc.N")

shapiro.test(log(Myear[,1])) #not log normal or normal
shapiro.test(log(Myear[,2])) #not log normal or normal
shapiro.test(log(Myear[,3])) #not log normal or normal
shapiro.test(log(Myear[,4])) #not log normal or normal
shapiro.test(log(Myear[,5])) #not log normal or normal
shapiro.test(log(Myear[,6])) #Log normal

cor.test(Myear[,1],Myear[,2],method="spearman") #TT vs. Unconstrained Nmix
cor.test(Myear[,1],Myear[,3],method="spearman") #Unconstrained Nmix vs single count Poisson model
cor.test(Myear[,2],Myear[,3],method="spearman") #TT Nmix vs single count Poisson model 

cor.test(Myear[,1],Myear[,4],method="spearman") #Unconstrained Nmix vs. unconstrained occupancy
cor.test(Myear[,2],Myear[,5],method="spearman") #TT Nmix vs. TT occupancy

cor.test(Myear[,1],Myear[30:44,6],method="pearson") #N from unconstrained Nmix vs. derived from unconstrained occupancy

par(mfrow=c(2,1))
plot(Myear[30:44,1],Myear[30:44,4],xlab="N estimates from N-mixture",ylab="Occupancy estimates",main="A")
plot(Myear[30:44,1],Myear[30:44,6],xlab="N estimates from N-mixture",ylab="N estimates dervied from occupancy",main="B")
par(mfrow=c(1,1))

#It's weird that Spearman's test indicates such high correlation, but I suspect that's from the use of ranking. 