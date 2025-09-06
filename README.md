Download this ```https://git-scm.com/downloads/win```
and install it in the typical fashion.

Then open a shell and paste:
    ```
    git clone https://github.com/smokytheangel0/MatSci
    cd MatSci
    ```
then paste:  
    ```  
    winget install -y Microsoft.VisualStudio.2022.BuildTools  
    ```  
Then hit enter and follow the instructions  
After it is complete and you can type in a straight line again, paste:  
    ```  
    winget install --name Julia --id 9NJNWW8PVKMN -e -s msstore  
    ```  
Then hit enter and follow the instructions  

After these steps are complete you should be able to type in:  
    ```  
    cd raw  
    ```  
then hit enter and next type:  
    ```  
    julia  
    ```  
and after hitting enter you should see this:  
```  
julia>  
```  
type:  
    ```  
    using Pluto  
    ```  
then hit enter  
finally type:  
    ```  
    Pluto.run()  
    ```  

A browser should pop up and you will be presented with a page with a text field somewhere to open your file from.
Clicking the textfield will yield a drop down menu from which you can select whitepaper.jl, then click open.

If you want to cache the packages this uses between restarts, there is a bit more for now
until we get an exe moving. You only have to do this once though.

after you get to:
        ```
        julia>
        ```
again from the raw directory,
paste these bits in:
```
using Pkg
Pkg.activate()
Pkg.add("PlutoUI")
Pkg.add("Kroki")
Pkg.add("ShortCodes")
Pkg.add("PlutoTeachingTools")
Pkg.add("MarkdownLiteral")
Pkg.add("InteractiveUtils")
Pkg.add("Markdown")
Pkg.instantiate()
import Pluto
Pluto.run(notebook = joinpath(pwd(), "whitepaper.jl"))
```
"PlutoLinks", "Plots", "PlutoSliderServer", 
        "Javis", "Animation" 
are also good.


Eventually we would like to support being able to just ```cargo run --release``` or use a build.rs file to run verus and copy the binary out to the root directory. This will bring us down to six commands for the same contributor startup speed, and exes that we can share with people who don't wish to use a terminal:
```
winget install -y Microsoft.VisualStudio.2022.BuildTools  
winget install --name Julia --id 9NJNWW8PVKMN -e -s msstore  
winget install -e --id Rustlang.Rustup
git clone https://github.com/smokytheangel0/MatSci
cd MatSci
cargo run --release
[browser opens with all deps cached]
```