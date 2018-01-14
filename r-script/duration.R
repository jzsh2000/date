dates = commandArgs(TRUE)

if ('-v' %in% dates) {
    verbose = TRUE
    dates = dates[-match('-v', dates)]
} else {
    verbose = FALSE
}

parser_error = FALSE
time_diff = as.difftime(0, units = 'days')

if (length(dates) == 0) {
    if (file.exists('BASE')) {
        date_base = readLines('BASE')
        time_diff = Sys.Date() - lubridate::ymd(date_base)
    } else {parser_error = TRUE}
} else if (length(dates) == 1) {
    if (is.na(suppressWarnings(lubridate::ymd(dates[1])))) {
        parser_error = TRUE
    } else {
        time_diff = Sys.Date() - lubridate::ymd(dates[1])
    }
} else {
    if (any(is.na(suppressWarnings(lubridate::ymd(dates[1:2]))))) {
        parser_error = TRUE
    } else {
        time_diff = lubridate::ymd(dates[2]) - lubridate::ymd(dates[1])
    }
}

if (parser_error) {
    glue::glue('Rscript duration.R <date_old> <date_new>')
} else {
    if (!verbose) {
        glue::glue('{time_diff}')
    } else {
        time_diff_weeks = as.numeric(time_diff) %/% 7
        time_diff_days = as.numeric(time_diff) %% 7

        if (time_diff_days == 0) {
            glue::glue('{time_diff_weeks} weeks')
        } else {
            glue::glue('{time_diff_weeks} weeks, \\
                       {time_diff_days} days')
        }
    }
}
