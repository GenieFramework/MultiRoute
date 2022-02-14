module DataexplorerController

using DataFrames
using Genie, Stipple, StippleUI
using Genie.Renderers.Html

import RDatasets: dataset

data = DataFrames.insertcols!(dataset("datasets", "iris"))

@reactive mutable struct IrisModel <: ReactiveModel
    iris_data::R{DataTable} = DataTable(data)
    table_pagination::DataTablePagination = DataTablePagination(rows_per_page = 50)

end

function ui(model::IrisModel)
    page(
        model,
        class = "container",
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
end

my_model = init(IrisModel)

function explorer()
    html(:dataexplorer, "explorer.jl", model = my_model, context = @__MODULE__)
end

end
