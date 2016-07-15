# Read the PM2.5 Emmision data into R variables
if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}


merged_data <- merge(NEI, SCC, by = 'SCC')

# Filtering the emission data from coal based sources
temp_coal_data <- grepl("coal", merged_data$Short.Name, ignore.case = TRUE) 
coal_data <- merged_data[temp_coal_data,]

# Load necessary libraries
library(dplyr)

# Group the emission data by year
tempNEI <- group_by(coal_data, year)

# Take sum of the emissions for the years 1999, 2002, 2005 and 2008
NEI_by_year <- summarise(tempNEI, total_PM2.5 = sum(Emissions))


# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
# Plot answering above question using Base Plotting System
png('CP2/plot4.png')
barplot(height = NEI_by_year$total_PM2.5, names.arg = NEI_by_year$year,
        xlab="Years",
        ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' emissions from Coal sources at various years'))
dev.off()
