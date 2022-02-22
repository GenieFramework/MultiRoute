Html.div([
  page(
    model,
    class = "container-fluid",
    title = "Study Data Explorer",
    #head_content = Genie.Assets.favicon_support(),
    prepend = style("""
                    tr:nth-child(even) {
                      background: #F8F8F8 !important;
                    }

                    .st-module {
                      background-color: #FFF;
                      border-radius: 2px;
                      box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.04);
                    }

                    .stipple-core .st-module > h5,
                    .stipple-core .st-module > h6 {
                      border-bottom: 0px !important;
                    }
                    """),
    [
        heading("Study Data Explorer and the Awesomeness of Genie")
        row(
            cell(
                class = "container-fluid",
                [plot(:plot_data, layout = :layout, config = :config)],
            ),
        )
        row([
            cell(
                class = "st-module",
                [
                    h5("Disease Prevalence Data")
                    table(
                        :study_data;
                        pagination = :table_pagination,
                        dense = true,
                        flat = true,
                        style = "height: 200px;",
                        loading = :data_loading,
                    )
                ],
            ),
        ],)
        row(
            cell(
                class = "st-module",
                [
                    checkbox(label = "bipolar_disorder", fieldname = :valone),
                    checkbox(label = "depression", fieldname = :valtwo),
                    checkbox(label = "suicidality", fieldname = :valthree),
                ],
            ),
        )
        row(
            cell(
                class = "st-module",
                [
                    checkbox(label = "source_1", fieldname = :valfour),
                    checkbox(label = "source_2", fieldname = :valfive),
                ],
            ),
        )
    ],
  )
])