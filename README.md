Prepare (optional)
------------------

Set the base date by creating a file called `BASE`, with the format '%Y %m %d'.
The following is an [example](BASE.example):
```
1990 01 01
```

Use the script
--------------

1. calculate how many days have past since a specified date (e.g. your birthday)

    ### number of days past since the `BASE` date
    ```bash
    ./duration
    ```

    or

    ### number of days past since 1990-01-01
    ```bash
    ./duration 1990-01-01
    ```

    or

    ### number of years, months, and days past since 1990-01-01
    ```bash
    ./duration -v 1990-01-01
    ```

2. get the date of a specified date plus some days

    ### 10000 days after the `BASE` date
    ```bash
    ./future 10000
    ```

    or

    ### 10000 days after 1990-01-01
    ```bash
    ./future 1990-01-01
    ```

    ### number of days from now correspond to 10000 days after 1990-01-01
    ```bash
    ./future -v 1990-01-01
    ```

    or

    ### 20000 days after 1990-01-01
    ```bash
    ./future 1990-01-01 20000
    ```

3. get the date of today

    ```bash
    ./today
    ```

Dependencies
------------

R packages:

* [lubridate](https://github.com/tidyverse/lubridate)
* [glue](https://github.com/tidyverse/glue)
* [here](https://github.com/krlmlr/here)
