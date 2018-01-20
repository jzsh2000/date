dates = commandArgs(TRUE)

if ('-v' %in% dates) {
    verbose = TRUE
    dates = dates[-match('-v', dates)]
} else {
    verbose = FALSE
}

parser_error <- FALSE
base_file = file.path(here::here(), 'BASE')

if (length(dates) <= 1) {
    if (file.exists(base_file)) {
        date_base = lubridate::ymd(readLines(base_file))
    } else {
        parser_error = TRUE
    }

    if (length(dates) == 0) {
        date_offset = 10000
    } else {
        if (stringr::str_detect(dates[1], '^-?[1-9][0-9]*$')) {
            date_offset = as.integer(dates[1])
        } else if (!is.na(suppressWarnings(lubridate::ymd(dates[1])))) {
            date_base = lubridate::ymd(dates[1])
            date_offset = 10000
        } else {
            parser_error = TRUE
        }
    }
} else {
    if (stringr::str_detect(dates[2], '^-?[1-9][0-9]*$')) {
        date_base = lubridate::ymd(dates[1])
        date_offset = as.integer(dates[2])
    } else {
        parser_error = TRUE
    }
}

if (parser_error) {
    glue::glue('Rscript future.R <date_base> <date_offset>
               e.g. Rscript future.R 1990-01-01 10000')
} else {
    if (!verbose) {
        glue::glue("{lubridate::ymd(date_base) + as.integer(date_offset)}")
    } else {
        time_diff = lubridate::ymd(date_base) + as.integer(date_offset) - Sys.Date()
        if (time_diff < 0) {
            glue::glue('{-time_diff} days earlier')
        } else if (time_diff > 0) {
            glue::glue('{time_diff} days from now')
        } else {
            glue::glue('today')
        }
    }
}
