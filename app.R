library(shiny)
library(glue)

generate_story <- function(noun, verb, adjective, adverb, log) {
  story <- glue(
    "
    Once upon a time, there was a {adjective} {noun} who loved to
    {verb} {adverb}. It was the funniest thing ever!
  "
  )
  
  # Create log entry
  log_entry <- glue("[{Sys.time()}] Inputs: noun={noun}, verb={verb}, adjective={adjective}, adverb={adverb}\n",
                    "[{Sys.time()}] Generated Story: {story}\n")
  
  # Append to log
  log(paste0(log(), log_entry))
  
  return(story)
}

ui <- fluidPage(
  titlePanel("Mad Libs Game with Logs"),
  sidebarLayout(
    sidebarPanel(
      textInput("noun1", "Enter a noun:", ""),
      textInput("verb", "Enter a verb:", ""),
      textInput("adjective", "Enter an adjective:", ""),
      textInput("adverb", "Enter an adverb:", "")
    ),
    mainPanel(
      h3("Your Mad Libs Story:"),
      textOutput("story"),
      hr(),
      h3("Logs:"),
      verbatimTextOutput("log_output")
    )
  )
)

server <- function(input, output) {
  # reactiveVal to store log
  log <- reactiveVal("")
  
  output$story <- renderText({
    generate_story(input$noun1, input$verb, input$adjective, input$adverb, log)
  })
  
  output$log_output <- renderText({
    log()
  })
}

shinyApp(ui = ui, server = server)
