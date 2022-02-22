page(
    model,
    class = "container-fluid",
    title = "Iris Flowers Clustering",
    head_content = Genie.Assets.favicon_support(),
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
        heading("Iris data k-means clustering")
        row([
            cell(
                class = "st-module",
                [
                    h5("Iris data")
                    table(
                        :iris_data;
                        pagination = :table_pagination,
                        dense = true,
                        flat = true,
                        style = "height: 350px;",
                    )
                ],
            ),
        ])
    ],
)
