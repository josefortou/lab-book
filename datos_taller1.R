library(vdem)

datos_taller1 <- extract_vdem(
  section_number = c(2, 3),
  include_ord = TRUE
) %>%
  filter(year > 1989)

datos_taller1 <- datos_taller1 %>%
  mutate(
    v2elparlel = case_when(
      v2elparlel == 0 ~ "mayoritario",
      v2elparlel == 1 ~ "proporcional",
      v2elparlel %in% c(2, 3) ~ "otros"
    ),
    v2elmulpar = case_when(
      v2elmulpar_ord %in% c(0, 1, 2) ~ "no/limitado",
      v2elmulpar_ord %in% c(3, 4) ~ "sí"
    )
  ) %>%
  select(
    vdem_country_name, year,
    v2x_polyarchy, # electoral democracy
    v2psoppaut, # opposition party autonomy
    v2elparlel, # electoral system,
    v2elmulpar # elections multiparty)
  )

datos_taller1 %>%
  count(v2elparlel, v2elmulpar)

table(datos_taller1$v2elmulpar, datos_taller1$v2elparlel)

datos_taller1 %>%
  ggplot(aes(v2x_polyarchy, v2psoppaut)) +
  geom_point()

# save

write_csv(datos_taller1, "data/datos_taller1.csv")
