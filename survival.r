#Perform survival analysis
# Merge outputs from RMA and sample metadata analysis into input_survival.csv


test <- read.table("input_survival.csv", sep =",",header = TRUE)
test.surv <- survfit(Surv(DFS_Time, Cens) ~ Group,conf.type = "none")
plot (test.surv, lty=c(1,3), xlab ="Time", ylab ="Survival Prob")
legend(40, 1.0, c("High-pkc", "Low-Pkc"), lty=c(1,3))

#Log Rank 
CoxReg <- coxph(Surv(DFS_Time, Cens) ~ Group)
summary(CoxReg) 

#Log Rank
survdiff(Surv(DFS_Time, Cens) ~ Group, rho=0)