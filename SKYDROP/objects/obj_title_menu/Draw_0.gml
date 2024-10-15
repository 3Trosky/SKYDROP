// draw menu bg

draw_sprite_ext(sprite_index, image_index, x, y, width / sprite_width, height / sprite_height, 0, c_white, 1);

// V Draw Eventu tlačítka
draw_sprite(sprite_index, 0, x, y);

// V Mouse Left Pressed Eventu tlačítka
if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id)) {
    room_goto(Room1); // Název room, kam se chceš přepnout
}
