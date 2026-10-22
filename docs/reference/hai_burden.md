# Burden of five hospital infections in Germany and the EU/EEA

Published estimates of five infections that patients catch in hospital.
Each estimate is a yearly rate per 100,000 people. The numbers come from
hospital surveys in 2011 and 2012. Each row is one infection in one
survey sample for one measure.

## Usage

``` r
hai_burden
```

## Format

A tibble with 45 rows and 6 columns.

- survey:

  Survey sample. Germany (national sample) is the main German estimate.
  Germany (convenience sample) is a second and larger German sample.
  EU/EEA average is the European estimate.

- infection:

  Type of hospital infection.

- measure:

  What is counted. Infections is the number of new cases. Deaths is the
  number of deaths caused by the infection. DALYs is the number of
  healthy years lost.

- estimate:

  Median estimate per 100,000 people each year.

- lower:

  Lower limit of the 95% uncertainty interval.

- upper:

  Upper limit of the 95% uncertainty interval.

## Source

Table 2 of Zacher et al. (2019), Eurosurveillance 24(46),
<https://doi.org/10.2807/1560-7917.ES.2019.24.46.1900135>

## Details

The numbers are model estimates and not direct counts. A DALY adds the
years lost to early death and the years lived in poor health.
