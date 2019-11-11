library(shiny)
library(shinydashboard) 
library(ggplot2)
devtools::install_github(repo = 'IBMDataScience/R4WML')
library(R4WML) 

library(zoo)


url <-"https://iam.bluemix.net/oidc/token"

data  <- "apikey=[enter-api-key]&grant_type=urn:ibm:params:oauth:grant-type:apikey"
IBM_cloud_IAM_uid <- "bx"
IBM_cloud_IAM_pwd <- "bx"

auth = httr::authenticate(IBM_cloud_IAM_uid, IBM_cloud_IAM_pwd) 
print(auth)

res<-httr::POST(url, body=data, auth )
print(res) 

json <- jsonlite::fromJSON(httr::content(res, as = 'text', type = 'application/json', encoding = 'UTF-8'))
print(json$access_token) 
iam_token <- json$access_token


ui <- dashboardPage(
  dashboardHeader(title = "Sales Forecast"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard"))
      
    )
  ),
  dashboardBody(
    
    sidebarLayout(
      sidebarPanel(
        
        selectInput("store", "Store number:",
                    list("1", "2"),selected = "1"
                    
        ),
        
        radioButtons("radio", label = h3("Select the clothing item"),
                     choices =  c("T-shirts" = 1,
                                  "Formal Shirts" = 2,
                                  "Jeans" = 3
                     ),selected = 1),
        
        
        # Copy the line below to make a date selector 
        dateInput("date", label = h5("Date"), value = "2018-01-01"),
        
        hr()
        
        
        
      ),
      
      mainPanel(
        
        plotOutput("lineChart")
      )   
    )      
  )
)

server <- function(input, output) {
  
  
  
  
  output$lineChart <- renderPlot({  
    ml_instance_id <- "enter-ml-id" 
    if (input$store == 1){
      if (input$radio == 1){
        payload1 <- paste0('{"fields":["date","store", "item","sales"],"values":[["',input$date, '",', input$store, ',', input$radio, ',' ,526, ']]}')
        print(payload1) 
        
        
        results<-httr::POST('enter-scoring-url', body = payload1, add_headers("Content-Type"="application/json", "Authorization" = paste0("Bearer", iam_token), "ML-Instance-ID" = ml_instance_id ))
        jsonResults <- jsonlite::fromJSON(httr::content(results, as = 'text', type = 'application/json', encoding = 'UTF-8'))
      }
      
      else if(input$radio == 2){
        payload1 <- paste0('{"fields":["date","store", "item","sales"],"values":[["',input$date, '",', input$store, ',', input$radio, ',' ,1297, ']]}')
        print(payload1)
       
        results<-httr::POST('enter-scoring-url', body = payload1, add_headers("Content-Type"="application/json", "Authorization" = paste0("Bearer", iam_token), "ML-Instance-ID" = ml_instance_id ))
        jsonResults <- jsonlite::fromJSON(httr::content(results, as = 'text', type = 'application/json', encoding = 'UTF-8'))
      }
      
      else if(input$radio == 3){
        payload1 <- paste0('{"fields":["date","store", "item","sales"],"values":[["',input$date, '",', input$store, ',', input$radio, ',' ,845, ']]}')
        print(payload1)

        results<-httr::POST('enter-scoring-url', body = payload1, add_headers("Content-Type"="application/json", "Authorization" = paste0("Bearer", iam_token), "ML-Instance-ID" = ml_instance_id ))
        jsonResults <- jsonlite::fromJSON(httr::content(results, as = 'text', type = 'application/json', encoding = 'UTF-8')) }
      
    }
    
    
    else if (input$store == 2){
      if (input$radio == 1){
        payload1 <- paste0('{"fields":["date","store", "item","sales"],"values":[["',input$date, '",', input$store, ',', input$radio, ',' ,526, ']]}')
        print(payload1) 
        
        
        results<-httr::POST('enter-scoring-url', body = payload1, add_headers("Content-Type"="application/json", "Authorization" = paste0("Bearer", iam_token), "ML-Instance-ID" = ml_instance_id ))
        jsonResults <- jsonlite::fromJSON(httr::content(results, as = 'text', type = 'application/json', encoding = 'UTF-8'))
      }
      
      else if(input$radio == 2){
        payload1 <- paste0('{"fields":["date","store", "item","sales"],"values":[["',input$date, '",', input$store, ',', input$radio, ',' ,1297, ']]}')
        print(payload1)
        
        results<-httr::POST('enter-scoring-url', body = payload1, add_headers("Content-Type"="application/json", "Authorization" = paste0("Bearer", iam_token), "ML-Instance-ID" = ml_instance_id ))
        jsonResults <- jsonlite::fromJSON(httr::content(results, as = 'text', type = 'application/json', encoding = 'UTF-8'))
      }
      
      else if(input$radio == 3){
        payload1 <- paste0('{"fields":["date","store", "item","sales"],"values":[["',input$date, '",', input$store, ',', input$radio, ',' ,845, ']]}')
        print(payload1)
        
        results<-httr::POST('enter-scoring-url', body = payload1, add_headers("Content-Type"="application/json", "Authorization" = paste0("Bearer", iam_token), "ML-Instance-ID" = ml_instance_id ))
        jsonResults <- jsonlite::fromJSON(httr::content(results, as = 'text', type = 'application/json', encoding = 'UTF-8')) }
      
    }
    
    
    
    print(jsonResults) 
    
    
    dataFrame <- jsonResults$values 
    
    print(dataFrame)
    
    df = as.data.frame(jsonResults$values)
    colnames(df) = jsonResults$fields 
    
    
    colnames(df)[6] <- "Sales"  
    
    temp <<- df 
    
    df[[1]] = as.POSIXct(df[[1]], format = "%Y-%m-%d %H:%M %p UTC", tz = "GMT")
    df = data.frame(lapply(df, function(x){
      if (class(x)[1] == "factor"){
        as.numeric(x)
      } else {
        x  
      }
    }))
    print(str(df))
    
    temp2 <<- df
    
    ggplot(df, aes(date, Sales)) +
      geom_line() +
      geom_point()  #optional
    
  },height = 650, width = 600)
  
}

shinyApp(ui = ui, server = server)