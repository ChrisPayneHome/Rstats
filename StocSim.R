

States <- c("Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Indiana", "Iowa", "Kansas", "Kentucky", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Pennsylvania", "South Carolina", "Tennessee", "Texas", "Utah", "Virginia", "Washington", "West Virginia", "Wisconsin")
States_Elec <- c(9, 3, 11, 6, 55, 9, 7, 3, 29, 16, 4, 11, 6, 6, 8, 4, 10, 11, 16, 10, 6, 10, 3, 6, 4, 14, 5, 29, 15, 3, 18, 7, 20, 9, 11, 38, 6, 13, 12, 5, 10)
Biden_Prob <- c(36, 48, 49, 47, 67, 52, 52, 56, 50, 46, 56, 39, 40, 41, 35, 44, 59, 63, 51, 50, 41, 43, 42, 49, 53, 56, 53, 57, 45, 45, 36, 52, 44, 36, 47, 41, 52, 59, 31, 48, 49)
Trump_Prob <- c(58, 49, 45, 45, 28, 39, 31, 40, 46, 44, 29, 52, 41, 48, 59, 36, 35, 27, 40, 47, 50, 50, 53, 45, 40, 33, 39, 32, 44, 48, 55, 43, 49, 53, 46, 44, 41, 37, 66, 42, 44)
State_MOE <- c(4,  3.9, 3, 3.3, 2, 4, 3, 5, 4, 5.3, 3.1, 3.1, 4.5, 3.3, 3, 4.4, 3.5, 4.4, 4, 3.6, 4.1, 4, 4, 3.6, 3, 4.2, 3.6, 3.9, 4, 2.3, 4.4, 3.4, 4, 3.9, 2, 3, 2.9, 3, 4.4, 3.7, 4.2)
Trump_Sim.Win <- 0
Biden_Sim.Win <- 0

print("Beginning Simulations")

for(i in 0:100000){

	#As polls don't exist for DC, Idaho, Illinois, Louisiana, Nebraska, Oregon, Rhode Island, South Dakota, Vermont, Wyoming

	#We expect DC, Oregon, Rhode Island and Vermont to go to Biden. And Louisiana, Nebraska, South Dakota, and Wyoming to call for Trump

	Trump_Votes <- 23
	Biden_Votes <- 37

	for(j in 1:41){
		var <- (State_MOE[j]/2)^2
		Trump_Win_Prob <- rnorm(1, Trump_Prob[j], var)
		Biden_Win_Prob <- rnorm(1, Biden_Prob[j], var)
		if(Trump_Win_Prob > Biden_Win_Prob){
			Trump_Votes <- Trump_Votes + States_Elec[j]
		} else {
			Biden_Votes <- Biden_Votes + States_Elec[j]
		}
	}

	print(sprintf("Completed Simulation %i", i))

	if(Trump_Votes > 270){
		print(sprintf("Trump Won the Election with %d Electoral College Votes", Trump_Votes))
		Trump_Sim.Win <- Trump_Sim.Win + 1
	} else if(Biden_Votes > 270) {
		print(sprintf("Biden Won the Election with %d Electoral College Votes", Biden_Votes))
		Biden_Sim.Win <- Biden_Sim.Win + 1
	} else {
		print("There's been a tie?! What?!")
	}
}

print("Finished Simulations")

print(sprintf("Out of 100,000 Simulations, Trump won: %i, and Biden won: %i", Trump_Sim.Win, Biden_Sim.Win))
print(sprintf("Given this, the model predicts that Trump has a %.3f per cent chance of winning, while Biden has a %.3f per cent chance of winning", ((Trump_Sim.Win/100000) * 100), ((Biden_Sim.Win/100000) * 100)))


