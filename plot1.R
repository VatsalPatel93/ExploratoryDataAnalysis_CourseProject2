# Read the PM2.5 Emmision data into R variables
if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

# Load necessary libraries
library(dplyr)

# Group the emission data by year
tempNEI <- group_by(NEI, year)

# Take sum of the emissions for the years 1999, 2002, 2005 and 2008
NEI_by_year <- summarise(tempNEI, total_PM2.5 = sum(Emissions))

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Plot answering above question using Base Plotting System
png('CP2/plot1.png')
barplot(height = NEI_by_year$total_PM2.5, names.arg = NEI_by_year$year,
        xlab="Years",
        ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' emissions at various years'))
dev.off()