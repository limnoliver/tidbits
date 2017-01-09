# ==================================
# PURPOSE
# This code was used to analyze lake ice 
# data for the purpose of a blog post
# ==================================

# retrive Lake Mendota ice cover data from 
# North Temperate Lakes (NTL) Long Term Ecological Research (LTER) program

# Package ID: knb-lter-ntl.33.13 Cataloging System:https://pasta.lternet.edu.
# Data set title: North Temperate Lakes LTER: Ice Duration - Madison Lakes Area 1853 - current.
# Data set creator:    - Center for Limnology 
# Data set creator:    - NTL LTER 
# Metadata Provider:    - North Temperate Lakes LTER 
# Contact:    - Information Manager LTER Network Office  - tech-support@lternet.edu
# Contact:    - NTL LTER Information Manager University of Wisconsin  - infomgr@lter.limnology.wisc.edu
# Contact:    - NTL LTER Lead PI Center for Limnology  - leadpi@lter.limnology.wisc.edu
# Metadata Link: https://portal.lternet.edu/nis/metadataviewer?packageid=knb-lter-ntl.33.13
# Stylesheet for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@lternet.edu 

infile1  <- "https://pasta.lternet.edu/package/data/eml/knb-lter-ntl/33/13/d989aa869bedf44ee79d346ba43acc62" 
infile1 <- sub("^https","http",infile1) 
dt1 <-read.csv(infile1,header=F 
               ,skip=1
               ,sep=","  
               ,quot='"' 
               , col.names=c(
                 "lakeid",     
                 "season",     
                 "iceon",     
                 "ice_on",     
                 "iceoff",     
                 "ice_off",     
                 "ice_duration",     
                 "year4"    ), check.names=TRUE)


# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
if (class(dt1$lakeid)!="factor") dt1$lakeid<- as.factor(dt1$lakeid)
if (class(dt1$season)!="factor") dt1$season<- as.factor(dt1$season)
if (class(dt1$ice_duration)=="factor") dt1$ice_duration <-as.numeric(levels(dt1$ice_duration))[as.integer(dt1$ice_duration) ]
if (class(dt1$year4)=="factor") dt1$year4 <-as.numeric(levels(dt1$year4))[as.integer(dt1$year4) ]

# filter for Lake Mendota data

mendota = subset(dt1, dt1$lakeid == "ME")
names(mendota)

# get Ten Mile Lake Data
# These data come from the Ten Mile Lake Association
# I manually retrieved these data as they are posted as jpeg on website
# The last three dates are unofficial - they were not posted so I contacted
# Tenmile Lake resident Don Hoppe as he records ice on/ice off

tenmile = read.csv("data/tenmilelake_icedata.csv", header = TRUE)
head(tenmile)

# convert dates to dates
mendota$ice_on = as.POSIXct(mendota$ice_on, format = "%m/%d/%Y", tz = "UTC")
mendota$ice_off = as.POSIXct(mendota$ice_off, format = "%m/%d/%Y", tz = "UTC")
mendota$duration = difftime(mendota$ice_on, mendota)


# ice on, difference between ice on (# of days)
# ice off, difference between ice off (# of days)
# ice duration, difference in ice duration

