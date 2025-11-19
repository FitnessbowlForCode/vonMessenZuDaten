library(tidyverse)
library(nycflights13)
library(knitr)
weather_from_nyc <- nycflights13::weather
flights_from_nyc <- nycflights13::flights

# 1. Gesamte Flüge
alle_fluege_join <- dplyr::inner_join(
  weather_from_nyc,
  flights_from_nyc,
  by = c("origin", "time_hour")
)

# 2. Gefilterte Flüge
gefilterte_fluege <- dplyr::inner_join(
  weather_from_nyc,
  flights_from_nyc,
  by = c("origin", "time_hour")
) %>%
  filter(wind_speed >= 40) 

# 3. Die Gesamtanzahl der Flüge
gesamt_anzahl <- nrow(alle_fluege_join)
print(paste("Gesamtzahl der Flüge im Join:", gesamt_anzahl))

# 3. Die Gesamtanzahl der gefilterten Flüge
gefilterte_anzahl <- nrow(gefilterte_fluege)
print(paste("Anzahl der Starkwind-Flüge (> 40 mph):", gefilterte_anzahl))

# 4. Prozentsatz berechnen
prozentsatz_starkwind <- (gefilterte_anzahl / gesamt_anzahl) * 100

# 5. Ausgabe Prozentsatz
print(paste("Anteil der Flüge mit Wind > 40 mph: ", 
            round(prozentsatz_starkwind, 2), 
            "%"))

### Angabe:
## Führen Sie eine Recherche durch (Quellen müssen dokumentiert werden!), um herauszufinden, bei welcher
# Windgeschwindigkeit typischerweise Flüge ausfallen und legen Sie basierend auf dieser Recherche einen Grenzwert
# fest. Wie viele Flüge hätten auf Basis des festgelegten Grenzwertes ausfallen müssen?

## Antwort: Die Fragestellung kann mit den vorliegenden Daten nicht beantwortet werden.
# Soweit ich recherschieren konnte, hängt beiepielsweise der Abbruch eines Starts von vielen Faktoren ab.
# Herstellerangaben vom Flugzeug, Seitenwind, Seitenböhen, Rollbahnbeschaffenheit, Vorschriften der Flugsicherung(da wir in den USA sind ist die FAA zuständig), usw.

# Ich nehme mir 40mph beim Parameter wind_speed als Grenzwert heraus.
# 31 Flüge hätten auf Basis des Grenzwertes ausfallen müssen.

## Um welchen prozentuellen Anteil
# an allen Flügen handelt es sich dabei?

## Antwort: 
# Es handelt sich um einen Promilewert von 0.01%

## Welche Einheit wird bei der Variable wind_speed verwendet? Wenn eine Umrechnung erforderlich war, wie haben Sie
# diese Umrechnung durchgeführt (z.B. mph auf km/h oder m/s)?

## Antwort:
# Wie in der Quelle angegeben, alle Angeben bezüglich des Windes sind in mph angegeben. Ein Umrechnung war nicht nötig.

### Quellen:
## Wollte wissen was die Parameter wind_dir, wind_speed & wind_gust bedeuten. Angaben sind in mph.
# https://github.com/tidyverse/nycflights13/blob/df98ef215aa8216fe0838a0b8ac5bada646d814c/R/weather.R

