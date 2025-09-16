library(shiny)
library(glue)

generate_story <- function(noun, verb, adjective, adverb) {
  story <- glue(
    "
    Once upon a time, there was a {adjective} {noun} who loved to
    {verb} {adverb}. It was the funniest thing ever!
  "
  )
  
  # Log the inputs and generated story
  cat("[LOG]", Sys.time(), "- Inputs:",
      "noun =", noun,
      ", verb =", verb,
      ", adjective =", adjective,
      ", adverb =", adverb, "\n")
  cat("[LOG]", Sys.time(), "- Generated Story:", story, "\n")
  
  return(story)
}

ui <- fluidPage(
  titlePanel("Mad Libs Game"),
  sidebarLayout(
    sidebarPanel(
      textInput("noun1", "Enter a noun:", ""),
      textInput("verb", "Enter a verb:", ""),
      textInput("adjective", "Enter an adjective:", ""),
      textInput("adverb", "Enter an adverb:", "")
    ),
    mainPanel(
      h3("Your Mad Libs Story:"),
      textOutput("story")
    )
  )
)

server <- function(input, output) {
  output$story <- renderText({
    generate_story(input$noun1, input$verb, input$adjective, input$adverb)
  })
}

shinyApp(ui = ui, server = server)
