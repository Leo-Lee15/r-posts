#' --- 
#' title: Tarea 01
#' output:
#'   html_document:
#'     theme: yeti
#'     toc: true
#'     toc_float: true
#' ---
#+ echo = FALSE, message = FALSE, warning = FALSE
knitr::opts_chunk$set(message = FALSE, warning = FALSE)
library(jbkmisc)
library(ggplot2)
theme_set(theme_jbk())
#' 
#' ## Evaluaci�n y Consideraciones
#' 
#' Cada grupo deber� enviar un mail a <jbkunst@gmail.com> con el asunto 
#' "Tarea namber wan" (sin comillas) adjuntando un script el cual deber� 
#' correr sin errores al ser ejecutado y debe claramente se�alar los comandos
#' (esto es el c�digo mismo) con el cual obtuvo las respuestas incluyendo 
#' comentarios.
#' 
#' Se evaluar� tango el c�digo como el resultado. Con esto se intenta evitar las 
#' respuestas _al ojo_ o usando otras herramientas como _excel_.
#' Por ejemplo, `script_grupo_1.R`:
#' 
#' ```
#' # Pregunta 1
#' # Para esta pregunta debemos seleccionar filtrar el data frame y segun x > 5
#' # y reordenar segun la variable y:
#' 
#' data %>% 
#'   filter(x > 5) %>% 
#'   arrange(y)
#' 
#' ```
#' 
#' Son libres de hacer preguntas v�a mail, ya sea especifiaci�n de las preguntas
#' u otras cosas pero siempre h�ganlo escribi�ndolo a todo el grupo.
#' 
#' Espero los script a __m�s tardar__ el mi�rcoles 26 de este m�s (y de este a�o)
#' a las 11.59 PM. Obviamente lo pueden enviar el script m�s tarde, la �nica 
#' salvedad es que la nota final ser� la nota por el script dividido por 1.25 por 
#' cada hora que pase desde el l�mite. A modo de ejemplo si la nota es un 5.5, 
#' y fue entregado a las 3AM, la nota final ser�:
#' 
nota_script <- 6.0
nota_final <- nota_script/(1.11^3)
round(nota_final, 1)
#' 
#' 
#' ## Requerimientos
#' 
#' Necesitaremos algunos paquetes para trabajar. El siguiente c�digo
#' instalar� lo requerido:
#' 
library(tidyverse)


paquetes_a_instalar <- c("gapminder", "babynames", "nasaweather", "fueleconomy",
                         "fivethirtyeight")

for(p in paquetes_a_instalar) {
  message("Instalando ", p)
  if(!p %in% rownames(installed.packages())) install.packages(p)
  library(p, character.only = TRUE)
}

data(gapminder)
glimpse(gapminder)

data(babynames)
glimpse(babynames)

fueleconomy::common
fueleconomy::vehicles
data(vehicles)
glimpse(vehicles)

ggplot(vehicles) + 
  geom_point(aes(hwy, cty), alpha = 0.3) + 
  facet_grid(cyl ~ fuel)

nasaweather::atmos
nasaweather::atmos %>% 
  group_by(lat, long) %>% 
  count() %>% 
  ungroup() %>% 
  count(n)

nasaweather::atmos %>% 
  count(year, month) %>% 
  count()
nasaweather::glaciers


glimpse(fivethirtyeight::bob_ross)
glimpse(fivethirtyeight::bad_drivers)
glimpse(fivethirtyeight::avengers)
glimpse(fivethirtyeight::drinks)


#' ![](https://az616578.vo.msecnd.net/files/2015/11/06/6358243226338872701442058152_oq731NH.gif)
#' 
#' ## Pregunta 0 (el punto base)
#' 
#' Considere, la tabla `births` del paquete `babynames`. Esto es:
data("births", package = "babynames")
head(births)

#' �Cu�ntas columnas y filas posee la tabla _births_?
#' 
#' ## Pregunta 1
#' 
#' Considere, la tabla `births` del paquete `babynames`. Estudie los 
#' nacimientos por a�os en EE.UU:
ggplot(births) +
  geom_line(aes(year, births)) 

#' �En que _decada_ se obtuvo la menor cantidad de nacimientos?.
#' 
#' ## Pregunta 2
#' 
#' Considerando ahora la tabla `babynames` del paquete `babynames`:
data("babynames", package = "babynames")
glimpse(babynames)

#' Realice el proceso necesario para obtener el mismo estructura en cuanto
#' a _columnas_ que la tabla `births`. 
#' 
#' ## Pregunta 3
#' 
#' Genere un data frame partiendo de la tabla babyanes `babynames` y conteniendo
#' los nacimientos de personas de g�nero femenino con el nombre _Nala_, _Ariel_
#' y _Elsa_ desde los a�os 1980 en adelante. 
#' 
#' ## Pregunta 4
#' 
#' Con el data frame obtenido en la pregunta anterior genere un gr�fico que 
#' contenga la informaci�n de los nacimientos por a�o de cada uno de los
#' nombres mencionados y __mencione__ una hip�tesis/suposici�n al respecto de lo 
#' observado.
#' 
#' hint: Use `facet_wrap(~ name, scales = "free_y")`.
#' 
#' 
#' ## Pregunta 5
#' 
#' Utilizando la tabla `airports` y `flights` del paquete `nycflights13`
#' obtenga una tabla que contenga conteos de vuelos seg�n su destino adem�s 
#' de la longitud y latidud del aeropuerto (de destino).
#' 
#' ## Pregunta 6
#' 
#' Apoy�ndose del siguiente gr�fico
us <- map_data("state")

glimpse(us)

ggmap <- ggplot() +
  geom_polygon(data = us, aes(long, lat, group = group), 
               alpha = 0.25) +
  coord_fixed() # esto es para mantener la raz�n 1:1

ggmap

#' Agregue una capa de de puntos ubicando los aeropuertos obtenidos de la pregunta
#' anterior y usando adem�s: `aes(size = la_cantidad_de_vuelos_a_dicho_aeropuerto)`.
#' 
#' tip: Use por favor geom_point(alpha = un_numero_menor_que_1) para tener
#' un resultado agradable a la vista.
#' 
#' ## Pregunta 7
#' 
#' A la izquiera del gr�fico anterior se observan 2 puntos. Genere el/los pasos
#' necesarios para seleccionarlos usando la tabla resultante de la pregunta 5
#' para identificar los nombres de dichos areopuertos y responda �D�nde est�n?
#' �Que gracias tienen?
#' 
#' ## Pregunta 8
#' 
#' Considere la tabla `vehicles` del paquete `fueleconomy`.
#' 
#' Genere un subconjunto de la tabla `vehicles` considerando las 10 clases 
#' (columna `class`) m�s comunes y:
#' 
#' 1. Genere un gr�fico de densidades del consumo en carretera (`hwy`)
#' separando por clase de veh�culo. 
#' 
#' 2. Averigu� como usar la funci�n `geom_boxplot` para generar un gr�fico
#' de _boxplots_ y as� comparar las distribuciones de rendimiento seg�n clase.
#' 
#' ## Pregunta 9
#' 
#' Con los 2 gr�ficos anteriormente obtenidos argumente cuales son las
#' debidildades y fortalezas de cada tipo de visualizaci�n. 
#' 
#' ## Pregunta 10
#' 
#' Usando la tabla anterior calcule el promedio, el m�nimo y el m�ximo de
#' rendimiento seg�n clase de veh�culo.

