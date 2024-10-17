draw_self();

draw_set_font(fnt_menu);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(x, y, button_text);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

audio_play_sound(snd_menu, 1, true); // Hraje hudbu na pozadí (loop = true)