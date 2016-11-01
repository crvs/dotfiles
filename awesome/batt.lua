function update_battery(widget)
    local percentage = ""
    if hasbatt() then
        local fd = io.popen("upower -i `upower -e`")
        local status = fd:read("*all")
        fd:close()
        percentage = tonumber(string.match(status , "percentage:[ 	]*(%d?%d?%d)%%")) / 100
        if ischarging() then
            widget:set_color("#3F3F3F")
        else
            widget:set_color("#FFFFFF")
        end
        widget:set_value(percentage)
    end
end

function ischarging()
    local status = false
    if hasbatt() then
        local fd = io.popen("upower -i `upower -e`")
        local status = fd:read("*all")
        fd:close()

        status = string.match(status , "state:[ 	]*(%a+)")
        if status == "charging" then
            status = true
        else
            status = false
        end
    end
    return status
end

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

