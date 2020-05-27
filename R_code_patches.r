# R_code_patches.r (Analisi per patches in un paesaggio misto agricoltura-foresta) (Pratica del 26/05/20)

# setwd("C:/LAB/")
library(raster)

review funzioni:
raster con tanti livelli, es. immagine satellitare -> "brick"
singolo livello raster, es. mappa classificata -> "raster"

d1c <- raster("d1c.tif")
d2c <- raster("d2c.tif")

par(mfrow=c(1,2))
cl <- colorRampPalette(c('green','black'))(100) # 
plot(d1c, col=cl)
plot(d2c, col=cl)

1° CASO: FORESTA E AGRICOLTURA
par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c, col=cl)
plot(d2c, col=cl)
in questo modo la foresta è la classe n°2 (verde)

# forest: class 2; agriculture: class 1
d1c.for <- reclassify(d1c, cbind(1,NA))
d2c.for <- reclassify(d2c, cbind(1,NA))

funzione "cbind": serve per annullare alcuni valori
funzione "reclassify"
annulliamo l'agricultura (classe n°1) e riclassifichiamo solo la foresta

par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c, col=cl)
plot(d1c.for, col=cl)

2° CASO: SOLO FORESTA
par(mfrow=c(1,2))
plot(d1c)
plot(d2c)


funzione "clump": serve per aggregare le patches

# creating patches
install.packages("igraph")
require(igraph) # for patches

d1c.for.patches <- clump(d1c.for)
d2c.for.patches <- clump(d2c.for)

writeRaster(d1c.for.patches, "d1c.for.patches.tif")
writeRaster(d2c.for.patches, "d2c.for.patches.tif")

per importare dati in R -> "raster"
per esportare dati da R -> "writeRaster"

# d1c.for.patches <- raster("d1c.for.patches")
# d2c.for.patches <- raster("d2c.for.patches")

# Exercise: plottare entrambe le mappe una accanto all'altra 
par(mfrow=c(1,2))
plot(d1c.for.patches)
plot(d2c.for.patches)

clp <- colorRampPalette(c('dark blue','blue','green','orange','yellow','red'))(100) # 
par(mfrow=c(1,2))
plot(d1c.for.patches,col=clp)
plot(d2c.for.patches,col=clp)

# max patches d1c.for.patches = 301
# max patches d2c.for.patches = 1212

# plot results:
time <- c("Before deforestation","After deforestation")
npatches <- c(568,1920)

output <- data.frame(time,npatches)
attach(output)

library(ggplot2)
ggplot(output, aes(x=time, y=npatches, color="red")) + geom_bar(stat="identity", fill="white")


-----------------------------------------------------------------------------------------------------------------------

(Pratica del 22/04/20)
