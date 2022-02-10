module Movies

using Stipple, StippleUI
using Genie.Requests

export Model

@reactive mutable struct Model <: ReactiveModel
  # filter UI
  status::R{Bool} = true
end

function factory()
  @info "Hello Factory Model"
  model = Model |> init
  model
end

end
