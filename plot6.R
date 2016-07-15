# Read the PM2.5 Emmision data into R variables
if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

# Load necessary libraries
library(dplyr)
library(ggplot2)

baltimore_NEI <- filter(NEI, (fips == "24510" | fips == "06037") & type == "ON-ROAD")

# Group the emission data by year and county/city
tempNEI <- group_by(baltimore_NEI, year, fips)

# Take sum of the emissions for the years 1999, 2002, 2005 and 2008
baltimore_NEI_by_year <- summarise(tempNEI, total_PM2.5 = sum(Emissions))


# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
# Plot answering above question using ggplot2 Plotting System
png('CP2/plot6.png', height = 480, width = 920)

res_plot <- ggplot(baltimore_NEI_by_year, aes(factor(year), total_PM2.5))
res_plot <- res_plot + facet_grid(. ~ fips)
res_plot <- res_plot + geom_bar(stat = "identity") + 
        xlab("Year") + 
        ylab(expression('total PM'[2.5]*' emission')) +
        ggtitle(expression('Total PM'[2.5]*' emissions from motor vehicle sources at various years in Los Angeles County, CA vs Baltimore City, MD'))

print(res_plot)
dev.off()