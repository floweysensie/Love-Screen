# Love-Res

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
    -- Options:
    -- pixelPerfect: (true/false) Force integer scaling to avoid pixel distortion.
    -- filter: ("nearest" or "linear") "nearest" is recommended for pixel art.
    screen.init(320, 180, {
        pixelPerfect = true,
        filter = "nearest"
    })
end
```

3. Wrap your drawing code between start and stop:
```lua
    function love.draw()
        screen.start(0.1, 0.1, 0.1) -- Optional: Clear color
            -- Draw anything that can be drawn (shapes, pictures, shadows, etc.)
            love.graphics.rectangle("fill", 50, 50, 32, 32)
        screen.stop()
    end
```

4. Handling Window Resizes
Crucial: To keep the game centered and scaled correctly when the window changes, you **must** call updateLayout in the resize callback:
```lua
    function love.resize(w, h)
        screen.updateLayout()
    end
```

5. Input Handling (Mouse & Touch)
Standard love.mouse.getPosition() won't work correctly because of the scaling and offsets. Use the library helpers:
```lua
function love.update(dt)
    -- Get mapped mouse coordinates
    local gx, gy = screen.getMousePos()
    
    -- Note: gx/gy can be negative or larger than game width/height 
    -- if the mouse is in the "black bars" area.
end

function love.touchpressed(id, x, y)
    local tx, ty = screen.getTouchPos(id)
    -- Use tx, ty for gameplay logic
end
```

## API Reference
| Function | Description |
|----------|-------------|
| `screen.init(w, h, settings)` | Sets virtual resolution and scaling mode. |
| `screen.start(r, g, b)` |	Starts drawing to the canvas and clears it. |
| `screen.stop()` | Stops drawing and renders the canvas to the window. |
| `screen.updateLayout()` | Recalculates scaling and offsets (Call on resize). |
| `screen.toggleFullscreen()` | Toggles fullscreen and updates layout. |
| `screen.getMousePos()` | Returns `x, y` mapped to the virtual resolution. |
| `screen.getTouchPos(id)` | Returns `x, y` for a specific touch ID. |

## License

This module is free software; you can redistribute it and/or modify it under the terms of the MIT license.
