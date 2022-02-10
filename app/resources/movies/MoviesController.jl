module MoviesController
using Genie, Stipple, StippleUI
using Genie.Renderers.Html
using Movies

function movies()
  html(:movies, "movies.jl", model = Movies.factory(), context = @__MODULE__)
end

end
