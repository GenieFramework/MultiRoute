using Genie.Router
using DataexplorerController
using PlotsexplorerController

route("/", DataexplorerController.explorer)
route("/plotsexplorer", PlotsexplorerController.explorer)
