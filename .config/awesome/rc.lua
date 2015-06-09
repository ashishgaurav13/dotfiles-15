-- IMPORTS
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local vicious = require("vicious")
local awesompd = require("awesompd/awesompd")

-- ERRORS?
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end


-- IF ERRORS, NOTIFY
do
    local in_error = false
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


-- THEME & WALLPAPER
themefile = "~/.config/awesome/themes/zenburn2/theme.lua"
beautiful.init(themefile)
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end



-- DEFAULTS
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

-- STARTUP THINGS
awful.util.spawn_with_shell("compton -fG &")
--awful.util.spawn_with_shell("redshift -l 23.35:85.33 &")
--awful.util.spawn_with_shell("killall nm-applet; nm-applet &")

-- LAYOUTS ??
local layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}


-- TAG TABLE
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "α", "β", "γ", "δ" }, s, 
    layouts[0])
end


-- LAUNCHER
mymainmenu = awful.menu({ items = { 
    	{ "awesome", {
       		{ "manual", terminal .. " -e man awesome" },
       		{ "edit config", editor_cmd .. " " .. awesome.conffile },
       		{ "directory", terminal .. " -e ranger" .. " /home/agaurav77/.config/awesome"},
          { "edit theme", terminal .. " -e vim /home/agaurav77/.config/awesome/themes/zenburn2/theme.lua" },
       		-- { "edit compton", editor_cmd .. " ~/.config/compton.conf" },
       		{ "restart", awesome.restart },
    		{ "quit", awesome.quit } } },
    --	{ "latex", {
    --		{ "csa", {
    --			{ "mod2", "lyx /home/agaurav77/Books/CSA/mod2.lyx" },
    --			{ "mod3", "lyx /home/agaurav77/Books/CSA/mod3.lyx" },
    --			{ "mod4", "lyx /home/agaurav77/Books/CSA/mod4.lyx" },
    --			{ "mod5", "lyx /home/agaurav77/Books/CSA/mod5.lyx" } } },
    --		{ "os", {
    --			{ "c5 - process mgmt", "lyx /home/agaurav77/Books/OS/created/c5.lyx" },
    --			{ "c7 - deadlocks", "lyx /home/agaurav77/Books/OS/created/c7.lyx" },
    --			{ "c8 - mem mgmt", "lyx /home/agaurav77/Books/OS/created/c8.lyx" },
    --			{ "c10", "lyx /home/agaurav77/Books/OS/created/c10.lyx" } } }
    --	} },
	--	{ "tv series", {
	--		{ "ashoka", "pcmanfm -n '/media/Seagate/TV Series/Ashoka/'" },
	--		{ "shield", "pcmanfm -n '/media/Seagate/TV Series/Marvels Agents of S.H.I.E.L.D/'" } } },
	--    { "firefox", "firefox" },
	    { "chrome", "google-chrome-stable"},
    	{ "urxvt", terminal },
    	{ "ranger", terminal .. " -e ranger" },
      { "books", {
        { "competitive prog", "okular '/home/agaurav77/Books/competitive-prog.pdf'" },
        { "python nltk", "okular '/home/agaurav77/Books/python-nltk.pdf'" }
      } }
	--	{ "seagate", "pcmanfm -n /media/Seagate/" },
  --  	{ "linuxdcpp", "linuxdcpp" },
--    	{ "cmus", terminal .. " cmus" },
  --  	{ "sqldeveloper", "oracle-sqldeveloper" }
	}
})


-- mylauncher  = awful.widget.launcher({ image = beautiful.arch_icon })
menubar.utils.terminal = terminal


-- WIDGETS
mytextclock = awful.widget.textclock()
blanktext = wibox.widget.textbox()
blanktext:set_text(" ")
mylauncher  = wibox.widget.imagebox()
mylauncher:set_image(beautiful.arch_icon)
mylauncher:buttons(awful.util.table.join(
  awful.button({ }, 1, function() awful.util.spawn("urxvt") end)))
lyxlauncher  = wibox.widget.imagebox()
lyxlauncher:set_image(beautiful.lyx_icon)
lyxlauncher:buttons(awful.util.table.join(
  awful.button({ }, 1, function() awful.util.spawn("lyx") end)))
flauncher  = wibox.widget.imagebox()
flauncher:set_image(beautiful.folder_icon)
flauncher:buttons(awful.util.table.join(
  awful.button({ }, 1, function() awful.util.spawn(terminal .. "ranger /home/agaurav77/Programs/NaCl") end)))
chromelauncher  = wibox.widget.imagebox()
chromelauncher:set_image(beautiful.chrome_icon)
chromelauncher:buttons(awful.util.table.join(
  awful.button({ }, 1, function() awful.util.spawn("google-chrome-stable --show-app-list") end)))

brightness  = wibox.widget.imagebox()
brightness:set_image(beautiful.brightness)
brightness:buttons(awful.util.table.join(
	awful.button({ }, 4, function() awful.util.spawn("xbacklight + 10") end),
	awful.button({ }, 5, function() awful.util.spawn("xbacklight - 10") end)))
-- battery
batwidget = wibox.widget.textbox()
batwidget:set_markup("")
batwidgettimer = timer({timeout = 3})
batwidgettimer:connect_signal("timeout",
	function()
		fh = assert(io.popen("acpi | cut -d, -f 2 - | cut -d% -f 1", "r"))
		fh2 = assert(io.popen("acpi | cut -d' ' -f 3 -", "r"))
--		fhrs = assert(io.popen("acpi | cut -d, -f 3 - | cut -d' ' -f 2 | cut -d':' -f 1", "r"))
--		fmin = assert(io.popen("acpi | cut -d, -f 3 - | cut -d' ' -f 2 | cut -d':' -f 2", "r"))
		if (fh2:read("*l") == "Discharging,") then
--			batwidget:set_markup("<span color='green'>[</span><span color='white'>" .. fh:read("*l") .. " (" .. fhrs:read("*l") .. " hrs, " .. fmin:read("*l") .. " mins)" .. "</span><span color='green'> ]</span>")
			batwidget:set_markup("<span color='pink'>[</span><span color='white'>" .. fh:read("*l") .. "%</span><span color='pink'> ] </span>")
		else
			batwidget:set_markup("<span color='yellow'>[</span><span color='white'>" .. fh:read("*l") .. "%</span><span color='yellow'> ] </span>")
		end
		fh:close()
		fh2:close()
--		fhrs:close()
--		fmin:close()
	end
)
batwidgettimer:start()

-- PACMAN WIDGET
pacman = wibox.widget.imagebox()
pacman:set_image(beautiful.pacman_icon)
pacmant = wibox.widget.textbox()
pacmantext = awful.tooltip({ objects = { pacman }, })
vicious.register(pacman, vicious.widgets.pkg, function(widget, args)
      local s = io.popen("pacman -Qu")
      local res = " Total Updates = " .. args[1]
      for line in s:lines() do
        res = res .. "\n " .. line
      end
      pacmantext:set_text(res)
      pacmant:set_text("(" .. args[1] .. ")" )
      s:close()
      return "updates = " .. args[1]
  end, 1800, "Arch")

-- CALENDAR WIDGET
cal = wibox.widget.imagebox()
cal:set_image(beautiful.calendar_icon)
calt = awful.tooltip({ objects = { cal }, })
vicious.register(cal, vicious.widgets.pkg, function(widget, args)
      local s = io.popen("cal")
      local res = "\n"
      for line in s:lines() do
        res = res .. " " .. line .. " " .. "\n"
      end
      calt:set_text(res)
      s:close()
      return ""
  end, 1800, "Arch")

-- TIME WIDGET
timewidget = wibox.widget.imagebox()
timewidget:set_image(beautiful.clock_icon)
timet = awful.tooltip({ objects = { timewidget }, })
vicious.register(timewidget, vicious.widgets.pkg, function(widget, args)
      local s1 = io.popen("date | cut -d' ' -f 4 | cut -d':' -f 1")
      local s2 = io.popen("date | cut -d' ' -f 4 | cut -d':' -f 2")
      local res = "24 hr clock -> "
      for line in s1:lines() do
        res = res .. line
      end
      res = res .. ":"
      for line in s2:lines() do
        res = res .. line
      end
      timet:set_text(res)
      s1:close()
      s2:close()
      return ""
  end, 60, "Arch")


-- MPD WIDGET
-- Courtesy of AWESOMPD and Awesome Wiki
mpdwidget = awesompd:create()
mpdwidget.font = "Inconsolata"
mpdwidget.scrolling = "true"
mpdwidget.output_size = 30
mpdwidget.widget_icon = beautiful.music_icon
mpdwidget.update_interval = 10
mpdwidget.path_to_icons = "/home/agaurav77/.config/awesome/awesompd/icons"
mpdwidget.show_album_cover = true
mpdwidget.album_cover_size = 50
mpdwidget.mpdconfig = "/home/agaurav77/.mpd"
mpdwidget.servers = {
  { server = "localhost", port = 6600 } }
mpdwidget:register_buttons({  { "", awesompd.MOUSE_LEFT, mpdwidget:command_playpause() },
                              { "Control", awesompd.MOUSE_SCROLL_UP, mpdwidget:command_prev_track() },
                              { "Control", awesompd.MOUSE_SCROLL_DOWN, mpdwidget:command_next_track() },
                              { "", awesompd.MOUSE_SCROLL_UP, mpdwidget:command_volume_up() },
                              { "", awesompd.MOUSE_SCROLL_DOWN, mpdwidget:command_volume_down() },
                              { "", awesompd.MOUSE_RIGHT, mpdwidget:command_show_menu() },
                              { "", "XF86AudioLowerVolume", mpdwidget:command_volume_down() },
                              { "", "XF86AudioRaiseVolume", mpdwidget:command_volume_up() },
                              { modkey, "Pause", mpdwidget:command_playpause() } })
mpdwidget:run()

-- GMAIL WIDGET
mygmail = wibox.widget.textbox()
-- gtooltip = awful.tooltip({ objects = {mygmail}, })
mygmaili = wibox.widget.imagebox()
mygmaili:set_image(beautiful.gmail_icon)
vicious.register(mygmail, vicious.widgets.gmail,
    function(widget, args)
      -- gtooltip:set_text(args["{subject}"])
      -- gtooltip:add_to_object(mygmaili)
      if args["{count}"] == 0 then
        return ""
      else
        return "<span color='white'>[ " .. args["{count}"] .. " unread ]</span> "
      end
    end, 120)




-- BINDINGS & EXTRA
mywibox = {}
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
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
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


-- ADD UP EVERYTHING
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
    mywibox[s] = awful.wibox({ position = "top", height = "18", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    --left_layout:add(blanktext)
    left_layout:add(mylauncher)
    --left_layout:add(mylayoutbox[s])
    --left_layout:add(chromelauncher)
    --left_layout:add(blanktext)
    left_layout:add(blanktext)
    left_layout:add(mytaglist[s])
    left_layout:add(blanktext)
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(wibox.widget.systray())
    right_layout:add(blanktext)
    --right_layout:add(blanktext)
    right_layout:add(batwidget)
    right_layout:add(blanktext)
    right_layout:add(mygmail)
    right_layout:add(mygmaili)
    --right_layout:add(myclockwidget)
    right_layout:add(brightness)
   	right_layout:add(flauncher)
   	right_layout:add(mpdwidget.widget)
    --right_layout:add(timewidget)
    right_layout:add(cal)
    right_layout:add(pacman)
 
    --right_layout:add(blanktext)
    --right_layout:add(pacmant)
    --right_layout:add(blanktext)
    --right_layout:add(lyxlauncher)
    --right_layout:add(flauncher)
    -- right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end



-- MOUSE BINDINGS
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))



-- KEY BINDINGS
globalkeys = awful.util.table.join(
    awful.key({ }, "Print", function()
              awful.util.spawn("scrot -d 1 -e 'mv $f ~/Pictures/ 2>/dev/null'")
              end),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

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
    awful.key({ modkey, "Shift"   }, "f", function () awful.util.spawn(terminal .. " ranger") end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
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

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)



-- RULES
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     size_hints_honor = false,
                     keys = clientkeys,
   	                 buttons = clientbuttons },
    },
    { rule = { class = "Google-chrome-stable" },
      properties = { border_width = 0 } },
    { rule = { class = "MPlayer" },
      properties = { floating = true, size_hints_honor = false } },
    { rule = { class = "Evince" },
      properties = { maximized_horizontal = true, maximized_vertical = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "Gimp" },
      properties = { floating = true } },
	  { rule = { class = "Xterm" },
      properties = { floating = true} },
    { rule = { instance = "crx_knipolnnllmklapflnccelgolnpehhpl" },
      properties = { floating = true} }
      -- callback = function(c) awful.titlebar.add(c, { modkey = modkey }) end } 
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}



-- SIGNALS
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
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
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
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
