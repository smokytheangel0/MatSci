use jlrs::prelude::*;
use std::env;
use std::error::Error;

//I did not write this
#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    // Initialize the Julia runtime in an async context
    let mut pending_julia = unsafe { PendingJulia::init(16)? };
    let mut julia = pending_julia.start_async::<Tokio>().await?;

    // Create a scope to interact with the Julia garbage collector safely
    let result = julia.async_scope(|mut frame| async move {
        println!("Setting up Julia environment...");

        // Get the Pkg module: `using Pkg`
        let pkg = Module::main(&frame).submodule(&frame, "Pkg")?.as_managed();

        // Activate the environment: `Pkg.activate()`
        let activate_fn = pkg.function(&frame, "activate")?;
        activate_fn.call0(&mut frame).await?;
        println!("✅ Activated project environment.");

        // Add required packages
        let add_fn = pkg.function(&frame, "add")?;
        let packages = [
            "PlutoUI", "Kroki", "ShortCodes", "PlutoTeachingTools",
            "MarkdownLiteral", "InteractiveUtils", "Markdown"
        ];

        for package in packages {
            let pkg_name = JuliaString::new(&mut frame, package);
            add_fn.call1(&mut frame, pkg_name.as_value()).await?;
            println!("  - Added {}", package);
        }
        println!("✅ All packages added.");

        // Instantiate the environment: `Pkg.instantiate()`
        let instantiate_fn = pkg.function(&frame, "instantiate")?;
        instantiate_fn.call0(&mut frame).await?;
        println!("✅ Instantiated project dependencies.");

        // Import Pluto: `import Pluto`
        Value::eval_string(&mut frame, "import Pluto").await?;
        let pluto = Module::main(&frame).submodule(&frame, "Pluto")?.as_managed();
        println!("✅ Imported Pluto.");

        // Construct the notebook path: `joinpath(pwd(), "whitepaper.jl")`
        let notebook_file = "whitepaper.jl";
        let current_dir = env::current_dir()?;
        let notebook_path = current_dir.join(notebook_file);
        let notebook_path_str = notebook_path.to_str().ok_or("Invalid notebook path")?;

        // Get the `run` function from the Pluto module
        let run_fn = pluto.function(&frame, "run")?;

        // Prepare the keyword argument `notebook = "..."`
        let path_val = JuliaString::new(&mut frame, notebook_path_str).as_value();
        let notebook_kw = Symbol::new(&frame, "notebook");
        let kwargs = [(notebook_kw.as_value(), path_val)];

        println!("\n🚀 Launching Pluto notebook: {}", notebook_path_str);
        println!("   Check your browser or console output for the URL (usually http://127.0.0.1:1234/).");

        // Call Pluto.run with the keyword argument. This call will block until the
        // Pluto server is shut down.
        run_fn.call_keywords(&mut frame, &mut [], &mut kwargs).await?;

        Ok(())
    }).await;

    // Handle any errors that occurred during execution
    if let Err(e) = result {
        eprintln!("\n❌ An error occurred: {}", e);
    }

    Ok(())
}
