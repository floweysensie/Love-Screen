local screen = require("screen")
local stars = {}
local player = { x = 80, y = 72, targetX = 80, targetY = 72 }

function love.load()
    love.window.setMode(800, 600, {resizable = true, minwidth = 240, minheight = 135})
    screen.init(240, 135, {pixelPerfect = false})
    love.mouse.setVisible(false)

    font = love.graphics.newFont("PressStart2P-Regular.ttf", 16)
    font:setFilter('nearest', 'nearest')

    for i = 1, 60 do
        table.insert(stars, {
            x = math.random(0, 240),
            y = math.random(0, 135),
            s = math.random(1, 4) / 2,
            opacity = math.random(0.3, 1)
        })
    end
end

function math.clamp(low, n, high)
    return math.max(low, math.min(n, high))
end

function love.update(dt)
    for _, s in ipairs(stars) do
        s.y = s.y + s.s
        if s.y > 135 then s.y = 0 end
    end

    local mx, my = screen.getMousePos()
    mx = math.clamp(0, mx, screen.gameWidth)
    my = math.clamp(0, my, screen.gameHeight)

    player.targetX = mx
    player.targetY = my

    player.x = player.x + (player.targetX - player.x) * 0.3
    player.y = player.y + (player.targetY - player.y) * 0.3
end

function love.resize(w, h)
    screen.updateLayout()
end

function love.draw()
    love.graphics.clear(0.02, 0.02, 0.04)
    screen.start(0.02, 0.02, 0.07)
        love.graphics.setFont(font)

        for _, s in ipairs(stars) do
            love.graphics.setColor(1, 1, 1, s.opacity)
            love.graphics.setPointSize(2)
            love.graphics.points(s.x, s.y)
        end

        love.graphics.setColor(1, 0.8, 0.2)
        love.graphics.polygon("fill",
            player.x, player.y - 6,
            player.x - 5, player.y + 5,
            player.x + 5, player.y + 5
        )

        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", 0, 0, 240, 135)
        love.graphics.print("MODE: " .. (screen.pixelPerfect and "PIXEL PERFECT" or "SMOOTH"), 5, 5, 0, 0.75)
        love.graphics.print("SCALE: x" .. string.format("%.2f", screen.scale), 5, 18, 0, 0.75)
        
        love.graphics.setColor(1, 1, 1, 0.6)
        love.graphics.print("[SPACE] SWITCH", 5, 90, 0, 0.6)
        love.graphics.print("[F] FULLSCREEN", 5, 100, 0, 0.6)
        love.graphics.print("[ESC] EXIT", 5, 110, 0, 0.6)
        love.graphics.print("RESIZE THE WINDOW", 5, 120, 0, 0.6)
    screen.stop()
end

function love.keypressed(key)
    if key == "space" then
        screen.pixelPerfect = not screen.pixelPerfect
        screen.updateLayout()
    elseif key == "f" then
        screen.toggleFullscreen()
        screen.updateLayout()
    elseif key == "escape" then
        love.event.quit()
    end
end