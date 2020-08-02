#loading data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#filter for coal-combustion sources
combustion <- grepl("Comb", SCC$SCC.Level.One)
coal <- grepl("Coal", SCC$SCC.Level.Four) 
coalComb <- (combustion & coal)
coalCombSSC <- SCC[coalComb,]$SCC
coalCombNEI <- NEI[NEI$SCC %in% coalCombSSC,]

#sum total emission by year
total_by_year = tapply(coalCombNEI$Emissions, coalCombNEI$year, FUN=sum)

#plotting the total emission data as a barplot
png("plot4.png", width = 480, height = 480)
barplot(total_by_year, names.arg=names(total_by_year), xlab="Year", ylab="Total PM2.5 Emission from Coal-Combustion Related Sources")
dev.off()