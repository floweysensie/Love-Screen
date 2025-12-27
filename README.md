# Love-Screen

A lightweight, pixel-perfect screen scaling library for LÖVE (Love2D). It handles virtual resolution, letterboxing (black bars), and mouse coordinate mapping.

## Features

* Pixel Perfect: Uses integer scaling to keep the pixels crisp.
* Automatic Centering: Automatically calculates offsets (letterboxing) to center the game.
* Mouse Mapping: Includes a helper function to translate screen mouse coordinates to the game's virtual coordinates.

## Usage

1. Place `screen.lua` in your project and require it
``` lua
  local screen = require("screen")
```

2. Initialize the screen in `love.load`:
```lua
function love.load()
    -- Set virtual game resolution
    screen.init(320, 180)
end
```

3. Wrap your drawing code between start and stop:
```lua
    function love.draw()
        screen.start(0.1, 0.1, 0.1) -- R, G, B for background clear
            -- Draw game objects here
            love.graphics.rectangle("fill", 50, 50, 32, 32)
        screen.stop()
    end
```

4. Use getMousePos for accurate mouse input:
```lua
    function love.update(dt)
        local gx, gy = screen.getMousePos()
        -- gx and gy are now mapped to your resolution
    end
    
```

## License

This module is free software; you can redistribute it and/or modify it under the terms of the MIT license.
