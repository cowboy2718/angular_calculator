# Angular Seperation Calculator
# Developed by Tony Gojanovic
# May 25, 2020
# The following shiny program determines the angular seperation between two astronomical objects given their Right Ascension
# and Declination coordinates.  The input in taken as Hours Minutes and Seconds for right ascension and Degrees Minutes and Seconds 
# declination.  The program converts astronomical coordinates to decimal equivalent, determines the distance, and converts
# the seperation back to degrees.

library(shiny)
ui <- fluidPage(
  titlePanel("Angular Seperation Calculator for Astronomical Objects"),
  sidebarLayout(
    sidebarPanel(
      splitLayout(
        numericInput(inputId = "ra1_hrs", label = "Object 1 hrs", value = 0,min=0,max=24,step=1),
        numericInput(inputId = "ra1_min", label = "min", value = 42,min=0,max=60,step = 1),
        numericInput(inputId = "ra1_sec", label = "sec", value = 44.3, min=0,max=60, step =1)
      ),  
      splitLayout(  
        numericInput(inputId = "dec1_deg", label = "Object 1 deg", value = 41,min=0,max=24,step=1),
        numericInput(inputId = "dec1_min", label = "arcmin", value = 16,min=0,max=60,step = 1),
        numericInput(inputId = "dec1_sec", label = "arcsec ", value = 9, min=0,max=60, step =1)
      ),
      splitLayout(
        numericInput(inputId = "ra2_hrs", label = "Object 2 hrs", value = 1,min=0,max=24,step=1),
        numericInput(inputId = "ra2_min", label = "min", value = 33,min=0,max=60,step = 1),
        numericInput(inputId = "ra2_sec", label = "sec", value = 50.02, min=0,max=60, step =1)
      ),      
      splitLayout(
        numericInput(inputId = "dec2_deg", label = "Object 2 deg", value = 30,min=0,max=24,step=1),
        numericInput(inputId = "dec2_min", label = "arcmin", value = 39,min=0,max=60,step = 1),
        numericInput(inputId = "dec2_sec", label = "arcsec", value = 36.7, min=0,max=60, step =1)
      ),          
      submitButton('Calculate')
    ),
    mainPanel(withMathJax(),
              # Output summary
              h3("Instructions"),
              p("Input the Right Ascension (RA) and Declination (DEC) for Object 1 and Object 2.  Press Calculate and the angular seperation in degrees will be displayed."),
              p(""),
              h3("Example"),
              p(""),
              p("What is the angular seperation between M31 (Andromeda) and M33 (Triangulum) galaxies?"),
              p(""),
              h4("Solution:"),
              p(""),
              strong("For Andromeda, the coordinates are RA 0 hours 42 min 44.3 sec and DEC +41 degrees 16 arcmin and 9 arcsec:"),
              p(""),
              p("Object 1 hrs = 0, min = 42, sec = 44.3"),
              p("Object 1 deg = 41, arcmin = 16, arcsec = 9"),
              p(""),
              strong("For Triangulum, the coordinates are RA 1 hours 33 min 50.02 sec and DEC +30 degrees 39 arcmin and 36.7 arcsec:"),
              p(""),
              p("Object 2 hrs = 1, min = 33, sec = 50.02"),
              p("Object 2 deg = 30, arcmin = 39, arcsec = 36.7"),
              p(""),
              p("The estimated angular seperation in degrees is 14.78174"),
              
              h3("The estimated angular seperation in degrees is:"),
              verbatimTextOutput("dist",placeholder = TRUE),
#              h4("Algorithm Notes:"),
#              p("The algorithm used in this application is called the haversine formula, which is good at avoiding floating point errors when the two points are close together, specifically,"),
#              p("$$d=2\\arcsin\\sqrt{\\sin^2\\frac{\\vert\\delta_1-\\delta_2\\vert}{2}+{\\cos\\delta_1\\cos\\delta_2}\\sin^2\\frac{\\vert\\alpha_1-\\alpha_2\\vert}{2}}$$"),
#              p("In which $$\\alpha_1,\\delta_1$$ and $$\\alpha_2,\\delta_2$$"),
#              p("are the Right Ascension and Declination coordinates of Object 1 and Object 2, respectively."),
              tags$a(href="https://github.com/cowboy2718/angular_calculator", "Click here for more information on the calculator including code on github")
             
    )
  )
)

# The following function takes user input to calculate the distance between astronomical objects.
angular_dist<-function(ra1_hrs,ra1_min,ra1_sec,dec1_deg,dec1_min,dec1_sec,ra2_hrs,ra2_min,ra2_sec,dec2_deg,dec2_min,dec2_sec){
  
  #Convert RA from hms to decimal equivalent for object 1.
  ra1 <- function(ra1_hrs,ra1_min,ra1_sec) {
    return(15*(ra1_hrs+ ra1_min/60 + ra1_sec/(60*60)))
  }  
  #Convert Declination from dms to decimal equivalent for object 1.
  dec1<- function(dec1_deg,dec1_min,dec1_sec) {
    angle <- abs(dec1_deg) + dec1_min/60 + dec1_sec/(60*60)
    if(dec1_deg >= 0){
      angle<-angle
    } else {
      angle<-(-1)*angle
    }
    return(angle)
  } 
  #Convert RA from hms to decimal equivalent for object 2.
  ra2<- function(ra2_hrs,ra2_min,ra2_sec) {
    return(15*(ra2_hrs+ ra2_min/60 + ra2_sec/(60*60)))
  }  
  #Convert Declination from dms to decimal equivalent for object 2.
  dec2<- function(dec2_deg,dec1_min,dec1_sec) {
    angle <- abs(dec2_deg) + dec1_min/60 + dec1_sec/(60*60)
    if(dec2_deg >= 0){
      angle<-angle
    } else {
      angle<-(-1)*angle
    }
    return(angle)
  }   
  #Convert to radians
    ra_1<-ra1(ra1_hrs,ra1_min,ra1_sec)*(pi/180)
    dec_1<-dec1(dec1_deg,dec1_min,dec1_sec)*(pi/180)
    ra_2<-ra2(ra2_hrs,ra2_min,ra2_sec)*(pi/180)
    dec_2<-dec2(dec2_deg,dec2_min,dec2_sec)*(pi/180)
  #Determine distance based on the haversine formula
    a<-sin(abs(dec_1 - dec_2)/2)**2
    b<-cos(dec_1)*cos(dec_2)*sin(abs(ra_1 - ra_2)/2)**2
    distance<-2*asin(sqrt(a + b))
  #Convert back to degrees
   distance<-distance*(180/pi)
  return (distance)
}

server <- function(input, output) {
 output$dist<-renderPrint({angular_dist(input$ra1_hrs,input$ra1_min,input$ra1_sec,input$dec1_deg,input$dec1_min,input$dec1_sec,input$ra2_hrs,input$ra2_min,input$ra2_sec,input$dec2_deg,input$dec2_min,input$dec2_sec)}) 
}
shinyApp(ui, server)

# Reference for shiny layout
# https://stackoverflow.com/questions/50690544/grouping-textinput-box-in-shiny