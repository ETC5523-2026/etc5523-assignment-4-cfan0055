# Healthy years lost for every 100 infections

Divides healthy years lost (DALYs) by the number of infections. The
result shows how harmful one infection is, not how common it is.

## Usage

``` r
harm_per_infection(data)
```

## Arguments

- data:

  A data frame with the same columns as `hai_burden`.

## Value

A data frame with one row per survey sample and infection. The column
`dalys_per_100` is the number of healthy years lost for every 100
infections.

## Examples

``` r
harm_per_infection(hai_burden)
#> # A tibble: 15 × 5
#>    survey                       infection         Infections DALYs dalys_per_100
#>    <chr>                        <chr>                  <dbl> <dbl>         <dbl>
#>  1 EU/EEA average               Bloodstream infe…       22.2  76.2           343
#>  2 EU/EEA average               Pneumonia              144.  110.             76
#>  3 EU/EEA average               C. difficile inf…       16    10              62
#>  4 EU/EEA average               Urinary tract in…      175.   57.1            33
#>  5 EU/EEA average               Surgical site in…      111.   35.1            32
#>  6 Germany (convenience sample) Bloodstream infe…       52.7 114.            215
#>  7 Germany (convenience sample) Pneumonia              162.  103.             64
#>  8 Germany (convenience sample) C. difficile inf…       44.5  26.5            60
#>  9 Germany (convenience sample) Surgical site in…      147.   45              31
#> 10 Germany (convenience sample) Urinary tract in…      229.   69.5            30
#> 11 Germany (national sample)    Bloodstream infe…       33.4  72.2           216
#> 12 Germany (national sample)    Pneumonia              132    86.1            65
#> 13 Germany (national sample)    C. difficile inf…       44.6  25.9            58
#> 14 Germany (national sample)    Urinary tract in…      265.   82.6            31
#> 15 Germany (national sample)    Surgical site in…      115.   35.7            31
```
