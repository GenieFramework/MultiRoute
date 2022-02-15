module PlotsexplorerController
using DataFrames
using Genie, Stipple, StippleUI
using Genie.Renderers.Html
using Stipple
using StipplePlotly
using StippleUI

data = DataFrame(
    hcat([2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019], rand(10, 3)),
    ["year", "bipolar_disorder", "depression", "suicidality"],
)

pd(x, y, name) =
    PlotData(x = x, y = y, plot = StipplePlotly.Charts.PLOT_TYPE_SCATTER, name = name)

@reactive mutable struct Model <: ReactiveModel
    study_data::R{DataTable} = DataTable(data)
    table_pagination::DataTablePagination = DataTablePagination(rows_per_page = 3)

    plot_data::R{Vector{PlotData}} =
        [pd(data.year, data[!, col], col) for col in filter(x -> x != "year", names(data))]
    layout::R{PlotLayout} = PlotLayout(
        plot_bgcolor = "#333",
        title = PlotLayoutTitle(text = "Disease Prevalence versus Year", font = Font(24)),
    )
    config::R{PlotConfig} = PlotConfig()

    valone::R{Bool} = true
    valtwo::R{Bool} = true
    valthree::R{Bool} = true
    valfour::R{Bool} = true
    valfive::R{Bool} = true
    cols::R{Vector} = ["year", "bipolar_disorder", "depression", "suicidality"]

    data_loading::R{Bool} = false

end

function handler(model)
    on(model.valone) do val
        if val == true
            push!(model.cols.o.val, "bipolar_disorder")
        else
            deleteat!(
                model.cols.o.val,
                findall(x -> x == "bipolar_disorder", model.cols.o.val),
            )
        end
    end
    on(model.valtwo) do val
        if val == true
            push!(model.cols.o.val, "depression")
        else
            deleteat!(model.cols.o.val, findall(x -> x == "depression", model.cols.o.val))
        end
    end
    on(model.valthree) do val
        if val == true
            push!(model.cols.o.val, "suicidality")
        else
            deleteat!(model.cols.o.val, findall(x -> x == "suicidality", model.cols.o.val))
        end
    end
    model
end

function filterdata(model)
    model.data_loading[] = true
    model.study_data[] = DataTable(data[:, model.cols.o.val])
    model.plot_data[] = [
        pd(data.year, data[!, col], col) for
        col in filter(x -> x != "year", model.cols.o.val)
    ]
    model.data_loading[] = false
end

function ui(model::Model)

    onany(model.valone, model.valtwo, model.valthree) do (_...)
        filterdata(model)
    end

    page(
        model,
        class = "container",
        title = "Study Data Explorer",
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
            heading("Study Data Explorer and the Awesomeness of Genie")
            row(
                cell(
                    class = "container",
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
end

my_model = handler(init(Model()))

function explorer()
    html(:plotsexplorer, "explorer.jl", model = my_model, context = @__MODULE__)
end

end
