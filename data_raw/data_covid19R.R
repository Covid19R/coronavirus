#----------------------------------------------------
# Creating a covid19R compliant JHU coronavirus data set
# using coronavirus data
# https://github.com/CSSEGISandData/COVID-19

`%>%` <- magrittr::`%>%`
setwd(here::here())
source("data-raw/dplyr::left_join")


# the initial data
# git_df <- read.csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv",
#                    stringsAsFactors = FALSE)

# create valid locations
git_df_long_location <- git_df %>%
  dplyr::mutate(country = ifelse(country=="Korea, South", "South Korea", country),
                province = ifelse(province=="Bonaire, Sint Eustatius and Saba",
                                  "Bonaire and Sint Eustatius and Saba", province)
                ) %>%
  tidyr::unite(location, province, country, sep = ", ") %>%
  dplyr::rename(data_type = type,
                value = cases) %>%

  # fix some bad location names
  dplyr::mutate(
    location = gsub("^\\, ", "", location),
    location_type = ifelse(grepl("\\,", location), "state", "country"))

code_table <- get_code_table()

# add codes
coronavirus_covid19 <- dplyr::left_join(git_df_long_location, code_table)

# fix data types
coronavirus_covid19 <- coronavirus_covid19 %>%
  dplyr::mutate(data_type = dplyr::case_when(
    data_type == "confirmed" ~ "cases_new",
    data_type == "recovered" ~ "recovered_new",
    data_type == "death" ~ "deaths_new",

  ))


# data checks
sum(is.na(coronavirus_covid19$location_code)) #make sure codes combine a-ok - will be >0 due to cruise ships
nrow(coronavirus_covid19)- nrow(git_df_long_location) #should be 0, or there was a one to many match

# write out
#write.csv(coronavirus, "csv/coronavirus_covid19format.csv", row.names = FALSE)
print("covid19R compliant data done...")


