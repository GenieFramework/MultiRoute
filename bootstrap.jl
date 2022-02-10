(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using MultiRoute
push!(Base.modules_warned_for, Base.PkgId(MultiRoute))
MultiRoute.main()
