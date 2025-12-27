# Love-Screen

A lightweight, pixel-perfect screen scaling library for LÖVE (Love2D). It handles virtual resolution, letterboxing (black bars), and mouse coordinate mapping.

## Why use this?

The Problem: Modern screens have high resolutions, but pixel art games are made in low resolutions. Scaling them manually causes blurry pixels or incorrect mouse coordinates.
The Solution: This library automates the scaling process, keeping pixels crisp and mapping mouse inputs perfectly to your game world.

## Features

* Pixel Perfect: Uses integer scaling to keep the pixels crisp.
* Automatic Centering: Automatically calculates offsets (letterboxing) to center the game.
* Mouse Mapping: Includes a helper function to translate screen mouse coordinates to the game's virtual coordinates.
* Flexible Scaling: Choose between Integer Scaling (Pixel Perfect) or Smooth Scaling.
* Fullscreen Support: Easy toggle with layout recalculation.
* Mobile Ready: Full support for Touch input

## New in v1.1.0

* **Non-Pixel Perfect Mode:** Disable `pixelPerfect` if you want your game to fill as much screen space as possible without being restricted to whole numbers.
* **Fullscreen Toggle:** Easy switching with `screen.toggleFullscreen()`.
* **Mobile Support:** Added `screen.getTouchPos(id)` for touchscreen devices.
* **Better Performance:** Layout calculations are now centralized in `updateLayout()`.

## Usage

1. Place `screen.lua` in your project and require it
``` lua
  local screen = require("screen")
```

2. Initialize the screen in `love.load`:
```lua
function love.load()
    -- Simple init
    screen.init(320, 180)
    -- Advanced init (Default values shown)
    screen.init(320, 180, {
        pixelPerfect = true, -- Set to false for smooth/fractional scaling
        filter = "nearest"   -- Canvas filter ("nearest" or "linear")
    })
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

5. Handling Window Resizes
For best performance, call `screen.updateLayout()` inside the `love.resize` callback:
```lua
    function love.resize(w, h)
        screen.updateLayout()
    end
    
    function love.keypressed(key)
        if key == "f11" then
            screen.toggleFullscreen()
        end
    end
```

## License

This module is free software; you can redistribute it and/or modify it under the terms of the MIT license.
