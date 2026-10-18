## code to prepare `hai_burden` dataset goes here

# Table 2 of Zacher et al. (2019), typed by hand into a csv file
# one row = one survey sample x one measure x one infection
hai_raw <- readr::read_csv("data-raw/hai_burden_table2.csv", show_col_types = FALSE)

hai_burden <- hai_raw |>
  dplyr::mutate(
    # turn the short codes from the paper into words a reader understands
    survey = dplyr::case_when(
      survey_code == "DE_PPS" ~ "Germany (national sample)",
      survey_code == "DE_CONV" ~ "Germany (convenience sample)",
      survey_code == "ECDC_PPS" ~ "EU/EEA average"
    ),
    measure = dplyr::case_when(
      measure_code == "hai" ~ "Infections",
      measure_code == "death" ~ "Deaths",
      measure_code == "daly" ~ "DALYs"
    ),
    infection = dplyr::case_when(
      infection_code == "HAP" ~ "Pneumonia",
      infection_code == "UTI" ~ "Urinary tract infection",
      infection_code == "BSI" ~ "Bloodstream infection",
      infection_code == "SSI" ~ "Surgical site infection",
      infection_code == "CDI" ~ "C. difficile infection"
    )
  ) |>
  dplyr::select(survey, infection, measure, estimate, lower, upper)

usethis::use_data(hai_burden, overwrite = TRUE)