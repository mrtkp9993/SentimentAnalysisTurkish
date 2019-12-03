library(shiny)
library(shinythemes)
library(text2vec)
library(dplyr)
library(DT)
library(caret)
library(xgboost)
library(text2vec)

load(file = "fit.rda")
load(file = "v_vectorizer.rda")

ui <- fluidPage(
    theme = shinytheme("united"),
    titlePanel("Türkçe Duygu Analizi"),
    hr(),
    sidebarLayout(
        sidebarPanel(
            textInput("inputText", "Cümleyi buraya giriniz"),
            actionButton("submit", "Gönder")
        ),

        mainPanel(
            br(),
            p(strong("Sonuç")),
            br(),
            verbatimTextOutput("sentiment"),
            br(),
            DT::dataTableOutput("result"),
            br()
        )
    )
)

server <- function(input, output) {
    observeEvent(input$submit, {
        sentence_tokens <- input$inputText %>% tolower %>% word_tokenizer
        it_test <- itoken(sentence_tokens)
        dtm_test <- create_dtm(it_test, v_vectorizer)
        res <- predict(fit, dtm_test, type="prob")
        names(res) <- c("Öfke", "İğrenme", "Korku", "Mutlu", "Hüzün", "Şaşırma")
        output$result <- DT::renderDataTable({
            t(res)
        },
        options = list(columns=list(list(title="Duygu"),
                                    list(title="Olasılıklar"))))
        output$sentiment <- renderPrint({
            paste0("Metnin duygu durumu: ", names(which.max(res)))
        })
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
