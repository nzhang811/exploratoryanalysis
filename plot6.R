library(ggplot2)

#loading data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# filter for vehicle data
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=T)
vehicleSCC <- SCC[vehicle,]$SCC
vehicleNEI <- NEI[NEI$SCC %in% vehicleSCC,]

# Subset the vehicles NEI data to Baltimore's fip
baltimoreVehicleNEI <- vehicleNEI[vehicleNEI$fips=="24510",]
baltimoreVehicleNEI$city <- "Baltimore"
laVehicleNET <- vehicleNEI[vehicleNEI$fips=="06037",]
laVehicleNET$city <- "Los Angeles"

both <- rbind(baltimoreVehicleNEI, laVehicleNET)
#aggregate the data by year and city
aggregBoth <- aggregate(Emissions~year+city, both, sum)


#plotting the total emission data as a barplot
png("plot6.png", width = 480, height = 480)
ggplot(aggregBoth, aes(fill=year, x=factor(year), y=Emissions)) + 
  geom_bar(stat="identity") +
  #plotting each type's data in a separate panel using facet_grid
  facet_grid(.~city) + 
  labs(x="Year", y="Total PM2.5 Emission by Vehicles")
dev.off()
