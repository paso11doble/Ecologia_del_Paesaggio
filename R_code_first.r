# R CODE FIRST: PRIMO CODICE R ECOLOGIA DEL PAESAGGIO (18/03/20)

# prova

install.packages("sp")

library(sp)
# UN COMANDO ALTERNATIVO PER CARICARE LE LIBRERIE: require(sp)

data(meuse)
meuse

head(meuse)
names(meuse)

summary(meuse)

pairs(meuse)

pairs(~ cadmium + copper + lead, data = meuse)

# Exercise: add zinc to cadmium, copper and lead
pairs(~ cadmium + copper + lead + zinc, data = meuse)

# "freccia ↑": RIPRENDE L'ULTIMO COMANDO USATO

# "parentesi [...]": SERVONO PER FARE UN SUBSET
pairs(meuse[,3:6])

pairs(meuse[,3:6], col="green")
# PER CAMBIARE COLORE

pairs(meuse[,3:6], col="green", pch=19) 
# PER SELEZIONARE IL "POINT SHAPE" (O POINT CHARACTER)

pairs(meuse[,3:6], col="green", pch=19, cex=3) 
# PER AUMENTARE LE DIMENSIONI DEI PUNTI (cex=character exageration)

pairs(meuse[,3:6], col="green", pch=19, cex=3, main="Primo pairs") 
# PER DARE UN TITOLO 

# Exercise: add "elevation" character to the previous
pairs(meuse[,3:7], col="green", pch=19, cex=3, main="Primo pairs")

--------------------------------------------------------------------------------------------------

# panels from outside


panel.correlations <- function(x, y, digits=1, prefix="", cex.cor)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r1=cor(x,y,use="pairwise.complete.obs")
    r <- abs(cor(x, y,use="pairwise.complete.obs"))

 

    txt <- format(c(r1, 0.123456789), digits=digits)[1]
    txt <- paste(prefix, txt, sep="")
    if(missing(cex.cor)) cex <- 0.9/strwidth(txt)
    text(0.5, 0.5, txt, cex = cex * r)
}

 

panel.smoothing <- function (x, y, col = par("col"), bg = NA, pch = par("pch"),
    cex = 1, col.smooth = "red", span = 2/3, iter = 3, ...)
{
    points(x, y, pch = pch, col = col, bg = bg, cex = cex)
    ok <- is.finite(x) & is.finite(y)
    if (any(ok))
        lines(stats::lowess(x[ok], y[ok], f = span, iter = iter),
            col = 1, ...)
}

 

panel.histograms <- function(x, ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(usr[1:2], 0, 1.5) )
    h <- hist(x, plot = FALSE)
    breaks <- h$breaks; nB <- length(breaks)
    y <- h$counts; y <- y/max(y)
    rect(breaks[-nB], 0, breaks[-1], y, col=white", ...)
}

--------------------------------------------------------------------------------------------------

pairs(meuse[,3:6], lower.panel = panel.correlations, upper.panel = panel.smoothing, diag.panel = panel.istograms)

# Exercise: mettere come lower lo smoothing, come upper le correlations, come diagonal gli istogrammi
pairs(meuse[,3:6], lower.panel = panel.smoothing, upper.panel = panel.correlations, diag.panel = panel.istograms)


# funzione plot

plot(meuse$cadmium, meuse$copper)
# "dollaro $": SERVE PER COLLEGARE PIU' VARIABILI/LAYER AL DATASET

attach(meuse)
plot(cadmium, copper)
plot(cadmium, copper, pch=17, col="green", main="primo plot", xlab="cadmio", ylab="rame")
