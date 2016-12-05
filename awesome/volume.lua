volume_widget = widget({ type = "textbox", name = "tb_volume",
                         align = "right" })

function update_volume(widget)
    local fd = io.popen("amixer -D pulse sget Master")
    local status = fd:read("*all")
    fd:close()

    local volume = tonumber(string.match(status, "(%d?%d?%d)%%"))
    if volume ~= "" then volume = volume/100 else volume = 0 end
    status = string.match(status, "%[o..?%]")

    -- starting colour
    local sr, sg, sb = 0x30, 0x30, 0x30
    -- ending colour
    local er, eg, eb = 0xFF, 0xFF, 0xFF

    local ir = math.floor(volume * (er - sr) + sr)
    local ig = math.floor(volume * (eg - sg) + sg)
    local ib = math.floor(volume * (eb - sb) + sb)
    interpol_colour = string.format("%.2x%.2x%.2x", ir, ig, ib)
    if string.find(status, "on", 1, true) then
        volume = " <span background='#" .. interpol_colour .. "'>   </span>"
    else
        volume = " <span color='red' background='#" .. interpol_colour .. "'> M </span>"
    end
    widget.text = volume
 end

update_volume(volume_widget)
awful.hooks.timer.register(.2, function () update_volume(volume_widget) end)
