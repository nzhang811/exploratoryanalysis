#loading data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#filter for the fips code for baltimore city
baltimore <- NEI[NEI$fips=="24510",]

#sum total emission by year
total_by_year_baltimore <- tapply(baltimore$Emissions, baltimore$year, FUN=sum)

#plotting the total emission data as a barplot
png("plot2.png", width = 480, height = 480)
barplot(total_by_year_baltimore, names.arg=names(total_by_year), xlab="Year", ylab="Total PM2.5 Emission")
dev.off()
