-- {{{ Main
theme           = {}
theme.dir       = "~/.config/awesome/themes/zenburn2/"
theme.icondir   = theme.dir .. "icons/"
theme.walldir   = theme.dir .. "wallpapers/"
theme.tagdir    = theme.dir .. "taglist/"
theme.layoutdir = theme.dir .. "layouts/"
theme.titledir  = theme.dir .. "titlebar/"
theme.wallpaper = theme.walldir .. "winter-scene.png"
-- }}}

-- {{{ Styles
theme.font      = "Aller Bold 8"

-- DISABLE TASKLIST ICONS
theme.tasklist_disable_icon = true

-- {{{ Colors
theme.fg_normal  = "#2D2D2D"
theme.fg_focus   = "#888888"
theme.fg_urgent  = "#666666"
theme.bg_focus   = "#EFEFEF"
theme.bg_urgent  = "#D8D8D8"
theme.bg_normal  = theme.bg_focus
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.border_width  = 1
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.bg_urgent
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = 15
theme.menu_width  = 110
theme.menu_border_width = 0 
theme.menu_border_color = "#ED1F00"
theme.menu_bg_normal = theme.bg_normal
theme.menu_bg_focus  = theme.bg_focus
theme.menu_fg_normal = theme.fg_normal
theme.menu_fg_focus  = theme.fg_focus
-- }}}

-- {{{ Icons
-- {{{ Taglist
-- theme.taglist_squares_sel   = theme.tagdir .. "squarefz.png"
-- theme.taglist_squares_unsel = theme.tagdir .. "squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ CUSTOM ICONS
theme.awesome_icon           = theme.icondir .. "awesome-icon.png"
theme.arch_icon              = theme.icondir .. "arch-icon.png"
theme.lyx_icon               = theme.icondir .. "lyx_icon.png"
theme.folder_icon            = theme.icondir .. "folder_icon.png"
theme.menu_submenu_icon      = theme.icondir .. "submenu2.png"
theme.pacman_icon						 = theme.icondir .. "pacman-icon.png"
theme.calendar_icon					 = theme.icondir .. "calendar-icon.png"
theme.music_icon					   = theme.icondir .. "music-icon.png"
theme.clock_icon					   = theme.icondir .. "clock-icon.png"
theme.brightness             = theme.icondir .. "sunny18.svg"
theme.brightness2            = theme.icondir .. "sunny182.svg"
theme.gmail_icon             = theme.icondir .. "gmail.png"
theme.chrome_icon            = theme.icondir .. "chrome.png"

-- }}}

-- {{{ Layout
theme.layout_tile       = theme.layoutdir .. "tile.png"
theme.layout_tileleft   = theme.layoutdir .. "tileleft.png"
theme.layout_tilebottom = theme.layoutdir .. "tilebottom.png"
theme.layout_tiletop    = theme.layoutdir .. "tiletop.png"
theme.layout_fairv      = theme.layoutdir .. "fairv.png"
theme.layout_fairh      = theme.layoutdir .. "fairh.png"
theme.layout_spiral     = theme.layoutdir .. "spiral.png"
theme.layout_dwindle    = theme.layoutdir .. "dwindle.png"
theme.layout_max        = theme.layoutdir .. "max.png"
theme.layout_fullscreen = theme.layoutdir .. "fullscreen.png"
theme.layout_magnifier  = theme.layoutdir .. "magnifier.png"
theme.layout_floating   = theme.layoutdir .. "floating.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = theme.titledir .. "close_focus.png"
theme.titlebar_close_button_normal = theme.titledir .. "close_normal.png"

theme.titlebar_ontop_button_focus_active  = theme.titledir .. "ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme.titledir .. "ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = theme.titledir .. "ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.titledir .. "ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = theme.titledir .. "sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme.titledir .. "sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = theme.titledir .. "sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.titledir .. "sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = theme.titledir .. "floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme.titledir .. "floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = theme.titledir .. "floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.titledir .. "floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = theme.titledir .. "maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme.titledir .. "maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.titledir .. "maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.titledir .. "maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
