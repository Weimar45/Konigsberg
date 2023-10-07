# ----- Descripción del Script ----
#
# Análisis de Marco Reus
# Fecha: 20/07/2023
# Última vez editado por: Alejandro Navas González
#

# ------ Load packages ------

library(tidyverse)  # for data wrangling
library(rvest)      # for web scraping
library(lubridate)  # for date formats 
library(tidyverse) # for data wrangling
library(ggimage)   # adding images to ggplot
library(patchwork) # attaching ggplot objects
library(viridis)   # viridis color schemes 


url <- "https://www.transfermarkt.com/marco-reus/alletore/spieler/35207/saison//verein/0/liga/0/wettbewerb//pos/0/trainer_id/0/minute/0/torart/0/plus/1"
web <- read_html(url)
doc <- html_table(web, fill = TRUE)
tab <- doc[[2]]
glimpse(tab)

tab <- tab[,c(2,3,4,5,9,12,13,14,15)] 
names(tab) <- c("competition","day","date","venue",
                "against","minute","standing","type","provider")
glimpse(tab)

tab <- tab[!grepl("Season",tab$venue),] # Eliminas la fila donde pone la temporada
tab$against <- str_trim(str_remove_all(tab$against,"\\(.*\\)"))
tab$minute <- readr::parse_number(tab$minute)
glimpse(tab)

# Filtrar partidos no oficiales. 
tab[tab == ""] <- NA
tab <- tab %>% filter(!is.na(competition))


# Seleccionar el nombre del club.
club <- web %>%
  html_nodes(xpath = "//td/a/img") %>%
  html_attr("alt")
club <- club[seq(1,length(club),2)]

# Seleccionar el escudo del club. 
club_crest <- web %>%
  html_nodes(xpath = "//td/a/img") %>%
  html_attr("src")
club_crest <- club_crest[seq(1,length(club_crest),2)]


# Conteo de goles. 
tab <- tab %>% mutate(goals=row_number())

# A?adir las im?genes. 
tab$club_crest <- tab$club_crest %>% 
  str_remove("_.*") %>%
  paste0(".png") %>% 
  str_replace("tiny","head")

# Transformar el nombre del club en una variable categ?rica.
tab <- tab[c(1:162),] # Quitar resumen de los goles.
tab$club <- factor(club,levels = unique(club))
glimpse(tab)

get_goals <- function(player = "",id = ""){
  url <- paste0("https://www.transfermarkt.co.uk/",player,"/alletore/spieler/",id,"/saison//verein/0/liga/0/wettbewerb//pos/0/trainer_id/0/minute/0/torart/0/plus/1")
  web <- read_html(url)
  #extract and clean data
  return(tab)
}


# Naciminto del Jugador. 
birthdate <- html_node(web,".dataDaten .dataValue") %>% 
  html_text() %>% 
  str_squish() %>%
  substr(start = 1, stop = 12) %>%
  str_replace(pattern = " ", replacement = "/") %>%
  str_replace(pattern = ", ", replacement = "/") %>%
  str_replace(pattern = "May", replacement = "05") %>%
  as.Date(birthdate, format="%m/%d/%Y")

# Cambio de la columna de fecha del gol a la clase Date. 
tab$date <- as.Date(tab$date, format="%m/%d/%Y") %>%  str_replace(pattern = "00", replacement = "20")
glimpse(tab)
# Edad del jugador en cada uno de los goles. 
tab$age  <- time_length(x = difftime(tab$date, birthdate), unit = "years")

player <- html_node(web,"h1") %>% html_text()
portrait <- html_node(web,".dataBild img") %>% html_attr("src")


# Definir una funci?n que englobe todo lo anterior y lo meta en una lista que adem?s tenga la imagen del jugador. 

get_goals <- function(player = "marco-reus", id = "35207"){
  url <- paste0("https://www.transfermarkt.co.uk/",player,"/alletore/spieler/",id,"/saison//verein/0/liga/0/wettbewerb//pos/0/trainer_id/0/minute/0/torart/0/plus/1")
  web <- xml2::read_html(url)
  player <- rvest::html_text(rvest::html_node(web,"h1"))
  portrait <- rvest::html_attr(rvest::html_node(web,".dataBild img"),"src")
  birthdate <- html_node(web,".dataDaten .dataValue") %>% 
    html_text() %>% 
    str_squish() %>%
    substr(start = 1, stop = 12) %>%
    str_replace(pattern = " ", replacement = "/") %>%
    str_replace(pattern = ", ", replacement = "/") %>%
    str_replace(pattern = "May", replacement = "05") %>%
    as.Date(birthdate, format="%m/%d/%Y")
  
  doc <- rvest::html_table(web,fill=TRUE)
  tab <- doc[[2]]
  tab <- tab[,c(2,3,4,5,9,12,13,14,15)]
  names(tab) <- c("competition","day","date","venue","against","minute","standing","type","provider")
  tab <- as.data.frame(tab)
  tab <- tab[!grepl("Season",tab$venue),]
  tab$against <- stringr::str_remove_all(tab$against,"\\(.*\\)")
  tab$against <- stringr::str_trim(tab$against)
  
  club <- web %>%
    rvest::html_nodes(xpath = "//td/a/img") %>%
    rvest::html_attr("alt")
  club <- club[seq(1,length(club),2)]
  
  club_crest <- web %>%
    rvest::html_nodes(xpath = "//td/a/img") %>%
    rvest::html_attr("src")
  club_crest <- club_crest[seq(1,length(club_crest),2)]
  
  for(i in 1:nrow(tab)){
    if(tab$competition[i]==""){
      tab$competition[i] <- tab$competition[i-1]
      tab$date[i] <- tab$date[i-1]
      tab$day[i] <- tab$day[i-1]
      tab$venue[i] <- tab$venue[i-1]
      tab$against[i] <- tab$against[i-1]
      club <- append(club,club[i-1],after = i-1)
      club_crest <- append(club_crest,club_crest[i-1],after = i-1)
    }
  }
  tab$minute <- readr::parse_number(tab$minute)
  tab <- tab[-nrow(tab),]
  tab$club <- club
  tab$club_crest <- club_crest
  tab$date <- as.Date(tab$date,format = "%m/%d/%y")
  idx <- (lubridate::year(tab$date)>2020)+0
  tab$date <- tab$date-lubridate::years(idx*100)
  tab <- tab[!is.na(tab$minute),]
  
  tab$age  <- lubridate::time_length(difftime(tab$date,birthdate),"years")
  tab <- tab %>% dplyr::mutate(goals=dplyr::row_number())
  
  tab$club_crest <- tab$club_crest %>% 
    stringr::str_remove("_.*") %>%
    paste0(".png") %>% 
    stringr::str_replace("tiny","head")
  
  tab$club <- factor(tab$club,levels = unique(tab$club))
  
  return(list(data=tab,name=player,birthday=birthdate,portrait=portrait))
}

Reus <- get_goals()
glimpse(Reus)


theme_goals <- function(ticks=TRUE,axis=TRUE,grid=""){
  ret <- theme_light() +
    theme(panel.background = element_rect(fill="#666666",colour = "#666666"),
          plot.background = element_rect(fill="#666666",colour = "#666666"),
          legend.background = element_rect(fill="#666666", colour = "#666666"),
          legend.box.background = element_rect(fill="#666666",colour = "#666666"),
          legend.key = element_rect(fill="#666666",colour = "#666666"),
          legend.text = element_text(colour="white",size=rel(1.3)),
          axis.text = element_text(colour="white",size=rel(0.9)),
          axis.title = element_text(colour="white",size=rel(1.1)),
          legend.position = "bottom",
          plot.title = element_text(color="white",face = "bold",size=rel(2.2)),
          plot.subtitle = element_text(color="white", size=rel(1.3)))
}

# Calcular la posici?n de las crestas. 
crest_pos <- Reus$data %>% 
  group_by(club) %>%
  summarise(x = mean(age),
            y = mean(goals),
            crest = club_crest[1])
crest_pos <- crest_pos[c(3,4,5), ]

ggplot(Reus$data, aes(x = age, y = goals)) +
  geom_image(data = crest_pos, aes(x = x, y = y, image = crest), size=0.06, by='height') +
  scale_size_identity() +
  geom_line(aes(col = club)) + 
  scale_color_viridis_d(option = "viridis", name = "") +
  theme_goals(grid = "y") +
  scale_x_continuous(breaks = seq(17, 32, by = 1)) +
  scale_y_continuous(expand = c(0, 0), breaks = seq(20, max(Reus$data$goals), by = 20)) +
  labs(title=Reus$name,
       subtitle=paste("Goals", nrow(Reus$data),"between",
                      min(Reus$data$date),"&",max(Reus$data$date)),
       x = "Age", 
       y = "Goals")-> p_date

p_date
ggsave(p_date, filename = "RBloggers_results/Reus_History.png", width = 14, height = 11)


Reus$data$y <- floor(Reus$data$minute/10)
Reus$data$x <- Reus$data$minute%%10
Reus$data$y[Reus$data$x==0] <- Reus$data$y[Reus$data$x==0]-1
Reus$data$x[Reus$data$x==0] <- 10
Reus$data %>%
  dplyr::filter(minute<=90) %>%
  group_by(x,y,minute) %>%
  count() %>%
  ggplot(aes(x,y))+geom_tile(aes(fill=n),colour="#666666",size=1)+
  geom_text(aes(label=n))+
  scale_y_reverse(breaks=0:8,
                  labels=c("1'-10'","11'-20'","21'-30'","31'-40'","41'-50'","51'-60'",
                           "61'-70'","71'-80'","81'-90'"))+
  viridis::scale_fill_viridis(option = "D",name="",limits=c(0,15),na.value="#FF7F00")+
  theme_goals(ticks = F,axis = F, grid = "")+
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(), 
        axis.ticks.y = element_blank(), legend.position = "none",
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.border = element_blank())+
  coord_fixed()+
  labs(subtitle="Minutos de Anotaci?n de los Goles",
       x = "",
       y = "") -> p_min
p_min

stringi::stri_reverse("1:10")

Reus$data %>% 
  mutate(standing_adj = ifelse(venue=="A",stringi::stri_reverse(standing),standing)) %>% 
  group_by(standing_adj) %>% 
  summarise(goals = n()) %>% 
  ggplot(aes(x = reorder(standing_adj,-goals),y = goals))+
  geom_col(fill="#FF7F00") + 
  scale_y_continuous(
    breaks =   seq(0, 75, 10),
    expand = expansion(mult = c(0,0))
  ) + 
  theme_goals(grid = "y")+
  labs(title = Reus$name,
       subtitle="N?mero de Goles en Relaci?n con el Resultado",
       x = "Resultado tras el Gol Anotado", y = "Goles") -> p_stand
p_stand

Reus$data %>% 
  dplyr::filter(provider!="") %>% 
  group_by(provider) %>% 
  summarise(goals = n()) %>% 
  top_n(10, goals) %>% 
  ggplot(aes(x = reorder(provider, goals),y = goals))+
  geom_col(fill="#FF7F00")+
  scale_y_continuous(expand = c(0,0), breaks=seq(0,12,2))+
  theme_goals(grid = "x") +
  labs(x = "", y = "N?mero de Asistencias",subtitle="Top Diez de Asistentes")+
  coord_flip() -> p_prov

Reus$data %>% 
  dplyr::filter(type!="") %>% 
  group_by(type) %>% 
  summarise(goals = n()) %>% 
  ggplot(aes(x = reorder(type, goals),y = goals))+
  geom_col(fill="#FF7F00") +
  scale_y_continuous(expand = c(0,0), breaks=seq(0,100,25))+
  theme_goals(grid = "x")+
  labs(x = "", y = "N?mero de Goles",subtitle="Tipo de Gol")+
  coord_flip() -> p_type

p_prov + 
  p_type + 
  plot_layout(nrow = 1) + 
  plot_annotation(theme=theme(
    plot.background=element_rect(fill="#666666",colour="#666666"),
    plot.title = element_text(color="white",face = "bold",size=rel(1.5))),
    title=Reus$name)

p <- {p_stand + plot_layout(ncol = 2)}+
  {p_min + p_prov + p_type + plot_layout(ncol = 3)}+
  plot_layout(ncol = 1) + 
  plot_annotation(theme = theme(
    plot.background = element_rect(fill="#666666",colour="#666666")))
p

ggsave(p, filename = "RBloggers_results/Graphs_Reus.png", width = 14)




