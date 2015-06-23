# leer archivo de arrestos
arrest_dat <- read.csv("BPD_Arrests.csv")

# variables
my_city <- "Mexico DF"
my_city <- "Monterrey"

# que clase de valor es?
class(arrest_dat)

# de que tamaño es?
dim(arrest_dat)

# cuantas filas tiene?
nrow(arrest_dat)

# que columnas son?
colnames(arrest_dat)

# indexing
# ver data en fila 1, columna 5
arrest_dat[1,5]

# ver datos fila 1 a la 10, columna 5
# usando "slice" notation
arrest_dat[1:10,5]

# datos fila 5, columnas 1 la 5
arrest_dat[5, 1:5]

# que clase cuando es 1 sola columna
class(arrest_dat[1:10,5])

# que clase cuando es 1 sola fila
class(arrest_dat[5,1:5])

# que selecciona esto?
arrest_dat[1:10,1:5]

# "concatenate"
arrest_dat[c(2,4,7,10),1:5]

# si no ponen indices, todas las columnas
arrest_dat[c(2,4,7,10), ]

# 1. seleccione filas 20-30, columnas 5-10
arrest_dat[20:30,5:10]

# 2. seleccione filas 10,20,30,40 todas las columnas
arrest_dat[c(10,20,30,40), ]

# 3. Usen la funcion `seq` para selecionar las primeras
#   10 filas y primeras 10 columnas
arrest_dat[seq(from=1,to=10),seq(1,10)]
# k\igual que
arrest_dat[1:10,1:10]

# 4. Use `seq` para selecionar las filas impares 
#     (1,3,5,7,...). Van a necesitar usar `nrow`
arrest_dat[seq(from=1,by=2,to=nrow(arrest_dat)), ]

# 
arrest_dat[1:10, "age"]

# con lista de nombres
arrest_dat[1:10, c("age", "sex", "race")]

# si es solo una columna hay una operacion especial
# primeras 10 filas, columna "age"
arrest_dat$age[1:10]

# como seleccionar filas 20-30, columna "sex"
# escriban tres formas diferentes

# 1
arrest_dat[20:30, "sex"]

# 2
arrest_dat[20:30, 3]

# 3
arrest_dat$sex[20:30]

# indices logical
my_vector <- letters[1:10]

# las primeras 5 letras
my_vector[c(TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE)]

# las letras en posicion impares
my_vector[c(TRUE,FALSE)]

# crea una lista logica de observaciones,
# donde la edad < 21
age_index <- arrest_dat$age < 21

# ahora seleccionamos observaciones menores de 21
arrest_dat[age_index, ]

# selecione las primeras 5 columnas, para 
# observaciones donde 
# `neighborhood == "Mount Washington"`
mtwashington_index <- arrest_dat$neighborhood == "Mount Washington"
arrest_dat[mtwashington_index,]

arrest_dat[age_index & mtwashington_index,]

# mas exploracion
# ver caracteristicas de "sex"
summary(arrest_dat$sex)
summary(arrest_dat$race)

# vamos a arreglar sex y race
colnames(arrest_dat)[3:4] <- c("race", "sex")

# edad medai arrestos
mean(arrest_dat$age)

# edad mediana
median(arrest_dat$age)

# delito mas frecuente
summary(arrest_dat$incidentOffense)

# summary para variables continuas
summary(arrest_dat$age)

# edad arrestos en Mt. Washington
mean(arrest_dat$age[mtwashington_index])

# numero de arrestos por raza
table(arrest_dat$race[mtwashington_index], 
      arrest_dat$sex[mtwashington_index])

# mas efectivo visualizarlos
boxplot(arrest_dat$age, ylab="Arrest age")

# histograma
hist(arrest_dat$age, nclass=100)

# hay diferencia en la distribucion de edad
# por sexo
boxplot(arrest_dat$age~arrest_dat$sex)

# boxplot de edad condicionado race
boxplot(arrest_dat$age~arrest_dat$race)

barplot(table(arrest_dat$race), 
        ylab="Number of Arrests", 
        xlab="Race")

mtwashington_dat <- arrest_dat[mtwashington_index,]
boxplot(mtwashington_dat$age~mtwashington_dat$sex,
          main="Mt. Washington", ylab="Arrest Age", 
        xlab="Sex")






######################
# indice de observacion en Mount Washington
# funciones

analyze_neighborhood <- function(neighborhood) {
  neighborhood_index <- arrest_dat$neighborhood == neighborhood
  neighborhood_dat <- arrest_dat[neighborhood_index, 
                                 c("age", "sex", "race")]

  # solo hacer analisis si hay mas arrestos de blancos
  # que arrestos de negros en el barrio
  if (sum(neighborhood_dat$race == "W") > 
      sum(neighborhood_dat$race == "B")) {
    # boxplot edad condicionado en sex
    boxplot(neighborhood_dat$age~neighborhood_dat$sex,main=neighborhood)

    # boxplot edad condicionado en race
    boxplot(neighborhood_dat$age~neighborhood_dat$race,main=neighborhood)

    # barplot numero de arrestos por race
    barplot(table(neighborhood_dat$race),main=neighborhood)
  }
}
analyze_neighborhood("Mount Washington")
analyze_neighborhood("Hampden")

## loops

# cuales son los diferentes barrios
neighborhoods <- unique(arrest_dat$neighborhood)

# hacer analisis en los barrios con mas de
# con mas arrestos de blancos que negros
pdf("neighborhood_analysis.pdf", height=6, width=6)
for (neighborhood in neighborhoods) {
  analyze_neighborhood(neighborhood)
}
dev.off()















