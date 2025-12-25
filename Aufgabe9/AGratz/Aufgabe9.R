# Pakete dokumentieren
library(tidyverse)
library(lubridate)

# Aufgabe1 - .csv-File laden
df <- read_csv("MON Datensatz_176703_202312.csv")

# Aufgabe2 - Tabellen interpretieren
str(df)

# Attribute: 
# - 'station' (Stations-ID)
# - 'time' (Zeitstempel)
# - 't' (Temperatur)
# - 'substation' (Teilstation)
#
# Zeitliche Auflösung:
# Eine zeitliche Auflösung erfolgt von 1767-04-01 bis 2023-12-01.

# Aufgabe3 - Einträge ohne "t"-Eintrag droppen
df_clean <- df %>% 
  tidyr::drop_na(t)

# Aufgabe4 - Zeitreihe begrenzen
# Habe hier die Jahre 2022 bis 2023 in dem Zeitstrahl genommen
df_filtered <- df_clean %>% 
  filter(year(time) >= 2022)

# Aufgabe5 - Erstellung Variablen für Visualisierung
# Nach der Zeit gruppiert
df_stats <- df_filtered %>%
  group_by(time) %>%
  summarise(
    mean_temp = mean(t, na.rm = TRUE),       # Mittlere Lufttemperatur hier mean_temp
    sd_temp = sd(t, na.rm = TRUE),           # Standardabweichung hier sd_temp
    n = n(),                                 # Anzahl Stationen hier n
    # Standard Error hier se
    se = sd_temp / sqrt(n),
    # 95% Konfidenzintervall hier ki_upper und ki_lower
    # Formel: Mean +/- 1.96 * SE
    ki_upper = mean_temp + 1.96 * se,
    ki_lower = mean_temp - 1.96 * se
  )

# Aufgabe6 - Visualisierung
ggplot(data = df_stats, aes(x = time)) +
  # Mittlere Temperatur
  geom_line(aes(y = mean_temp), color = "black") +
  # Obere KI
  geom_line(aes(y = ki_upper), color = "red") +
  # Untere KI
  geom_line(aes(y = ki_lower), color = "green") +
  labs(
    title = "Mittlere Lufttemperatur in Salzburg mit 95% Konfidenzintervall(2022-01 bis 2023-12)",
    x = "Zeit",
    y = "Temperatur (°C)"
  ) +
  theme_minimal() # Plot schöner machen
