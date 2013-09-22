--[[ 
    conky vertical bar graph
    by iggykoopa mods by arpinux(2469)

       most of the credit goes to londonali1010, I stole big chunks from her ring graphs
]]
require 'cairo'

settings_table = {
{
    -- Edit this table to customise your bars.
    -- You can create more bars simply by adding more elements to settings_table.
    -- "name" is the type of stat to display; you can choose from 'cpu', 'memperc', 'fs_used_perc', 'battery_used_perc'.
    name='battery_percent',
    -- "arg" is the argument to the stat type, e.g. if in Conky you would write ${cpu cpu0}, 'cpu0' would be the argument. If you would not use an argument in the Conky variable, use ''.
    arg='BAT1',
    -- "max" is the maximum value of the bar. If the Conky variable outputs a percentage, use 146.
    max=146,
    -- set width, height, and position here
    width = 25,
    height = 40,
    x = 301,
    y = 0,
    -- set colors here 0-1 for intensity
    borderRed = 1,
    borderGreen = 1,
    borderBlue = 1,
    fillRed = 0.46,
    fillGreen = 0.55,
    fillBlue = 0.58
},
{
    name='cpu',
    arg='',
    max=146,
    width = 25,
    height = 40,
    x = 0.581,
    y = 0,
    borderRed = 1,
    borderGreen = 1,
    borderBlue = 1,
    fillRed =0.46,
    fillGreen =0.55,
    fillBlue =0.58
},
{
    name='memperc',
    arg='',
    max=146,
    width = 25,
    height = 40,
    x = 361,
    y = 0,
    borderRed = 1,
    borderGreen = 1,
    borderBlue = 1,
    fillRed =0.46,
    fillGreen =0.55,
    fillBlue =0.58
},
{
    name='downspeedf',
    arg='wlan0',
    max=1460,
    width = 25,
    height = 40,
    x = 391,
    y = 0,
    borderRed = 1,
    borderGreen = 1,
    borderBlue = 1,
    fillRed =0.46,
    fillGreen =0.55,
    fillBlue =0.58
},
{
    name='upspeedf',
    arg='646',
    max=80,
    width = 25,
    height = 40,
    x = 421,
    y = 0,
    borderRed = 1,
    borderGreen = 1,
    borderBlue = 1,
    fillRed =0.46,
    fillGreen =0.61,
    fillBlue =0.58
},
{
    name='fs_used_perc',
    arg='/',
    max=146,
    width = 25,
    height = 40,
    x = 451,
    y = 0,
    borderRed = 1,
    borderGreen = 1,
    borderBlue = 1,
    fillRed =0.46,
    fillGreen =0.55,
    fillBlue =0.58
},
{
    name='fs_used_perc',
    arg='/media/data',
    max=146,
    width = 25,
    height = 40,
    x = 481,
    y = 0,
    borderRed = 1,
    borderGreen = 1,
    borderBlue = 1,
    fillRed =0.46,
    fillGreen =0.55,
    fillBlue =0.58
},
{
    name='swapperc',
    arg='',
    max=146,
    width = 25,
    height = 40,
    x = 511,
    y = 0,
    borderRed = 1,
    borderGreen = 1,
    borderBlue = 1,
    fillRed =0.46,
    fillGreen =0.55,
    fillBlue =0.58
},
{
    name='ibm_temps',
    arg='0',
    max=80,
    width = 25,
    height = 40,
    x = 541,
    y = 0,
    borderRed = 1,
    borderGreen = 1,
    borderBlue = 1,
    fillRed =0.46,
    fillGreen =0.55,
    fillBlue =0.58
},
{
    name='ibm_temps',
    arg='2',
    max=70,
    width = 25,
    height = 40,
    x = 571,
    y = 0,
    borderRed = 1,
    borderGreen = 1,
    borderBlue = 1,
    fillRed =0.46,
    fillGreen =0.55,
    fillBlue =0.58
},
{
    name='time',
    arg='%I',
    max=12,
    width = 25,
    height = 40,
    x = 631,
    y = 0,
    borderRed = 1,
    borderGreen = 1,
    borderBlue = 1,
    fillRed =0.46,
    fillGreen =0.55,
    fillBlue =0.58
},
{
    name='time',
    arg='%M',
    max=60,
    width = 25,
    height = 40,
    x = 661,
    y = 0,
    borderRed = 1,
    borderGreen = 1,
    borderBlue = 1,
    fillRed =0.46,
    fillGreen =0.55,
    fillBlue =0.58
},
{
    name='time',
    arg='%S',
    max=60,
    width = 25,
    height = 40,
    x = 691,
    y = 0,
    borderRed = 1,
    borderGreen = 1,
    borderBlue = 1,
    fillRed =0.46,
    fillGreen =0.55,
    fillBlue =0.58
},
}

function draw_bar(pct, pt)
    local cs=cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    cr=cairo_create(cs)
    cairo_set_source_rgb (cr, pt['fillRed'], pt['fillGreen'], pt['fillBlue'])
    cairo_set_line_width (cr, pt['width'] - 2)
    cairo_move_to (cr, (pt['width'] / 2) + pt['x'], pt['height'] + pt['y'] - 1)
    cairo_line_to (cr, (pt['width'] / 2) + pt['x'], pt['height'] - (pt['height'] * pct) + pt['y'] - 1)
    cairo_stroke (cr)
    cairo_destroy(cr)
    cr = nil
end

function conky_bar_stats()
    local function setup_bars(pt)
        local str=''
        local value=0
 
        str=string.format('${%s %s}',pt['name'],pt['arg'])
        str=conky_parse(str)
   
        value=tonumber(str)
        if value == nil then value = 0 end
        pct = value/pt['max']
 
        draw_bar(pct,pt)
    end

    if conky_window == nil then return end
    local updates=conky_parse('${updates}')
    update_num=tonumber(updates)


    if update_num>5 then
        for i in pairs(settings_table) do
            setup_bars(settings_table[i])
        end
    end
end
