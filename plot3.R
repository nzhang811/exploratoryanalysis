library(ggplot2)

#loading data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#filter for the fips code for baltimore city
baltimore <- NEI[NEI$fips=="24510",]

#subgroup by year and type
aggregBmore <- aggregate(Emissions~year+type, baltimore, sum)

#plotting using ggplot2 with multiple panels
png("plot3.png", width = 480, height = 480)
ggplot(aggregBmore, aes(fill=type, x=factor(year), y=Emissions)) + 
  geom_bar(stat="identity") +
  #plotting each type's data in a separate panel using facet_grid
  facet_grid(.~type) + 
  labs(x="Year", y="Total PM2.5 Emission")
dev.off()
