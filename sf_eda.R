library(tidyverse)
library(lubridate)

app_token <- 'Z4iZ6NVV0wNPCeGxCLQVMEYMI'
api_limit <- 133172

base_url <- 'https://data.sfgov.org/resource/cuks-n6tp.csv?$$app_token='
sf_url <- paste0(base_url, app_token, '&$limit=', api_limit)
#sf_url <- paste0('https://data.sfgov.org/resource/nwbb-fxkq.csv?$$app_token=', app_token, '&$limit=', api_limit)
sf_data <- read_csv(sf_url)

sf_data %>%
    filter(incident_date < ymd("2018-10-01")) ->
    sf_data

sf_data %>%
    group_by(incident_date) %>%
    summarise(n = n()) %>%
    ggplot(aes(x = incident_date, y = n)) +
        geom_point() +
    labs(y = 'Number of Incidents Reported', 
         x = 'Date')

sf_data %>%
    ggplot(aes(x = longitude, y = latitude)) +
    geom_point()

sf_data %>%
    filter(incident_category != 'Larceny Theft') %>%
    ggplot(aes(x = incident_time)) +
    geom_histogram(aes(fill = incident_category)) +
    facet_wrap(~ incident_category) +
    guides(fill = FALSE)

library(gganimate)
library(viridis)
library(ggthemr)

sf_data %>%
    group
    ggplot(aes(x = longitude, y = latitude)) +
    geom_point(aes(colour = resolution)) + 
    scale_colour_brewer(type = 'qual',
                        palette = 'Accent')

sf_data %>%
group_by(resolution) %>%
    summarise(n = n()) %>%
    #top_n(11, n) %>%
    arrange(desc(n))

library(geojsonpolys)
san_francisco <- gsp_counties$california$san_francisco

geojsonio::map_leaf(san_francisco)
