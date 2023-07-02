
Function cvr {
    yarn create vite $args[0] --template react;
    cd $args[0];
    yarn;
}
Function cvt {
    yarn create vite $args[0] --template react-ts;
    cd $args[0];
    yarn;
}
Function cvtw {
    yarn create vite $args[0] --template react-ts;
    cd $args[0];
    yarn;
    # https://tailwindcss.com/docs/guides/vite
    $name = $args[0]
    yarn add -D tailwindcss postcss autoprefixer;
    npx tailwindcss init -p;
    Copy-Item -Path $assetsDir'\cvtw\tailwind.config.js' -Destination $localDir\$name\'tailwind.config.js'
    Copy-Item -Path $assetsDir'\cvtw\index.css' -Destination $localDir\$name\'src\index.css'
    Copy-Item -Path $assetsDir'\cvtw\App.tsx' -Destination $localDir\$name\'src\App.tsx'

    #(Get-Content ".\tailwind.config.js" | Out-String) -replace "content: \[]", "content:[`r`n    `"./index.html`",`r`n    `"./src/**/*.{vue,js,ts,jsx,tsx}`",`r`n  ]" | Out-File ".\tailwind.config.js";
    #"@tailwind base;@tailwind components;@tailwind utilities;"-replace ";", ";`r`n"|Out-File ".\src\index.css";
    #(Get-Content ".\src\App.tsx" | Out-String ) -replace "(?sm)return \(.*\)", "return (`r`n    <h1 className=`"text-3xl font-bold underline`">`r`n      Hello world!`r`n    </h1>`r`n  )" | Out-File ".\src\App.tsx";
}
