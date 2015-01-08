fluidPage(
titlePanel("Taylor-Russell Tables Graphical Demonstration"),
column(3,hr(),sliderInput('V',"Validity",0,.95,0,.05),
hr(),sliderInput('BR',"Base Rate",5,95,50,5),
hr(),sliderInput('SR',"Selection Ratio",5,95,50,5),hr()),
column(6,plotOutput('plot',height=350,width=325)
))
