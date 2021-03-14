-- This is the lua script that renders the dials for use with conkyrc-dials.conf.
-- MIT License. Legend Zeratul.
require 'cairo'

function conky_main ()
  if conky_window == nil then
    return
  end
  local cs = cairo_xlib_surface_create (conky_window.display, conky_window.drawable,
                                        conky_window.visual, conky_window.width,
                                        conky_window.height)
  cr = cairo_create (cs)
  
  -- Color theme definitions
  themes = {}
  themes["nord"] = {}
  themes["snow"] = {}

  themes.snow.dial_bg = {0x3b, 0x42, 0x52, 0.65}
  themes.snow.arc_bg  = {0x4c, 0x56, 0x6a, 1}
  themes.snow.cpu_fg  = {{0xec, 0xef, 0xf4, 1}}
  themes.snow.mem_fg  = {{0xec, 0xef, 0xf4, 1}, {0x5e, 0x81, 0xac, 1}}
  themes.snow.dsk_fg  = {{0xec, 0xef, 0xf4, 1}, {0x4c, 0x56, 0x6a, 1}}
  themes.snow.net_fg  = {{0xec, 0xef, 0xf4, 1}, {0x5e, 0x81, 0xac, 1}}
  themes.snow.bat_fg  = {{0xec, 0xef, 0xf4, 1}}

  themes.nord.dial_bg = {0x3b, 0x42, 0x52, 0.75}
  themes.nord.arc_bg  = {0xd8, 0xde, 0xe9, 0.91}
  themes.nord.cpu_fg  = {{0xbf, 0x61, 0x6a, 1}}
  themes.nord.mem_fg  = {{0xb4, 0x8e, 0xad, 1}, {0x5e, 0x81, 0xac, 1}}
  themes.nord.dsk_fg  = {{0xa3, 0xbe, 0x8c, 1}, {0x4c, 0x56, 0x6a, 1}}
  themes.nord.net_fg  = {{0x81, 0xa1, 0xc1, 1}, {0x5e, 0x81, 0xac, 1}}
  themes.nord.bat_fg  = {{0xd0, 0x87, 0x70, 1}}
  
  curr_theme = themes.snow

  draw_dial(cr, conky_parse ("${cpu}"), "CPU",
                convert_colors(curr_theme.dial_bg), 
                convert_colors(curr_theme.arc_bg), 
                convert_colors(curr_theme.cpu_fg[1]), 55, 190, 43)
  
  draw_dial(cr, conky_parse ("${memperc}"), "Memory",
                convert_colors(curr_theme.dial_bg), 
                convert_colors(curr_theme.arc_bg), 
                convert_colors(curr_theme.mem_fg[1]), 165, 190, 43)

  draw_dial(cr, conky_parse ("${fs_used_perc /swift}"), "/swift",
                convert_colors(curr_theme.dial_bg), 
                convert_colors(curr_theme.arc_bg), 
                convert_colors(curr_theme.dsk_fg[1]), 275, 190, 43)

  draw_dial(cr, conky_parse ("${wireless_link_qual_perc wlan0}"), "Wi-Fi",
                convert_colors(curr_theme.dial_bg), 
                convert_colors(curr_theme.arc_bg), 
                convert_colors(curr_theme.net_fg[1]), 385, 190, 43)

  draw_dial(cr, conky_parse ("${battery_percent}"), "Battery",
                convert_colors(curr_theme.dial_bg), 
                convert_colors(curr_theme.arc_bg), 
                convert_colors(curr_theme.bat_fg[1]), 495, 190, 43)

  cairo_destroy (cr)
  cairo_surface_destroy (cs)
  cr = nil
end

function convert_colors(base_col, opacity)
  return {base_col[1]/255, base_col[2]/255, base_col[3]/255, base_col[4]}  
end

function draw_dial (cr, value, title, dial_bg, arc_bg, arc_fg, x, y, dial_radius)
  max_value = 100
  ring_width = 7

  ffc_percent = "Inter"
  tsz_percent = 25.0

  ffc_title = "Inter"
  tsz_title = 12.0

  -- Draw background.
  cairo_set_line_width (cr, ring_width)
  cairo_set_source_rgba (cr, dial_bg[1], dial_bg[2], dial_bg[3], dial_bg[4])
  cairo_arc (cr, x, y, dial_radius-ring_width/2, 0, 2 * math.pi)
  cairo_fill (cr)

  cairo_set_source_rgba (cr, arc_bg[1], arc_bg[2], arc_bg[3], arc_bg[4])
  cairo_arc (cr, x, y, dial_radius, 0, 2 * math.pi)
  cairo_stroke (cr)

  -- Calculate angles for current use %
  -- ie for every 1% increase in cpu% the arc should move an additional
  -- 3.6 degrees.
  value = tonumber(value) or 0
  end_angle = value * (360 / max_value)
  end_angle_radians = (end_angle - 90) * (math.pi / 180)
  
  -- Draw the arc
  cairo_set_line_width (cr, ring_width)
  cairo_set_source_rgba (cr, arc_fg[1], arc_fg[2], arc_fg[3], arc_fg[4])
  cairo_arc (cr, x, y, dial_radius, (-90) * (math.pi / 180), end_angle_radians)
  cairo_stroke (cr)

  -- Draw the % text and the heading
  extents = cairo_text_extents_t:create()
  tolua.takeownership(extents)

  value_text = string.format("%d", value) .. '%'
  
  cairo_select_font_face (cr, ffc_percent, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
  cairo_set_font_size (cr, tsz_percent);
  
  cairo_text_extents (cr, value_text, extents);
  text_x = x - (extents.width/2);
  text_y = y - (extents.y_bearing/2);
  
  cairo_move_to (cr, text_x, text_y);
  cairo_show_text (cr, value_text);

  cairo_select_font_face (cr, ffc_title, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
  cairo_set_font_size (cr, tsz_title);
  
  cairo_text_extents (cr, title, extents);
  text_x = x - (extents.width/2);
  text_y = y + dial_radius + ring_width + 15;
  
  cairo_move_to (cr, text_x, text_y);
  cairo_show_text (cr, title);
end
