using Genie.Router
using DataexplorerController
using PlotsexplorerController

route("/") do
  serve_static_file("welcome.html")
end

route("/dataexplorer", DataexplorerController.explorer)
route("/plotsexplorer", PlotsexplorerController.explorer)
