dates = commandArgs(TRUE)

if (length(dates) == 0) {
    if (file.exists('BASE')) {
        date_base = readLines('BASE')
        glue::glue("{Sys.Date() - lubridate::ymd(date_base)}")
    } else {
        glue::glue('Rscript duration.R <date_old> <date_new>')
    }
} else if (length(dates) == 1) {
    if (file.exists('BASE')) {
        date_base = readLines('BASE')
        glue::glue("{lubridate::ymd(dates[1]) - lubridate::ymd(date_base)}")
    } else {
        glue::glue('Rscript duration.R <date_old> <date_new>')
    }
} else {
    glue::glue("{lubridate::ymd(dates[2]) - lubridate::ymd(dates[1])}")
}
