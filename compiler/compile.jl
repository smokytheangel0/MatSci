using Pkg
Pkg.activate(pwd())
Pkg.add("PackageCompiler")
Pkg.instantiate()
using PackageCompiler
PackageCompiler.create_app(pwd(), joinpath(joinpath(pwd(), "compiler"), "output"), incremental=true, force=true)
if isfile(joinpath(pwd(), "MatSci")) 
    rm(joinpath(pwd(), "MatSci"))
end    
if isfile(joinpath(pwd(), "MatSci.exe"))
    rm(joinpath(pwd(), "MatSci.exe"))
end
if Sys.iswindows()
    symlink(joinpath(joinpath(joinpath(joinpath(pwd(), "compiler"), "output"), "bin"),"MatSci.exe"), joinpath(pwd(), "MatSci.exe"), dir_target=false)
else
    symlink(joinpath(joinpath(joinpath(joinpath(pwd(), "compiler"), "output"), "bin"),"MatSci"), joinpath(pwd(), "MatSci"), dir_target=false)
end
