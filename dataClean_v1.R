require(dplyr)
require(lubridate)
require(rCharts)

## Identify file to download
urlName <- "http://www.phmsa.dot.gov/staticfiles/PHMSA/DownloadableFiles/Files/Pipeline/data/accident_hazardous_liquid_jan2010_present.zip"
fileName <- "pipelineIncidents.zip"

## Download file and unzip
download.file(urlName, fileName)
unzip("pipelineIncidents.zip")

## Read data file
data <- read.delim("accident_hazardous_liquid_jan2010_present.txt",
                   header=TRUE, stringsAsFactors = FALSE, skipNul=TRUE)


## Select fields for use in further analysis
subData <- select(data, REPORT_RECEIVED_DATE, IYEAR, REPORT_NUMBER,
                  COMMODITY_RELEASED_TYPE, COMMODITY_SUBTYPE,
                  UNINTENTIONAL_RELEASE_BBLS, FATAL, INJURE, 
                  ONSHORE_STATE_ABBREVIATION, ONSHORE_CITY_NAME,
                  PRPTY, CAUSE, CAUSE_DETAILS) %>%

                  rename(date = REPORT_RECEIVED_DATE,
                         year = IYEAR,
                         reportNumber = REPORT_NUMBER,
                         commodity = COMMODITY_RELEASED_TYPE,
                         commoditySubType = COMMODITY_SUBTYPE,
                         barrelsReleased = UNINTENTIONAL_RELEASE_BBLS,
                         fatalities = FATAL,
                         injuries = INJURE,
                         state = ONSHORE_STATE_ABBREVIATION,
                         city = ONSHORE_CITY_NAME,
                         propDamage = PRPTY,
                         cause = CAUSE,
                         causeDetails = CAUSE_DETAILS)

## Shorten commodity names
subData$commodity[subData$commodity == "REFINED AND/OR PETROLEUM PRODUCT (NON-HVL) WHICH IS A LIQUID AT AMBIENT CONDITIONS"] <- "REFINED/PETROLEUM PRODUCT (NON-HVL)"
subData$commodity[subData$commodity == "HVL OR OTHER FLAMMABLE OR TOXIC FLUID WHICH IS A GAS AT AMBIENT CONDITIONS"] <- "HIGHLY VOLATILE LIQUID"
subData$commodity[subData$commodity == "BIOFUEL / ALTERNATIVE FUEL(INCLUDING ETHANOL BLENDS)"] <- "BIOFUELS"

## Convert property damage in 000s
subData$propDamage <- subData$propDamage/1000

## Modify variable classes
subData$date <- as.Date(mdy(subData$date))
subData$year <- as.factor(subData$year)
subData$reportNumber <- as.factor(subData$reportNumber)
subData$commodity <- as.factor(subData$commodity)
subData$commoditySubType <- as.factor(subData$commoditySubType)
subData$state <- as.factor(subData$state)
subData$city <- as.factor(subData$city)
subData$cause <- as.factor(subData$cause)
subData$causeDetails <- as.factor(subData$causeDetails)

## Change NAs to 0s for injuries and fatalities
subData$fatalities[is.na(subData$fatalities)] <- 0
subData$injuries[is.na(subData$injuries)] <- 0

## Group and aggregate statitics by year and commodity type
by_commodityYear <- group_by(subData, year, commodity)
incidents <- summarise(by_commodityYear,
                       numIncidents=n(),
                       totalBarrels = sum(barrelsReleased, na.rm=TRUE),
                       totalFatalities = sum(fatalities, na.rm=TRUE),
                       totalInjuries = sum(injuries, na.rm=TRUE),
                       totalPropertyDamage = sum(propDamage, na.rm=TRUE))

incidents$totalPropertyDamage <- round(incidents$totalPropertyDamage, 0)

## Write data to csv
write.csv(incidents, 'incidentData.csv')

## Create line charts
## Number of incidents
incidentChart <- nPlot(numIncidents ~ year, data = incidents,
                      group="commodity", 
                      color="commodity", 
                      type = "lineChart")
incidentChart$chart(margin = list(left = 100))
incidentChart$yAxis(axisLabel = "Total Number of Incidents")
incidentChart$xAxis(axisLabel = "Year")
incidentChart

## Barreles released
barrelsChart <- nPlot(totalBarrels ~ year, data = incidents,
            group="commodity", 
            color="commodity", 
            type = "lineChart")
barrelsChart$chart(margin = list(left = 100))
barrelsChart$yAxis(axisLabel = "Total Barrels of Products Released")
barrelsChart$xAxis(axisLabel = "Year")
barrelsChart

## Total property damage
propChart <- nPlot(totalPropertyDamage ~ year, data = incidents,
                       group="commodity", 
                       color="commodity", 
                       type = "lineChart")
propChart$chart(margin = list(left = 100))
propChart$yAxis(axisLabel = "Total Property Damage (thousands USD)")
propChart$xAxis(axisLabel = "Year")
propChart

cType <- "CRUDE OIL"

## Number of incidents
incidentChart <- nPlot(numIncidents ~ year,
                       data = incidents[incidents$commodity == cType,],
                       type = "lineChart")
incidentChart$chart(margin = list(left = 100))
incidentChart$yAxis(axisLabel = "Total Number of Incidents")
incidentChart$xAxis(axisLabel = "Year")
incidentChart

## Barreles released
barrelsChart <- nPlot(totalBarrels ~ year, data = incidents,
                      group="commodity", 
                      color="commodity", 
                      type = "lineChart")
barrelsChart$chart(margin = list(left = 100))
barrelsChart$yAxis(axisLabel = "Total Barrels of Products Released")
barrelsChart$xAxis(axisLabel = "Year")
barrelsChart

## Total property damage
propChart <- nPlot(totalPropertyDamage ~ year, data = incidents,
                   group="commodity", 
                   color="commodity", 
                   type = "lineChart")
propChart$chart(margin = list(left = 100))
propChart$yAxis(axisLabel = "Total Property Damage (thousands USD)")
propChart$xAxis(axisLabel = "Year")
propChart
