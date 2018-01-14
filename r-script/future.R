dates = commandArgs(TRUE)

error <- FALSE
if (length(dates) == 0) {
    error = TRUE
} else if (length(dates) == 1) {
    if (file.exists('BASE') && stringr::str_detect(dates[1], '^-?[1-9][0-9]*$')) {
        date_base = lubridate::ymd(readLines('BASE'))
        date_offset = as.integer(dates[1])
    } else {
        error = TRUE
    }
} else {
    if (stringr::str_detect(dates[2], '^-?[1-9][0-9]*$')) {
        date_base = lubridate::ymd(dates[1])
        date_offset = as.integer(dates[2])
    } else {
        error = TRUE
    }
}

if (!error) {
    glue::glue("{lubridate::ymd(date_base) + as.integer(date_offset)}")
} else {
    glue::glue('Rscript future.R <date_base> <date_offset>
               e.g. Rscript future.R 1990-01-01 10000')
}
