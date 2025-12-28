local screen = {
    _VERSION     = 'v1.1.4',
    _DESCRIPTION = ' pixel-perfect screen for LÖVE ',
    _URL         = 'https://github.com/floweysensie/Love-Res',
    _LICENSE     = [[
        MIT License

        Copyright (c) 2025 FloweySensie

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in all
        copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
    ]]
}

function screen.init(w, h, settings)
    screen.gameWidth = w
    screen.gameHeight = h

    settings = settings or {}
    screen.filter = settings.filter or "nearest"
    screen.pixelPerfect = (settings.pixelPerfect == true)

    love.graphics.setDefaultFilter(screen.filter, screen.filter)
    screen.canvas = love.graphics.newCanvas(screen.gameWidth, screen.gameHeight)
    screen.canvas:setFilter(screen.filter, screen.filter)

    screen.scale = 1
    screen.ox = 0
    screen.oy = 0
    screen.updateLayout()
end

function screen.updateLayout()
    local sw, sh = love.graphics.getDimensions()
    local scaleW = sw / screen.gameWidth
    local scaleH = sh / screen.gameHeight
    if screen.pixelPerfect then
        screen.scale = math.max(1, math.floor(math.min(scaleW, scaleH)))
    else
        screen.scale = math.max(1, math.min(sw / screen.gameWidth, sh / screen.gameHeight))
    end
    screen.ox = (sw - screen.gameWidth * screen.scale) / 2
    screen.oy = (sh - screen.gameHeight * screen.scale) / 2
end

function screen.toggleFullscreen()
    local isFull = love.window.getFullscreen()
    love.window.setFullscreen(not isFull)
    screen.updateLayout()
end

function screen.start(r, g, b)
    love.graphics.setCanvas(screen.canvas)
    love.graphics.clear(r, g, b)
end

function screen.stop()
    love.graphics.setCanvas()
    love.graphics.draw(screen.canvas,
        math.floor(screen.ox), math.floor(screen.oy),
        0,
        screen.scale, screen.scale)
end

function screen.getMousePos()
    local mx, my = love.mouse.getPosition()
    local gx = (mx - screen.ox) / screen.scale
    local gy = (my - screen.oy) / screen.scale
    return gx, gy
end

function screen.getTouchPos(id)
    local tx, ty = love.touch.getPosition(id)
    local gx = (tx - screen.ox) / screen.scale
    local gy = (ty - screen.oy) / screen.scale
    return gx, gy
end

return screen