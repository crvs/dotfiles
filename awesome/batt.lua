-- Create a battery widget
battery_widget = awful.widget.progressbar()
battery_widget:set_width(8)
battery_widget:set_height(19)
battery_widget:set_vertical(true)
battery_widget:set_background_color("#494B4F")
battery_widget:set_border_color(nil)
battery_widget:set_color("#FFFFFF")

function hasbatt()
    local fd = io.popen("upower -e")
    local batt_path = fd:read("*all")
    fd:close()
    local hasbatt_v = true
    if batt_path == "" then
        hasbatt_v = false
    end
    return hasbatt_v
end

function ischarging()
    local status = false
    if hasbatt() then
        local fd = io.popen("upower -i `upower -e`")
        status = fd:read("*all")
        fd:close()

        status = string.match(status , "state: +(%a+)")
        if status == "charging" then
            status = true
        end
    end
    return status
end

function update_battery(widget)
    local percentage = ""
    if hasbatt() then
        local fd = io.popen("upower -i `upower -e`")
        local status = fd:read("*all")
        fd:close()
        percentage = tonumber(string.match(status , "percentage: +(%d?%d?%d)%%")) / 100
        if ischarging() then
            widget:set_color("#8FBF8F")
        else
            widget:set_color("#FFFFFF")
        end
        widget:set_value(percentage)
    end
end

update_battery(battery_widget)
awful.hooks.timer.register(30, function () update_battery(battery_widget) end)
