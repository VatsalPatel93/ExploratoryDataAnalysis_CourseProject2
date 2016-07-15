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

# Filter the emission data for Baltimore City, MD
baltimore_NEI <- filter(NEI, fips == "24510")

# Group the emission data by year and type of emission sources
tempNEI <- group_by(baltimore_NEI, year, type)

# Take sum of the emissions for the years 1999, 2002, 2005 and 2008
baltimore_NEI_by_year <- summarise(tempNEI, total_PM2.5 = sum(Emissions))


# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
# Plot answering above question using ggplot2 Plotting System
png('CP2/plot3.png', height = 480, width = 640)

res_plot <- ggplot(baltimore_NEI_by_year, aes(year, total_PM2.5, col = type))
res_plot <- res_plot + geom_line() + 
            xlab("Year") + 
            ylab(expression('total PM'[2.5]*' emission')) +
            ggtitle(expression('Total PM'[2.5]*' emissions via different type of sources at various years in Baltimore City, MD'))

print(res_plot)
dev.off()