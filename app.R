library(shiny)
library(glue)

generate_story <- function(noun, verb, adjective, adverb) {
  glue(
    "
    Once upon a time, there was a {adjective} {noun} who loved to
    {verb} {adverb}. It was the funniest thing ever!
  "
  )
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
  # reactiveVal to store accumulated log
  log <- reactiveVal("")

  output$story <- renderText({
    story_text <- generate_story(input$noun1, input$verb, input$adjective, input$adverb)

    # create a log entry
    new_log <- glue(
      "[{Sys.time()}] Inputs: noun={input$noun1}, verb={input$verb}, adjective={input$adjective}, adverb={input$adverb}\n",
      "[{Sys.time()}] Generated Story: {story_text}\n\n"
    )

    # append the new log to previous log
    log(paste0(log(), new_log))

    story_text
  })

  output$log_output <- renderText({
    log()
  })
}

shinyApp(ui = ui, server = server)
