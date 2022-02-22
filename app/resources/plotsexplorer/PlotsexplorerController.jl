module PlotsexplorerController

using Genie, Stipple, StippleUI, StipplePlotly
using Genie.Renderers.Html
using Plotsexplorer

function explorer()
    html(:plotsexplorer, "plotsexplorer.jl", model = Plotsexplorer.model_factory(), context = @__MODULE__)
end

end
