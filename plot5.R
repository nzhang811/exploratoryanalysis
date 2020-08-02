#loading data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# filter for vehicle data
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=T)
vehicleSCC <- SCC[vehicle,]$SCC
vehicleNEI <- NEI[NEI$SCC %in% vehicleSCC,]

# Subset the vehicles NEI data to Baltimore's fip
baltimoreVehicleNEI <- vehicleNEI[vehicleNEI$fips=="24510",]

#sum total emission by year
total_by_year_baltimore <- tapply(baltimoreVehicleNEI$Emissions, baltimoreVehicleNEI$year, FUN=sum)

#plotting the total emission data as a barplot
png("plot5.png", width = 480, height = 480)
barplot(total_by_year_baltimore, names.arg=names(total_by_year_baltimore), xlab="Year", ylab="Vehicle PM2.5 Emission in Baltimore")
dev.off()
