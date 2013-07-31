--[[                                     ]]--
--                                         -
--    Steamburn Awesome WM 3.5.+ config    --
--        github.com/copycat-killer        --
--                                          -
--[[                                     ]]--


-- Required Libraries

gears 	        = require("gears")
awful           = require("awful")
awful.rules     = require("awful.rules")
awful.autofocus = require("awful.autofocus")
wibox           = require("wibox")
beautiful       = require("beautiful")
naughty         = require("naughty")
vicious         = require("vicious")
scratch         = require("scratch")

-- layouts
layouts         = require("layouts")


-- Run once function

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
 end

run_once("compton --backend glx --paint-on-overlay --glx-no-stencil --vsync opengl-swc --unredir-if-possible --config ~/.compton.conf -b")
run_once("nm-applet")
run_once("/opt/dropbox/dropboxd")
run_once("mpd")
run_once("unclutter -idle 10")


-- Localization

-- os.setlocale("en_AU.UTF-8")


-- Error Handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end


-- Variable Definitions

home = os.getenv("HOME")
confdir = home .. "/.config/awesome"
scriptdir = confdir .. "/script/"
themes = confdir .. "/themes"
active_theme = themes .. "/blackburn"

beautiful.init(active_theme .. "/theme.lua")

terminal = "urxvt"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor
gui_editor = "sublime_text"
browser = "dwb"
browser2 = "dwb"
mail = terminal .. " -g 130x30 -e mutt "
chat = terminal .. " -g 130x30 -e centerim5 "
tasks = terminal .. " -e htop "
-- wifi = terminal .. " -e sudo wifi-menu "
-- musicplr = terminal .. " -g 130x34-320+16 -e ncmpcpp "

modkey = "Mod4"
altkey = "Mod1"

-- layouts =
-- {
--    awful.layout.suit.floating,             -- 1
--    awful.layout.suit.tile,                 -- 2
--    awful.layout.suit.tile.left,            -- 3
--    awful.layout.suit.tile.bottom,          -- 4
--    awful.layout.suit.tile.top,             -- 5
--    awful.layout.suit.fair,                 -- 6
--    awful.layout.suit.fair.horizontal,      -- 7
--    awful.layout.suit.spiral,               -- 8
--    awful.layout.suit.spiral.dwindle,       -- 9
--    awful.layout.suit.max,                  -- 10
    --awful.layout.suit.max.fullscreen,     -- 11
    --awful.layout.suit.magnifier           -- 12
-- }

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    --awful.layout.suit.tile,
    layouts.uselesstile,
    layouts.termfair,
    layouts.browse,
    layouts.uselessfair,
    layouts.centerwork,
--    awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
--    awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
--    awful.layout.suit.fair.horizontal,
--    awful.layout.suit.spiral,
--    awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max
--    awful.layout.suit.max.fullscreen,
--    awful.layout.suit.magnifier
}
-- }}}


-- Wallpaper

if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

-- Tags

tags = {
       names = { " 1 ", " 2 ", " 3 ", " 4 ", " 5 "},
       layout = { layouts[1], layouts[3], layouts[5], layouts[5], layouts[5] }
       }
for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, tags.layout)
end

-- Menu
myaccessories = {
   { "7zFM", "7zFM" },
   { "spacefm", "spacefm" },
   { "ranger", terminal .. " -g 130x30 -e ranger"},
   { "editor", gui_editor }
   
}
myinternet = {
    { "dwb", browser },
    { "centerim" , chat },
    { "mutt", mail},
    { "transmission" , terminal .. " -g 130x30 -e transmission-remote-cli -c xenogia:dot.dot.dot@localhost:9091" },
    { "turses", terminal .. " -g 130x30 -e turses" },
    { "weechat", terminal .. " -g 130x30 -e weechat-curses" },
    { "headphones", "dwb -n http://localhost:8181" },
    { "sabnzbd" , "dwb -n http://localhost:9090" },
    { "sickbeard", "dwb -n http://localhost:8081" },
    { "couchpotato", "dwb -n http://localhost:5050"}
}
mymedia = {
    { "volume", "pavucontrol"},
    { "smplayer", "smplayer"},
    { "vlc", terminal .. " -e vlc -I ncurses" },
    { "ncmpcpp", terminal .. " -g 130x30 -e ncmpcpp"},
    { "cdw", terminal .. " -g 130x30 -e cdw"},
    { "devede", "devede"},
    { "ghb" , "ghb"}
}
mygames = {
    { "playonlinux", "playonlinux"},
    { "dosbox" , "dosbox"},
    { "desura", "desura"},
    { "steam", "steam" },
    
}
mygraphics = {
    { "gimp" , "gimp" },
    { "inkscape", "inkscape" },
    { "feh" , "feh" }
}
myoffice = {
    { "libreoffice" , "libreoffice" }
    
}
mysystem = {
    { "lxappearance" , "lxappearance" },
    { "bleachbit" , "bleachbit" },
    { "gparted" , "sudo gparted"},
    { "htop" , tasks }
}
mymainmenu = awful.menu({ items = {
				    { "accessories" , myaccessories },
				    { "graphics" , mygraphics },
				    { "internet" , myinternet },
            { "media" , mymedia },
				    { "games" , mygames },
				    { "office" , myoffice },
				    { "system" , mysystem },
            }
            })
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Colours
coldef  = "</span>"
colwhi  = "<span color='#b2b2b2'>"
colbwhi = "<span color='#ffffff'>"
blue = "<span color='#7493d2'>"
yellow = "<span color='#e0da37'>"
purple = "<span color='#e33a6e'>"
lightpurple = "<span color='#eca4c4'>"
azure = "<span color='#80d9d8'>"
green = "<span color='#87af5f'>"
lightgreen = "<span color='#62b786'>"
red = "<span color='#e54c62'>"
orange = "<span color='#ff7100'>"
brown = "<span color='#db842f'>"
fuchsia = "<span color='#800080'>"
gold = "<span color='#e7b400'>"


-- {{{ Wibox
 
-- {{{ Kernel Info
 
sysicon = wibox.widget.imagebox()
sysicon:set_image(beautiful.widget_arch)
syswidget = wibox.widget.textbox()
vicious.register( syswidget, vicious.widgets.os, brown .. "$2" ..coldef)
 
-- }}}
 
-- {{{ Uptime
 
uptimeicon = wibox.widget.imagebox()
uptimeicon:set_image(beautiful.widget_uptime)
uptimewidget = wibox.widget.textbox()
vicious.register( uptimewidget, vicious.widgets.uptime, "<span color=\"#d3c6d7\">$2.$3'</span>")
 
-- }}}
 
-- {{{ Cpu
 
-- CPU widget
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu, purple .. "$1%" .. coldef, 3)
cpuicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(tasks, false) end)))
 
-- }}}

 
-- {{{ Ram
 
-- Memory widget
memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.widget_mem)
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, yellow .. "$2MB" .. coldef, 5)
 
-- }}}
 
-- {{{ Mpd
 
mpdicon = wibox.widget.imagebox()
mpdicon:set_image(beautiful.widget_mpd)
mpdwidget = wibox.widget.textbox()
-- Register widget
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
        if args["{state}"] == "Stop" then
            return " - "
        else
            return args["{Artist}"]..' - '.. args["{Title}"]
        end
    end, 10)
 
-- }}}
 
-- {{{ Net
-- Net widget
netdownicon = wibox.widget.imagebox()
netdownicon:set_image(beautiful.widget_netdown)
netdownicon.align = "middle"
netdowninfo = wibox.widget.textbox()
vicious.register(netdowninfo, vicious.widgets.net, green .. "${enp9s0 down_kb}" .. coldef, 1)
netupicon = wibox.widget.imagebox()
netupicon:set_image(beautiful.widget_netup)
netupicon.align = "middle"
netupinfo = wibox.widget.textbox()
vicious.register(netupinfo, vicious.widgets.net, red .. "${enp9s0 up_kb}" .. coldef, 1)
 
 
ethdowninfo = wibox.widget.textbox()
vicious.register(ethdowninfo, vicious.widgets.net, "<span color=\"#d3c6d7\">${enp9s0 down_kb}</span>", 1)
 
ethupinfo = wibox.widget.textbox()
vicious.register(ethupinfo, vicious.widgets.net, "<span color=\"#d3c6d7\">${enp9s0 up_kb}</span>", 1)
 
-- }}}
 
-- {{{ Volume
 
-- Volume widget
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.widget_vol)
volumewidget = wibox.widget.textbox()
vicious.register(volumewidget, vicious.widgets.volume, blue .. "$1%" .. coldef,  1, "Master")
 
-- }}}

-- /home fs widget
fshtext = wibox.widget.textbox()
fshtext:set_text(' /home: ')
fshicon = wibox.widget.imagebox()
fshicon:set_image("/home/dean/.config/awesome/themes/blackburn/widgets/fs.png")
fshwidget = wibox.widget.textbox()
    vicious.register(fshwidget, vicious.widgets.fs,
    function (widget, args)
        if args["{/home used_p}"] >= 95 and args["{/home used_p}"] < 99 then
            return colwhi .. args["{/home used_p}"] .. "%" .. coldef
        elseif args["{/home used_p}"] >= 99 and args["{/home used_p}"] <= 100 then
            naughty.notify({ title = "Attention", text = "Partition /home full!.",
                             timeout = 10,
                             position = "top_right",
                             fg = beautiful.fg_urgent,
                             bg = beautiful.bg_urgent })
            return colwhi .. args["{/home used_p}"] .. "%" .. coldef
        else
            return azure .. args["{/home used_p}"] .. "%" .. coldef
        end
    end, 620)

--- / root widget
rshtext = wibox.widget.textbox()
rshtext:set_text(' /: ')
rshicon = wibox.widget.imagebox()
rshicon:set_image("/home/dean/.config/awesome/themes/blackburn/widgets/fs.png")
rshwidget = wibox.widget.textbox()
    vicious.register(rshwidget, vicious.widgets.fs,
    function (widget, args)
       if args["{/ used_p}"] >= 95 and args["{/ used_p}"] < 99 then
            return colwhi .. args["{/home used_p}"] .. "%" .. coldef
        elseif args["{/ used_p}"] >= 99 and args["{/ used_p}"] <= 100 then
            naughty.notify({ title = "Attention", text = "Partition / full!.",
                             timeout = 10,
                             position = "top_right",
                             fg = beautiful.fg_urgent,
                             bg = beautiful.bg_urgent })
            return colwhi .. args["{/ used_p}"] .. "%" .. coldef
        else
            return azure .. args["{/ used_p}"] .. "%" .. coldef
        end
    end, 620)

--- / citan-uzuki widget
cshtext = wibox.widget.textbox()
cshtext:set_text(' /citan: ')
cshicon = wibox.widget.imagebox()
cshicon:set_image("/home/dean/.config/awesome/themes/blackburn/widgets/fs.png")
cshwidget = wibox.widget.textbox()
    vicious.register(cshwidget, vicious.widgets.fs,
    function (widget, args)
       if args["{/media/citan-uzuki used_p}"] >= 95 and args["{/media/citan-uzuki used_p}"] < 99 then
            return colwhi .. args["{/home used_p}"] .. "%" .. coldef
        elseif args["{/media/citan-uzuki used_p}"] >= 99 and args["{/media/citan-uzuki used_p}"] <= 100 then
            naughty.notify({ title = "Attention", text = "Partition /citan-uzuki full!.",
                             timeout = 10,
                             position = "top_right",
                             fg = beautiful.fg_urgent,
                             bg = beautiful.bg_urgent })
            return colwhi .. args["{/media/citan-uzuki used_p}"] .. "%" .. coldef
        else
            return azure .. args["{/media/citan-uzuki used_p}"] .. "%" .. coldef
        end
    end, 620)

--- / snake-pliskin widget
sshtext = wibox.widget.textbox()
sshtext:set_text(' /snake: ')
sshicon = wibox.widget.imagebox()
sshicon:set_image("/home/dean/.config/awesome/themes/blackburn/widgets/fs.png")
sshwidget = wibox.widget.textbox()
    vicious.register(sshwidget, vicious.widgets.fs,
    function (widget, args)
       if args["{/media/snake-pliskin used_p}"] >= 95 and args["{/media/snake-pliskin used_p}"] < 99 then
            return colwhi .. args["{/home used_p}"] .. "%" .. coldef
        elseif args["{/media/snake-pliskin used_p}"] >= 99 and args["{/media/snake-pliskin used_p}"] <= 100 then
            naughty.notify({ title = "Attention", text = "Partition /snake-pliskin full!.",
                             timeout = 10,
                             position = "top_right",
                             fg = beautiful.fg_urgent,
                             bg = beautiful.bg_urgent })
            return colwhi .. args["{/media/snake-pliskin used_p}"] .. "%" .. coldef
        else
            return azure .. args["{/media/snake-pliskin used_p}"] .. "%" .. coldef
        end
    end, 620)


-------------------
-- Pacman Widget --
-------------------

-- Pacman Icon
pacicon = wibox.widget.imagebox()
pacicon:set_image(beautiful.widget_pac)

-- Pacman Widget
pacwidget = wibox.widget.textbox()
pacwidget_t = awful.tooltip({ objects = { pacwidget},})
vicious.register(pacwidget, vicious.widgets.pkg,
                function(widget,args)
                    local io = { popen = io.popen }
                    local s = io.popen("pacman -Qu")
                    local str = ''
                    for line in s:lines() do
                        str = str .. line .. "\n"
                    end
                    pacwidget_t:set_text(str)
                    s:close()
                    return " " .. args[1]
                end, 60, "Arch")
                --'1800' means check every 30 minutes

pacicon:buttons(awful.util.table.join(
    awful.button({ }, 3, function () awful.util.spawn("".. terminal.. " --hold -e sudo pacman -Syu", false) end),
    awful.button({ }, 1, function () awful.util.spawn("sudo pacman -Sy", false) end)
))
 
-- {{{ Clock
 
-- Textclock widget
clockicon = wibox.widget.imagebox()
clockicon:set_image(beautiful.widget_clock)
mytextclock = awful.widget.textclock("<span color='#7788af'>%A %d %B</span> " .. blue .. "</span><span color=\"#343639\">></span> <span color='#de5e1e'>%H:%M</span> ")
 
-- }}}
 
-- {{{ Spacers
space = wibox.widget.textbox()
space:set_text(' ')

-- {{{ Seperator
sepa = wibox.widget.textbox()
sepa:set_text('|')
 
-- }}}
 
-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
bottombox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))
 
for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
 
    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)
 
    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })


    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mylauncher)
    left_layout:add(mypromptbox[s])
 
    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    -- right_layout:add(sysicon)
    right_layout:add(space)
    right_layout:add(space)
    right_layout:add(sysicon)
    right_layout:add(syswidget)
    right_layout:add(space)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    right_layout:add(space)
    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)
    right_layout:add(space)
    right_layout:add(memicon)
    right_layout:add(memwidget)
    right_layout:add(space)
    right_layout:add(pacicon)
    right_layout:add(pacwidget)
    right_layout:add(space)
    right_layout:add(clockicon)
    right_layout:add(mytextclock)
    right_layout:add(space)
    -- right_layout:add(mylayoutbox[s])
 
    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)
 
    mywibox[s]:set_widget(layout)

    -- Create Bottom WiBox
    -- mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s })

    -- Widgets Aligned to the Left
    --local bottom_left_layout = wibox.layout.fixed.horizontal()
    -- bottom_left_layout:add(rshtext)
    -- bottom_left_layout:add(rshwidget)
    -- bottom_left_layout:add(space)
    -- bottom_left_layout:add(space)
    -- bottom_left_layout:add(fshtext)
    -- bottom_left_layout:add(fshwidget)
    -- bottom_left_layout:add(space)
    -- bottom_left_layout:add(space)
    -- bottom_left_layout:add(cshtext)
    -- bottom_left_layout:add(cshwidget)
    -- bottom_left_layout:add(space)
    -- bottom_left_layout:add(space)
    -- bottom_left_layout:add(sshtext)
    -- bottom_left_layout:add(sshwidget)
    -- bottom_left_layout:add(space)
    -- bottom_left_layout:add(space)
    
    -- Bring Bottom Wibox Together
    -- local bottom_layout = wibox.layout.align.horizontal()
    -- bottom_layout:set_middle(bottom_left_layout)
    -- mybottomwibox[s]:set_widget(bottom_layout)
end
-- }}}


-- Mouse Bindings

root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))


-- Key bindings
globalkeys = awful.util.table.join(

    -- Capture a screenshot
    awful.key({ altkey }, "p", function() awful.util.spawn("screenshot",false) end),

    

    -- Move clients
    awful.key({ altkey }, "Next",  function () awful.client.moveresize( 1,  1, -2, -2) end),
    awful.key({ altkey }, "Prior", function () awful.client.moveresize(-1, -1,  2,  2) end),
    awful.key({ altkey }, "Down",  function () awful.client.moveresize(  0,  1,   0,   0) end),
    awful.key({ altkey }, "Up",    function () awful.client.moveresize(  0, -1,   0,   0) end),
    awful.key({ altkey }, "Left",  function () awful.client.moveresize(-1,   0,   0,   0) end),
    awful.key({ altkey }, "Right", function () awful.client.moveresize( 1,   0,   0,   0) end),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
    mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
    end),

    -- Application Switcher
     awful.key({ "Mod1" }, "Tab", function ()
     -- If you want to always position the menu on the same place set coordinates
     awful.menu.menu_keys.down = { "Down", "Alt_L" }
     local cmenu = awful.menu.clients({width=245}, { keygrabber=true, coords={x=525, y=330} })
 end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)     end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)     end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)       end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)       end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)          end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)          end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1)  end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1)  end),
    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Dropdown terminal
    awful.key({ modkey,	          }, "z",     function () scratch.drop(terminal) end),

    -- Widgets popups
    awful.key({ altkey,           }, "c",     function () add_calendar(7) end),

    -- Volume control
    awful.key({ "Control" }, "Up", function ()
                                       awful.util.spawn("amixer set Master playback 1%+", false )
                                       vicious.force({ volumewidget })
                                   end),
    awful.key({ "Control" }, "Down", function ()
                                       awful.util.spawn("amixer set Master playback 1%-", false )
                                       vicious.force({ volumewidget })
                                     end),
    awful.key({ "Control" }, "m", function ()
                                       awful.util.spawn("amixer set Master playback mute", false )
                                       vicious.force({ volumewidget })
                                     end),
    awful.key({ "Control" }, "u", function () 
                                      awful.util.spawn("amixer set Master playback unmute", false )
                                       vicious.force({ volumewidget })
                                  end),
    awful.key({ altkey, "Control" }, "m", function () 
                                              awful.util.spawn("amixer set Master playback 100%", false )
                                              vicious.force({ volumewidget })
                                          end),

    -- Music control
    awful.key({ altkey, "Control" }, "Up", function () 
                                              awful.util.spawn( "mpc toggle", false ) 
                                              vicious.force({ mpdwidget } )
                                           end),
    awful.key({ altkey, "Control" }, "Down", function () 
                                                awful.util.spawn( "mpc stop", false ) 
                                                vicious.force({ mpdwidget } )
                                             end ),
    awful.key({ altkey, "Control" }, "Left", function ()
                                                awful.util.spawn( "mpc prev", false )
                                                vicious.force({ mpdwidget } )
                                             end ),
    awful.key({ altkey, "Control" }, "Right", function () 
                                                awful.util.spawn( "mpc next", false )
                                                vicious.force({ mpdwidget } )
                                              end ),

    -- Copy to clipboard
    awful.key({ modkey,        }, "c",      function () os.execute("xsel -p -o | xsel -i -b") end),

    -- User programs
    awful.key({ modkey,        }, "q",      function () awful.util.spawn( "dwb", false ) end),
    awful.key({ modkey,        }, "s",      function () awful.util.spawn(gui_editor) end),
    awful.key({ modkey, "Control" }, "f", 	    function () awful.util.spawn( terminal .. " -g 130x30 -e ranger", false ) end),
    awful.key({ modkey,        }, "d", 	    function () awful.util.spawn( "spacefm", false ) end),

    -- Prompt
    awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))


-- Set keys
root.keys(globalkeys)


-- Rules

awful.rules.rules = {
     -- All clients will match this rule.
     { rule = { },
       properties = { border_width = beautiful.border_width,
                      border_color = beautiful.border_normal,
                      focus = true,
                      keys = clientkeys,
                      buttons = clientbuttons,
	                  size_hints_honor = false
                     }
    },

    { rule = { class = "MPlayer" },
      properties = { floating = true } },

    { rule = { class = "dwb" },
          properties = { tag = tags[1][1] } },

    { rule = { class = "Midori" },
          properties = { tag = tags[1][1],
          			     maximized_vertical=true,
          			     maximized_horizontal=true } },

    { rule = { instance = "urxvt", class = "URxvt" },
          properties = { tag = tags[1][2] } },

    { rule = { class = "Sublime_text" },
          properties = { tag = tags[1][3] } },

    { rule = { class = "Spacefm" },
          properties = { tag = tags[1][5] } },

    { rule = { class = "Gedit" },
          properties = { tag = tags[1][3] } },

    { rule = { instance = "urxvt", class = "URxvt", name = "ranger"},
          properties = { tag = tags[1][2] } },      

    { rule = { instance = "urxvt", class = "URxvt", name = "mutt" },
          properties = { tag = tags[1][5] } },

    { rule = { instance = "urxvt", class = "URxvt", name = "htop" },
          properties = { tag = tags[1][5] } },

    { rule = { instance = "urxvt", class = "URxvt", name = "centerim5" },
          properties = { tag = tags[1][5] } },         

    { rule = { instance = "urxvt", class = "URxvt", name = "turses" },
          properties = { tag = tags[1][5] } },

    { rule = { instance = "urxvt", class = "URxvt", name = "cdw" },
          properties = { tag = tags[1][4] } },

    { rule = { instance = "urxvt", class = "URxvt", name = "transmission-remote-cli"},
          properties = { tag = tags[1][5] } },

    { rule = { instance = "urxvt", class = "URxvt", name = "mocp"},
          properties = { tag = tags[1][4] } },

    { rule = { instance = "urxvt", class = "URxvt", name = "vlc"},
          properties = { tag = tags[1][4] } },

      
	  { rule = { class = "Ghb" },
        properties = { tag = tags[1][4] } },    

    { rule = { class = "Devede" },
        properties = { tag = tags[1][4] } },

    { rule = { name = "LibreOffice"},
        properties = { tag = tags[1][3] } },

    { rule = { class = "Thunderbird" },
          properties = { tag = tags[1][3] } },

    { rule = { class = "Dia" },
          properties = { tag = tags[1][4],
          floating = true } },

    { rule = { class = "Gimp" },
          properties = { tag = tags[1][4],
          floating = true } },

    { rule = { class = "Inkscape" },
          properties = { tag = tags[1][4],
          floating = true } },

    { rule = { class = "Transmission-gtk" },
          properties = { tag = tags[1][5] } },

    { rule = { class = "Torrent-search" },
          properties = { tag = tags[1][5] } },
}


-- Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)