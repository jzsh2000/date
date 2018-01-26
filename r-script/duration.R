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

get_diff_ymd <- function(date_new, date_old) {
    reversed <- FALSE
    reverse_date <- function() {
        date_tmp <- date_old
        date_old <- date_new
        date_new <- date_tmp
        reversed = TRUE
    }

    if (year(date_old) > year(date_new)) {
        reverse_date()
    } else if (year(date_old) == year(date_new)) {
        if (month(date_old) > month(date_new)) {
            reverse_date()
        } else if (month(date_old) == month(date_new)) {
            if (day(date_old) > day(date_new)) {
                reverse_date()
            }
        }
    }

    diff_y <- 0
    diff_m <- 0
    diff_d <- 0

    if (month(date_new) > month(date_old)) {
        diff_y = year(date_new) - year(date_old)
    } else if (month(date_new) == month(date_old)) {
        if (day(date_new) >= day(date_old)) {
            diff_y = year(date_new) - year(date_old)
        } else {
            diff_y = year(date_new) - year(date_old) - 1
        }
    } else {
        diff_y = year(date_new) - year(date_old) - 1
    }

    if (day(date_new) >= day(date_old)) {
        diff_m = (month(date_new) - month(date_old)) %% 12
        diff_d = day(date_new) - day(date_old)
    } else {
        diff_m = (month(date_new) - month(date_old)) %% 12 - 1
        diff_d = as.numeric(date_new - ymd(glue::glue('{ifelse(month(date_new) == 1, year(date_new) - 1, year(date_new))}-{ifelse(month(date_new) == 1, 12, month(date_new) - 1)}-{day(date_old)}')))
    }
    c(diff_y, diff_m, diff_d)
}

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
    glue::glue('Rscript duration.R <date_old> <date_new>')
} else {
    if (!verbose) {
        glue::glue('{time_diff}')
    } else {
        # time_diff_weeks = as.numeric(time_diff) %/% 7
        # time_diff_days = as.numeric(time_diff) %% 7
        #
        # if (time_diff_days == 0) {
        #     glue::glue('{time_diff_weeks} weeks')
        # } else {
        #     glue::glue('{time_diff_weeks} weeks, \\
        #                {time_diff_days} days')
        # }
        glue::glue('{time_diff_verbose[1]} years, {time_diff_verbose[2]} months, {time_diff_verbose[3]} days')
    }
}
