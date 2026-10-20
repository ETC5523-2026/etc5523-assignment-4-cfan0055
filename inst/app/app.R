library(shiny)
library(bslib)
library(dplyr)
library(haiburden)

ui <- page_sidebar(
  title = "Which hospital infection does the most harm?",
  fillable = FALSE,
  theme = bs_theme(preset = "shiny", primary = "#0B4F6C", bg = "#F5F0E6", fg = "#1F2933"),
  includeCSS("www/styles.css"),
  sidebar = sidebar(
    radioButtons(
      "measure",
      "What do you want to count?",
      choices = c(
        "Number of infections" = "Infections",
        "Number of deaths" = "Deaths",
        "Healthy years lost (DALYs)" = "DALYs"
      ),
      selected = "Infections"
    ),
    checkboxGroupInput(
      "surveys",
      "Which survey samples?",
      choices = unique(hai_burden$survey),
      selected = c("Germany (national sample)", "EU/EEA average")
    ),
    checkboxInput("show_interval", "Show 95% uncertainty intervals", value = FALSE),
    p(class = "tip", "Start with the number of infections. Then switch to healthy years lost and watch the bloodstream infection bar.")
  ),
  card(
    card_header("Who this app is for"),
    p("This app is for hospital infection control managers. They decide which infections get prevention money first."),
    p(strong("The question. "), "Is the most common hospital infection also the infection that does the most harm?")
  ),
  card(
    card_header(textOutput("plot_title")),
    plotOutput("burden_plot", height = "450px"),
    card_footer(textOutput("top_text"))
  ),
  card(
    card_header("How to read this chart"),
    p("Each bar is one infection in one survey sample. A longer bar means a larger burden. The infection at the top has the largest burden for the measure you chose."),
    p("Compare the order of the bars across the three measures. Urinary tract infection is the most common infection. Bloodstream infection is rare, but it moves near the top when you count deaths or healthy years lost. A common infection is not always the most harmful one."),
    p("The black lines show the 95% uncertainty interval. Two bars with overlapping lines may not be truly different.")
  ),
  card(
    card_header("Healthy years lost for every 100 infections"),
    p("This table divides healthy years lost by the number of infections. A larger number means that one infection is more harmful."),
    tableOutput("harm_table")
  ),
  card(
    card_header("What the fields mean"),
    tags$ul(
      tags$li(strong("Number of infections. "), "New infections caught in hospital each year for every 100,000 people."),
      tags$li(strong("Number of deaths. "), "Deaths caused by the infection each year for every 100,000 people."),
      tags$li(strong("Healthy years lost (DALYs). "), "Years lost to early death plus years lived in poor health, for every 100,000 people."),
      tags$li(strong("Germany (national sample). "), "The main German estimate from 46 hospitals."),
      tags$li(strong("Germany (convenience sample). "), "A second German estimate from 132 hospitals that chose to take part."),
      tags$li(strong("EU/EEA average. "), "The European estimate from 29 countries.")
    ),
    card_footer(markdown("Data from Table 2 of [Zacher et al. (2019)](https://doi.org/10.2807/1560-7917.ES.2019.24.46.1900135). Surveys ran in 2011 and 2012."))
  )
)

server <- function(input, output, session) {
  selected_data <- reactive({
    validate(need(length(input$surveys) > 0, "Choose at least one survey sample to see the results."))
    hai_burden |>
      filter(survey %in% input$surveys)
  }, label = "selected_data")

  output$plot_title <- renderText({
    paste(input$measure, "per 100,000 people each year")
  })

  output$burden_plot <- renderPlot({
    plot_burden(selected_data(), burden_measure = input$measure, show_interval = input$show_interval)
  }, res = 96)

  output$top_text <- renderText({
    top <- selected_data() |>
      filter(measure == input$measure) |>
      slice_max(estimate, n = 1)
    paste("The largest bar is", top$infection, "in the", top$survey, "with", top$estimate, "per 100,000 people.")
  })

  output$harm_table <- renderTable({
    harm_per_infection(selected_data()) |>
      rename(
        "Survey sample" = survey,
        "Infection" = infection,
        "Infections per 100,000" = Infections,
        "DALYs per 100,000" = DALYs,
        "Healthy years lost per 100 infections" = dalys_per_100
      )
  }, digits = 1)
}

shinyApp(ui, server)