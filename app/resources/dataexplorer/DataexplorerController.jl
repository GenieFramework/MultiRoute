module DataexplorerController

using DataFrames
using Stipple
using StippleUI

import RDatasets: dataset

const data = DataFrames.insertcols!(dataset("datasets", "iris"))

@reactive mutable struct IrisModel <: ReactiveModel
    iris_data::R{DataTable} = DataTable(data)
    table_pagination::DataTablePagination = DataTablePagination(rows_per_page = 50)

end

function explorer()
    html(:dataexplorer, "dataexplorer.jl", model = init(IrisModel), context = @__MODULE__)
end

end
