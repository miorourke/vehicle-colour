##Function to convert dates into month format which mataches the CPI score data set
convert_date_to_cpi_date <- function(var.date){
  
  month <- as.integer(format(as.Date(var.date,format="%Y-%m-%d"), "%m"))
  year <- as.integer(format(as.Date(var.date,format="%Y-%m-%d"), "%Y"))
  
  #Convert month into abbreviated string
  month_as_string <- function(month){ ifelse(month == 1, "JAN",
                                             ifelse(month == 2, "FEB",
                                                    ifelse(month == 3, "MAR",
                                                           ifelse(month == 4, "APR",
                                                                  ifelse(month == 5, "MAY",
                                                                         ifelse(month == 6, "JUN",
                                                                                ifelse(month == 7, "JUL",
                                                                                       ifelse(month == 8, "AUG",
                                                                                              ifelse(month == 9, "SEP",
                                                                                                     ifelse(month == 10, "OCT",
                                                                                                            ifelse(month == 11, "NOV",
                                                                                                                   ifelse(month == 12, "DEC", NA))))))))))))
  }
  
  paste(year, month_as_string(month), sep = ' ')
  
}