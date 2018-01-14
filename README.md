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

    ```bash
    ./duration
    ```

    or

    ```bash
    ./duration 1990-01-01
    ```

    or

    ```bash
    ./duration -v 1990-01-01
    ```

2. get the date of a specified date plus some days

    ```bash
    ./future 10000
    ```

    or

    ```bash
    ./future 1990-01-01 10000
    ```
