-- Utility functions for image creation and manipulation

local gfx <const> = playdate.graphics

pdlibs = pdlibs or {}
pdlibs.image = pdlibs.image or {}

function pdlibs.image.perlinPattern(w, h, tr, x, y)
    tr = tr or 0.5
    x = x or 0.5
    y = y or 0.5
    local img = gfx.image.new(w, h)
    gfx.pushContext(img)
    for row = 1, h do
        local noise = gfx.perlinArray(w, x, 1, y + row - 1, 0)
        for col = 1, w do
            if (noise[col] > tr) then
                gfx.drawPixel(col, row)
            end
        end
    end
    gfx.popContext()
    return img
end