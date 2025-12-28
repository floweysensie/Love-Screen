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

## 🕹️ Live Demo
I've included a space-themed demo to showcase the scaling modes.
1. Download the `demo` folder.
2. Run it using LÖVE (Drag the folder onto the love executable).
3. Controls:
    * **[SPACE]**: Toggle between Pixel-Perfect and Smooth scaling.
    * **[F]**: Toggle Fullscreen.
    * **[Mouse]**: Control the ship.
    * and You can resize the window of the demo

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

2. Window Setup (conf.lua)
For the best experience, set your desired window size in `conf.lua`. Love-Res will automatically scale your game to fit this window.
```lua
function love.conf(t)
    t.window.width = 1280  -- Actual window width
    t.window.height = 720  -- Actual window height
    t.window.resizable = true -- Recommended
end
```
Then in your main.lua, initialize your internal game resolution (e.g., 320x180):
```lua
screen.init(320, 180)
```

3. Initialize the screen in `love.load`:
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

4. Wrap your drawing code between start and stop:
```lua
    function love.draw()
        screen.start(0.1, 0.1, 0.1) -- Optional: Clear color
            -- Draw anything that can be drawn (shapes, pictures, shadows, etc.)
            love.graphics.rectangle("fill", 50, 50, 32, 32)
        screen.stop()
    end
```

5. Handling Window Resizes
Crucial: To keep the game centered and scaled correctly when the window changes, you **must** call updateLayout in the resize callback:
```lua
    function love.resize(w, h)
        screen.updateLayout()
    end
```

6. Toggling Fullscreen
You can easily toggle fullscreen. The library handles the layout update automatically.
```lua
function love.keypressed(key)
    if key == "f11" then
        screen.toggleFullscreen()
    end
end
```

7. Input Handling (Mouse & Touch)
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
### Pro Tip: Handling Out-of-Bounds Input
Since `screen.getMousePos()` can return negative values or values larger than your game resolution (when the mouse is over the black bars), you might want to "clamp" these values to keep them within your game bounds.

Add this helper function to your code:
```lua
function math.clamp(low, n, high)
    return math.max(low, math.min(n, high))
end
```
Then use it with the library:
```lua
local gx, gy = screen.getMousePos()
gx = math.clamp(0, gx, screen.gameWidth)
gy = math.clamp(0, gy, screen.gameHeight)
```
Why? This ensures your game logic (like clicking a button at 0,0) doesn't break when the user clicks in the letterboxing area.

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
