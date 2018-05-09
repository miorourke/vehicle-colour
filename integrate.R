#######################################
## 0. Install and load functionality ##
#######################################


packages_to_install <- c("tidyverse", "RODBC", "rmarkdown", "knitr", "lubridate")
# install.packages(packages_to_install)

# Note, loading tidyverse does not load all packages installed with tidyverse, only the core
packages_to_load <- packages_to_install
lapply(packages_to_load, library, character.only = TRUE)
options(scipen = 30)
set.seed(2345)


##################
## 1. Load data ##
##################
# 
# impala_connection <- odbcConnect("Impala_connection")
# 
# 
# mbos_data_raw <- sqlQuery(impala_connection,
#                                  "
#                                  select
# 
#                           cder_capcode as cap_code,
#                           cder_ID as cap_id,
#                           cman_name as manufacturer,
#                           cran_name as vehicle_range,
#                           cmod_name as model,
#                           ctrim_name as trim,
#                           cder_name as derivative_name,
#                           cder_introduced as cap_id_introduced_date,
#                           cder_discontinued as cap_id_discontinued_date,
#                           cvs_Description as sector_type,
#                           cder_doors as no_of_doors,
#                           cdt_description as drive_train,
#                           cfd_description as fuel_delivery,
#                           ct_description as transmission,
#                           cft_description as fuel_type,
#                           round(cast(substring(cder_capcode,5,2) as int)/10,1) as engine_size,
#                           cbs_description AS body_style,
#                           cvehicle_dertextcode AS derivative_text_number,
#                           -- bs_description as body_type,
#                           round(PR_Basic,2) as new_price_ex_vat,
#                           round(PR_Vat,2) as vat,
#                           date_sold,
#                           sold_price,
#                           cap_clean,
#                           vehicle_unique_identifier,
#                           stock_status,
#                           registration_date,
#                           mileage,
#                           condition_grade,
#                           exterior_body_colour, 
#                           branch_name
#                           
#                           
#                           
#                           from dev_cap_extract.capder
#                           
#                           
#                           left join dev_cap_extract.capman on cman_code=cder_mancode
#                           left join dev_cap_extract.caprange on cran_code=cder_rancode
#                           left join dev_cap_extract.capmod on cmod_code=cder_modcode
#                           left join dev_cap_extract.captrim on ctrim_code=cder_trimcode
#                           left join dev_cap_extract.capvehiclesectors on cvs_iD=cder_vehiclesector
#                           left join dev_cap_extract.capdrivetrain on cdt_code=cder_drivetrain
#                           left join dev_cap_extract.capfueldelivery on cfd_code=cder_fueldelivery
#                           left join dev_cap_extract.captransmission on ct_code=cder_transmission
#                           left join dev_cap_extract.capfueltype on cft_code=cder_fueltype
#                           LEFT JOIN dev_cap_extract.capbodystyle on substr(cder_capcode, 11, 1) = rtrim(cbs_code)
#                           left join dev_cap_extract.nvdprices on PR_Id=cder_ID and PR_EffectiveFrom= cder_introduced
#                           left join dev_cap_extract.capvehicles on cvehicle_id = cder_ID
#                           left join (select date_sold,
#                           sold_price,
#                           cap_id,
#                           cap_clean,
#                           vehicle_unique_identifier,
#                           stock_status,
#                           registration_date,
#                           mileage,
#                           condition_grade,
#                           exterior_body_colour, 
#                           branch_name from prod_master_mbos.data_model
#                           where stock_status ='Sold' and vehicle_type ='CAR'
#                           and  date_sold >= '2016-01-01' and date_sold < '2017-12-31') ww on cder_ID = ww.cap_id
#                           where sold_price is not null
#                                  ",
#                                    stringsAsFactors = F, na.strings = c("NULL", ""))
# 
# data_extract_raw <- mbos_data_raw
# 
# 
# save(data_extract_raw, file = '../../data/vehicle-colour/data_extract_raw.rda', compress = T)

# load(file = '../../data/vehicle-colour/data_extract_raw.rda')

# clean_condition <- function(x){
#   
#   ifelse(x == '1', 1, 
#          ifelse(x == '2', 2, 
#                 ifelse(x == '3', 3, 
#                        ifelse(x == '4', 4, 
#                               ifelse(x == '5', 5, 
#                                      ifelse(x == 'A', 1, 
#                                             ifelse(x == 'B', 2,
#                                                    ifelse(x == 'C', 3, 
#                                                           ifelse(x == 'D', 4,
#                                                                  ifelse(x == 'E', 5,
#                                                                         ifelse(x == 'U', 6, 
#                                                                                ifelse(is.na(x),0,
#                                                                                       0))))))))))))
# }
# 
# 
# # 
# # # Clean the data
# # # Remove whitespaces 
# # # Remove low and high extremes
# # # Remove vehicles without a vehicle colour
# # # Calculate the age of the vehicle
# # 
# data_subset <- data_extract_raw %>%
#   mutate(manufacturer = trimws(manufacturer),
#          vehicle_range = trimws(vehicle_range),
#          model = trimws(model),
#          trim = trimws(trim),
#          derivative_name = trimws(derivative_name),
#          sector_type = trimws(sector_type),
#          drive_train = trimws(drive_train),
#          fuel_delivery = trimws(fuel_delivery),
#          transmission = trimws(transmission),
#          fuel_type = trimws(fuel_type),
#          body_style = trimws(body_style),
#          age_months = as.integer(round(((as.Date(date_sold, format="%Y/%m/%d") -
#                                            as.Date(registration_date, format="%Y/%m/%d"))/30.42),0)),
#          condition_grade = clean_condition(condition_grade)) %>%
#   filter(sold_price >=100 & sold_price <100000 &
#            mileage >= 500 & mileage < 250000 &
#            age_months >=1 & age_months <= 250 &
#            !is.na(exterior_body_colour) &
#            condition_grade >0 & condition_grade <= 5 )

# 
# save(data_subset, file = '../../data/vehicle-colour/data_subset.rda', compress = T)

load(file = '../../data/vehicle-colour/data_subset.rda')

## Load CPI data
#Load CPI data sourced from the ONS
used_car_cpi_scores <- read.csv(file = '../../data/kbb-valuation-engine/ons_cpi_scores_used_cars.csv', header = T, stringsAsFactors = F)

















