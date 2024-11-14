draw_set_font(fnt_menu);  
draw_set_color(c_white);  

draw_set_alpha(0.5);
draw_set_color(c_black);  

var text_to_display = "You completed the game in " + string(final_time / 1000) + " seconds.";

var text_width = string_width(text_to_display);
var text_height = string_height(text_to_display);

var text_x = (room_width - text_width) / 2; 
var text_y = (room_height - text_height) / 2;  

draw_rectangle(text_x - 10, text_y - 10, text_x + text_width + 10, text_y + text_height + 10, false);

draw_set_alpha(1);  

draw_set_color(c_black); 
draw_text(text_x + 2, text_y + 2, text_to_display); 

draw_set_color(c_white);  
draw_text(text_x, text_y, text_to_display);  
