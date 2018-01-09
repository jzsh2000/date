dates = commandArgs(TRUE)

if (length(dates) == 0) {
    glue::glue('Rscript future.R <date_base> <dates>')
} else if (length(dates) == 1) {
    if (file.exists('BASE')) {
        date_base = readLines('BASE')
        glue::glue("{lubridate::ymd(date_base) + as.integer(dates[1])}")
    } else {
        glue::glue('Rscript future.R <date_base> <dates>')
    }
} else {
    glue::glue("{lubridate::ymd(dates[1]) + as.integer(dates[2])}")
}
