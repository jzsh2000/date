get_diff_ymd <- function(date_new, date_old) {

    string2date <- function(str) {
        if (class(str) != 'Date') {
            return(lubridate::ymd(str))
        } else {
            return(str)
        }
    }
    date_old = string2date(date_old)
    date_new = string2date(date_new)

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
