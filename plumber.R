library(airtabler)
library(dplyr)
library(purrr)
library(plotly)
library(ggplot2)

#' Renvoie une matrice de priorisation
#' @param base la base airtable utilisée
#' @param groupe si "all", tous les groupes ensemble. Si un chiffre, le numéro du groupe concerné. 
#' @get /plot
#' @serializer htmlwidget
function(base = "app996bwK0OaYObse", groupe="all") {
  
  if (groupe %in% "all") {
    data <- map_df(1:3, ~ air_select(base, paste0("Priorisation groupe ", .)))
  } else {
    data <- priorisation_1 <- air_select(base, paste0("Priorisation groupe ", groupe))
  }
  
  data <- data %>% 
    select(-`Field 11`, -`Note de faisabilité`, - `Note de valeur d'usage`) %>% 
    mutate(`Sensibilité RGPD` = - `Sensibilité RGPD`,
           Thématique = map_chr(Thématique, ~ if_else(is.null(.), NA_character_, .)),
           faisabilite = rowMeans(select(., `En combien de temps ce jeu peut-il être disponible pour être retravaillé ?`, `Quel est le format source ?`, `Quel serait le travail de mise en qualité nécessaire avant l'ouverture de ce jeu de données ?`, `Sensibilité RGPD`), na.rm = TRUE),
           valeur = rowMeans(select(., `Potentiel de réutilisation interne`, `Potentiel de création de service`, `Opportunité de communication/transparence`), na.rm = TRUE))
  
  
  p <- data %>% 
    ggplot(aes(x = faisabilite, y = valeur)) +
    geom_text(aes(label = Name, colour = `Thématique`), position = "jitter") +
    xlim(1, 4) +
    ylim(1, 4) +
    geom_vline(xintercept = 2.5, color = "grey") +
    geom_hline(yintercept = 2.5, color = "grey") +
    theme_minimal() +
    theme(panel.grid = element_blank()) +
    xlab("Faisabilité") +
    ylab("Valeur d'usage")
  ggplotly(p)
  
  
}
