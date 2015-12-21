---
title       : Developing Data Products
subtitle    : Pipeline Incidents in the U.S., Jan 2010 - Present
author      : 
job         : December 20, 2015
framework   : io2012      # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
ext_widgets : {rCharts: libraries/nvd3}
mode        : standalone    # {standalone, draft}
knit        : slidify::knit2slides
---

## Course Project

This presentation is being created as part of the course project of the Coursera's Developing Data Products course. This assignment is to demonstrate that the following concepts are understood by the students:

* [shiny](http://shiny.rstudio.com/) to build data product application; and

* [slidify](http://slidify.org/) to create data product related presentations.

--- .class #id

## The Application

The increasing extraction of crude oil in the United States has been a subject much in the news.  Using [shiny](http://shiny.rstudio.com/) I built and [application](https://data8021.shinyapps.io/pipelineApp) that allows a user to explore incidents reported by pipeline operators who move crude oil, and other products.

The application allows the user to:

* See how the number of incidents has changed between 2010;

* See how much product is spilled;

* See how much property damage is caused by these spills; and

* Compare incdients impacting different commodities.

--- .class #id 

## Data

The information for this [application](https://data8021.shinyapps.io/pipelineApp) is drawn from incident data provided by the U.S. Department of Transportation's [Pipeline and Hazardous Material Safety Administration](http://www.phmsa.dot.gov/). The following code was uesd to ingest the data:


```r
## Identify file to download
urlName <- "http://www.phmsa.dot.gov/staticfiles/PHMSA/DownloadableFiles/Files/Pipeline/data/accident_hazardous_liquid_jan2010_present.zip"
fileName <- "pipelineIncidents.zip"

## Download file and unzip
download.file(urlName, fileName)
unzip("pipelineIncidents.zip")

## Read data file
data <- read.delim("accident_hazardous_liquid_jan2010_present.txt",
                   header=TRUE, stringsAsFactors = FALSE, skipNul=TRUE)
```

--- .class #id 

## Processing

Multiple processing steps were necessary to get this data conidtioned and ready to analyze, including selecting the variables necessary for further analysis, shortening the names of commodities for ease of reading on the subsequent charts, and modifying variable classes. The last step of getting the data aggregated and summarized is included below:


```r
required(dplyr)
by_commodityYear <- group_by(subData, year, commodity)
incidents <- summarise(by_commodityYear,
                       numIncidents=n(),
                       totalBarrels = sum(barrelsReleased, na.rm=TRUE),
                       totalFatalities = sum(fatalities, na.rm=TRUE),
                       totalInjuries = sum(injuries, na.rm=TRUE),
                       totalPropertyDamage = sum(propDamage, na.rm=TRUE))
```

--- .class #id 

## Results and Application

The [application](https://data8021.shinyapps.io/pipelineApp) allows the user to explore the aggregated data and look specifically at incidents of differnt commodities.  The charts in the application are derived from the summary chart listed below showing the number of incidents of differnt commodity types since January 2010.

<link rel='stylesheet' href=//cdnjs.cloudflare.com/ajax/libs/nvd3/1.1.15-beta/nv.d3.min.css>
<script type='text/javascript' src=//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js></script>
<script type='text/javascript' src=//d3js.org/d3.v3.min.js></script>
<script type='text/javascript' src=//cdnjs.cloudflare.com/ajax/libs/nvd3/1.1.15-beta/nv.d3.min.js></script>
<script type='text/javascript' src=//nvd3.org/assets/lib/fisheye.js></script> 
 <style>
  .rChart {
    display: block;
    margin-left: auto; 
    margin-right: auto;
    width: 800px;
    height: 400px;
  }  
  </style>
<div id = 'chart1ec07ef556cc' class = 'rChart nvd3'></div>
<script type='text/javascript'>
 $(document).ready(function(){
      drawchart1ec07ef556cc()
    });
    function drawchart1ec07ef556cc(){  
      var opts = {
 "dom": "chart1ec07ef556cc",
"width":    800,
"height":    400,
"x": "year",
"y": "numIncidents",
"group": "commodity",
"color": "commodity",
"type": "lineChart",
"id": "chart1ec07ef556cc" 
},
        data = [
 {
 "X": 1,
"year": 2010,
"commodity": "CO2 (CARBON DIOXIDE)",
"numIncidents": 6,
"totalBarrels":         329.18,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 213 
},
{
 "X": 2,
"year": 2010,
"commodity": "CRUDE OIL",
"numIncidents": 156,
"totalBarrels":       52716.75,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 1033494 
},
{
 "X": 3,
"year": 2010,
"commodity": "HIGHLY VOLATILE LIQUID",
"numIncidents": 63,
"totalBarrels":       39939.18,
"totalFatalities": 1,
"totalInjuries": 1,
"totalPropertyDamage": 10566 
},
{
 "X": 4,
"year": 2010,
"commodity": "REFINED/PETROLEUM PRODUCT (NON-HVL)",
"numIncidents": 125,
"totalBarrels":        7573.29,
"totalFatalities": 0,
"totalInjuries": 2,
"totalPropertyDamage": 30922 
},
{
 "X": 5,
"year": 2011,
"commodity": "CO2 (CARBON DIOXIDE)",
"numIncidents": 4,
"totalBarrels":        2541.76,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 169 
},
{
 "X": 6,
"year": 2011,
"commodity": "CRUDE OIL",
"numIncidents": 147,
"totalBarrels":       35358.56,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 185259 
},
{
 "X": 7,
"year": 2011,
"commodity": "HIGHLY VOLATILE LIQUID",
"numIncidents": 72,
"totalBarrels":       27859.56,
"totalFatalities": 1,
"totalInjuries": 2,
"totalPropertyDamage": 8319 
},
{
 "X": 8,
"year": 2011,
"commodity": "REFINED/PETROLEUM PRODUCT (NON-HVL)",
"numIncidents": 123,
"totalBarrels":       23351.43,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 79786 
},
{
 "X": 9,
"year": 2012,
"commodity": "CO2 (CARBON DIOXIDE)",
"numIncidents": 2,
"totalBarrels":          19.03,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 6 
},
{
 "X": 10,
"year": 2012,
"commodity": "CRUDE OIL",
"numIncidents": 189,
"totalBarrels":        15025.3,
"totalFatalities": 3,
"totalInjuries": 4,
"totalPropertyDamage": 46870 
},
{
 "X": 11,
"year": 2012,
"commodity": "HIGHLY VOLATILE LIQUID",
"numIncidents": 41,
"totalBarrels":       21436.56,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 4458 
},
{
 "X": 12,
"year": 2012,
"commodity": "REFINED/PETROLEUM PRODUCT (NON-HVL)",
"numIncidents": 134,
"totalBarrels":        9402.96,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 93577 
},
{
 "X": 13,
"year": 2013,
"commodity": "CO2 (CARBON DIOXIDE)",
"numIncidents": 5,
"totalBarrels":          51.53,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 184 
},
{
 "X": 14,
"year": 2013,
"commodity": "CRUDE OIL",
"numIncidents": 205,
"totalBarrels":       43047.61,
"totalFatalities": 0,
"totalInjuries": 6,
"totalPropertyDamage": 193263 
},
{
 "X": 15,
"year": 2013,
"commodity": "HIGHLY VOLATILE LIQUID",
"numIncidents": 57,
"totalBarrels":       61882.75,
"totalFatalities": 1,
"totalInjuries": 0,
"totalPropertyDamage": 29969 
},
{
 "X": 16,
"year": 2013,
"commodity": "REFINED/PETROLEUM PRODUCT (NON-HVL)",
"numIncidents": 134,
"totalBarrels":       12485.05,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 55024 
},
{
 "X": 17,
"year": 2014,
"commodity": "BIOFUELS",
"numIncidents": 1,
"totalBarrels":            3.5,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 1 
},
{
 "X": 18,
"year": 2014,
"commodity": "CO2 (CARBON DIOXIDE)",
"numIncidents": 4,
"totalBarrels":         2188.8,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 31 
},
{
 "X": 19,
"year": 2014,
"commodity": "CRUDE OIL",
"numIncidents": 233,
"totalBarrels":       17847.78,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 57871 
},
{
 "X": 20,
"year": 2014,
"commodity": "HIGHLY VOLATILE LIQUID",
"numIncidents": 50,
"totalBarrels":       10879.37,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 30819 
},
{
 "X": 21,
"year": 2014,
"commodity": "REFINED/PETROLEUM PRODUCT (NON-HVL)",
"numIncidents": 157,
"totalBarrels":       16377.82,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 41086 
},
{
 "X": 22,
"year": 2015,
"commodity": "CO2 (CARBON DIOXIDE)",
"numIncidents": 4,
"totalBarrels":           72.8,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 43 
},
{
 "X": 23,
"year": 2015,
"commodity": "CRUDE OIL",
"numIncidents": 212,
"totalBarrels":       16595.09,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 178766 
},
{
 "X": 24,
"year": 2015,
"commodity": "HIGHLY VOLATILE LIQUID",
"numIncidents": 54,
"totalBarrels":       73620.32,
"totalFatalities": 1,
"totalInjuries": 0,
"totalPropertyDamage": 16050 
},
{
 "X": 25,
"year": 2015,
"commodity": "REFINED/PETROLEUM PRODUCT (NON-HVL)",
"numIncidents": 123,
"totalBarrels":        6800.41,
"totalFatalities": 0,
"totalInjuries": 0,
"totalPropertyDamage": 33948 
} 
]
  
      if(!(opts.type==="pieChart" || opts.type==="sparklinePlus" || opts.type==="bulletChart")) {
        var data = d3.nest()
          .key(function(d){
            //return opts.group === undefined ? 'main' : d[opts.group]
            //instead of main would think a better default is opts.x
            return opts.group === undefined ? opts.y : d[opts.group];
          })
          .entries(data);
      }
      
      if (opts.disabled != undefined){
        data.map(function(d, i){
          d.disabled = opts.disabled[i]
        })
      }
      
      nv.addGraph(function() {
        var chart = nv.models[opts.type]()
          .width(opts.width)
          .height(opts.height)
          
        if (opts.type != "bulletChart"){
          chart
            .x(function(d) { return d[opts.x] })
            .y(function(d) { return d[opts.y] })
        }
          
         
        chart
  .margin({
 "left":    100 
})
          
        chart.xAxis
  .axisLabel("Year")

        
        
        chart.yAxis
  .axisLabel("Total Number of Incidents")
      
       d3.select("#" + opts.id)
        .append('svg')
        .datum(data)
        .transition().duration(500)
        .call(chart);

       nv.utils.windowResize(chart.update);
       return chart;
      });
    };
</script>

