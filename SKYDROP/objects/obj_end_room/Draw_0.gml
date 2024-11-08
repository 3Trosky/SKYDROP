// Nastavení písma a barvy textu
draw_set_font(fnt_menu);  // Používáme vlastní písmo
draw_set_color(c_white);  // Bílý text

// Pozadí pro text - pro lepší čitelnost
draw_set_alpha(0.5);  // Polovina průhlednosti pro pozadí
draw_set_color(c_black);  // Černá barva pro pozadí

// Vypočítání textu, který se bude zobrazovat
var text_to_display = "You completed the game in " + string(final_time / 1000) + " seconds.";

// Vypočítání šířky a výšky textu
var text_width = string_width(text_to_display);
var text_height = string_height(text_to_display);

// Vypočítání pozice pro text (středování) podle velikosti místnosti
var text_x = (room_width - text_width) / 2;  // Horizontální středování
var text_y = (room_height - text_height) / 2;  // Vertikální středování

// Vykreslení obdélníku kolem textu (pozadí)
draw_rectangle(text_x - 10, text_y - 10, text_x + text_width + 10, text_y + text_height + 10, false);

// Resetování průhlednosti
draw_set_alpha(1);  // Plná neprůhlednost

// Stínování textu (pokud chceš)
draw_set_color(c_black);  // Černý stín textu
draw_text(text_x + 2, text_y + 2, text_to_display);  // Stín textu

// Hlavní text (bílé písmo)
draw_set_color(c_white);  // Bílý text
draw_text(text_x, text_y, text_to_display);  // Hlavní text
