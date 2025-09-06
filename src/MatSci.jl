
module MatSci
using Pkg
using Pluto

Base.@ccallable function julia_main()::Cint
    cd(joinpath(pwd(), "src"))
    try
        #=we may want to include all this in the exe if possible=#
        Pkg.activate(pwd())
        #=PlutoLinks, Plots, PlutoSliderServer, "Javis", "Animation",=#
        Pkg.add(["PlutoUI", "Kroki", "ShortCodes", "PlutoTeachingTools", "MarkdownLiteral", "InteractiveUtils", "Markdown"])
        print("finished preinstalling dependencies !>")
        Pkg.instantiate()
        Pluto.run(notebook = joinpath(pwd(), "whitepaper.jl"))
        return 0 # Return 0 for success
    catch
        Base.invokelatest(Base.display_error, Base.catch_backtrace())
        return 1 # Return 1 for error
    end
end
end # module