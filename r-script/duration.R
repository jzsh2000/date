dates = commandArgs(TRUE)
suppressMessages(suppressWarnings(library(lubridate)))

if ('-v' %in% dates) {
    verbose = TRUE
    dates = dates[-match('-v', dates)]
} else {
    verbose = FALSE
}

parser_error = FALSE
time_diff = as.difftime(0, units = 'days')
time_diff_verbose = c(0,0,0)
base_file = file.path(here::here(), 'BASE')

source('r-script/func.R')

if (length(dates) == 0) {
    if (file.exists(base_file)) {
        date_base = readLines(base_file)
        time_diff = Sys.Date() - ymd(date_base)
        time_diff_verbose = get_diff_ymd(Sys.Date(), ymd(date_base))
    } else {parser_error = TRUE}
} else if (length(dates) == 1) {
    if (is.na(suppressWarnings(ymd(dates[1])))) {
        parser_error = TRUE
    } else {
        time_diff = Sys.Date() - ymd(dates[1])
        time_diff_verbose = get_diff_ymd(Sys.Date(), ymd(dates[1]))
    }
} else {
    if (any(is.na(suppressWarnings(ymd(dates[1:2]))))) {
        parser_error = TRUE
    } else {
        time_diff = ymd(dates[2]) - ymd(dates[1])
        time_diff_verbose = get_diff_ymd(ymd(dates[2]), ymd(dates[1]))
    }
}

if (parser_error) {
    glue::glue('Rscript duration.R <date_old> <date_new>
               e.g. Rscript duration.R 1990-01-01 2008-08-08')
} else {
    if (!verbose) {
        glue::glue('{time_diff}')
    } else {
        glue::glue('{time_diff_verbose[1]} years, {time_diff_verbose[2]} months, {time_diff_verbose[3]} days')
    }
}
