// Iniciace pohybu
x_speed = 0;

// Pohyb do stran
if (keyboard_check(ord("A"))) {
    x_speed = -2;
}
if (keyboard_check(ord("D"))) {
    x_speed = 2;
}

// Skok pomocí mezerníku nebo klávesy W
var on_ground_or_platform = place_meeting(x, y + 1, obj_ground) || (place_meeting(x, y + 1, obj_platform) && y < instance_place(x, y + 1, obj_platform).y);
if ((keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"))) && on_ground_or_platform) {
    y_speed = -8; // Výška skoku
    audio_play_sound(snd_jump, 1, false); // Zvuk skoku
}

// Gravitace
y_speed += 0.4;

// Detekce kolize se zdí a pohyb horizontálně
if (place_meeting(x + x_speed, y, obj_ground)) {
    while (!place_meeting(x + sign(x_speed), y, obj_ground)) {
        x += sign(x_speed); // Posouvá postavu až těsně ke zdi
    }
    x_speed = 0;
}

// Detekce kolize se zdí a pohyb horizontálně (s fillem země)
if (place_meeting(x + x_speed, y, obj_groundfill)) {
    while (!place_meeting(x + sign(x_speed), y, obj_groundfill)) {
        x += sign(x_speed); // Posouvá postavu až těsně ke zdi
    }
    x_speed = 0;
}


// Platformový pohyb
var _platform = instance_place(x, y + 1, obj_platform);
if (_platform != noone && y + sprite_height / 2 <= _platform.y) {
    // Postava je na platformě - pohybuje se s ní
    x += _platform.x_speed;
    
    // Reset vertikální rychlosti při přistání na platformu
    if (y_speed > 0) {
        y_speed = 0;
    }
}

// Vertikální kolize s obj_ground nebo platformou
if (y_speed > 0 && place_meeting(x, y + y_speed, obj_ground)) {
    while (!place_meeting(x, y + sign(y_speed), obj_ground)) {
        y += sign(y_speed);
    }
    y_speed = 0;
} else if (y_speed < 0 && place_meeting(x, y + y_speed, obj_ground)) {
    while (!place_meeting(x, y + sign(y_speed), obj_ground)) {
        y += sign(y_speed);
    }
    y_speed = 0;
}

// Vertikální kolize s platformou (kontrola shora i zdola)
if (place_meeting(x, y + y_speed, obj_platform)) {
    var _platform_y = instance_place(x, y + y_speed, obj_platform).y;
    if (y_speed < 0 && y > _platform_y) {
        y = _platform_y + sprite_height / 2;
        y_speed = 0;
    } else if (y_speed > 0 && y < _platform_y) {
        while (!place_meeting(x, y + sign(y_speed), obj_ground) && !place_meeting(x, y + sign(y_speed), obj_platform)) {
            y += sign(y_speed);
        }
        y_speed = 0;
    }
}

// Resetování pozice, pokud postava spadne z mapy
if (y > 1000) {
    x = 478;
    y = 350;
}

// Reset při kolizi s ostnem
if (place_meeting(x, y, obj_spike)) {
    room_restart();
}

// Přechod na další level při dotyku vlajky
if (place_meeting(x, y, obj_flag)) {
    room_goto_next();
}

// Reálný pohyb postavy
x += x_speed;
y += y_speed;
