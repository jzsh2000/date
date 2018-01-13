Prepare (optional)
------------------

Set the base date by creating a file called `BASE`, with the format '%Y %m %d'.
The following is an example:
```
1990 01 01
```

Use the script
--------------

1. calculate how many days have past since a specified date (e.g. your birthday)

    ```bash
    Rscript duration.R
    ```

    or

    ```bash
    Rscript duration.R 1990-01-01
    ```

    or

    ```bash
    Rscript duration.R -v 1990-01-01
    ```

2. get the date of a specified date plus some days

    ```bash
    Rscript future.R 10000
    ```

    or

    ```bash
    Rscript future.R 1990-01-01 10000
    ```
