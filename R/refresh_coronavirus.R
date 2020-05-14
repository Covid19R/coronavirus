#' Refresh the 2019 Novel Coronavirus COVID-19 (2019-nCoV) Dataset in the Covid19R Project Format
#'
#' Daily summary of the Coronavirus (COVID-19) cases by state/province.
#' @return A tibble object
#' * date - The date in YYYY-MM-DD form
#' * location - The name of the location as provided by the data source.
#' * location_type - The type of location using the covid19R controlled vocabulary.
#' * location_code - A standardized location code using a national or international standard. Drawn from \href{https://github.com/olahol/iso-3166-2.js/}{iso-3166-2.js}'s version
#' * location_code_type The type of standardized location code being used according to the covid19R controlled vocabulary. Here we use `iso_3166_2`
#' * data_type - the type of data in that given row using the covid19R controlled vocabulary. Includes cases_new, deaths_new, recovered_new.
#' * value - number of cases of each data type
#' @export refresh_coronavirus_jhu
#' @return A data.frame object
#' @source coronavirus - Johns Hopkins University Center for Systems Science and Engineering (JHU CCSE) Coronavirus \href{https://systems.jhu.edu/research/public-health/ncov/}{website}
#'
#' @examples
#' \dontrun{
#' # update the data
#' jhu_covid19_dat <- refresh_coronavirus_jhu()
#' }
#'
refresh_coronavirus_jhu <- function(){
  utils::read.csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus_covid19format.csv",
                                     stringsAsFactors = FALSE)
}



#' Get information about the datasets provided by the coronavirus package
#'
#' @description Returns information about the datasets in this package for covid19R harvesting
#'
#' @return a tibble of information about the datasets in this package
#' @export get_info_coronavirus
#'
#' @examples
#' \dontrun{
#'
#' # get the dataset info from this package
#' get_info_coronavirus()
#' }
#'
get_info_coronavirus <- function(){
  data.frame(
    data_set_name = "coronavirus_jhu",
    package_name = "coronavirus",
    function_to_get_data = "refresh_coronavirus_jhu*",
    data_details = "The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Dataset from the Johns Hopkins University Center for Systems Science and Engineering",
    data_url = "https://systems.jhu.edu/research/public-health/ncov/",
    license_url = "https://github.com/CSSEGISandData/COVID-19/",
    data_types = "cases_new, recovered_new, deaths_new",
    location_types = "country, state",
    spatial_extent = "global",
    TRUE
  )
}
