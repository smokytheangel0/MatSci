Open your shell and paste:  
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
        Pkg.activate()
        Pkg.add("PlutoUI")
        Pkg.add("Kroki")
        Pkg.add("ShortCodes")
        Pkg.add("PlutoTeachingTools")
        Pkg.add("MarkdownLiteral")
        Pkg.add("InteractiveUtils")
        Pkg.add("Markdown")
        Pkg.instantiate()
        Pluto.run(notebook = joinpath(pwd(), "whitepaper.jl"))
```
"PlutoLinks", "Plots", "PlutoSliderServer", 
        "Javis", "Animation" 

are also good