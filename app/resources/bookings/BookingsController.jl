module BookingsController

using Genie, Stipple, StippleUI
using Genie.Renderers.Html
using Bookings

function booking()
  html(:bookings, "bookings.jl", model = Bookings.factory(), context = @__MODULE__)
end

end
