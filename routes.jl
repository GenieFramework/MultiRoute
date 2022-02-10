using Genie.Router
using BookingsController
using MoviesController

route("/") do
  serve_static_file("welcome.html")
end

route("/booking", BookingsController.booking)
route("/movies", MoviesController.movies)

# route("/", DashboardController.dashboard)