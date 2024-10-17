x_speed = 0;

// Pohyb do stran
if (keyboard_check(ord("A"))) {
    x_speed = -5;
}
if (keyboard_check(ord("D"))) {
    x_speed = 5;
}

// Skok pomocí mezerníku nebo klávesy W
if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"))) {
	
	audio_play_sound(snd_jump,1,false); // Zvuk skoku
	
    if (place_meeting(x, y + 1, obj_ground) || (place_meeting(x, y + 1, obj_platform) && y < instance_place(x, y + 1, obj_platform).y)) { 
        // Kontrola, zda je postava na zemi nebo na platformě a je NAD platformou
        y_speed = -12; // Výška skoku
		
    }
	
	
}

// Gravitace
y_speed += 0.5;

// Detekce kolize se zdí a pohyb horizontálně (pro `obj_ground`)
if (place_meeting(x + x_speed, y, obj_ground)) {
    while (!place_meeting(x + sign(x_speed), y, obj_ground)) {
        x += sign(x_speed);  // Posouvá postavu až těsně ke zdi
    }
    x_speed = 0;
}

// Detekce kolize s platformou
var _platform = instance_place(x, y + 1, obj_platform);
if (_platform != noone) {
    // Pokud je postava nad platformou
    if (y + sprite_height / 2 < _platform.y) {
        y = _platform.y - sprite_height / 2; // Posuneme postavu těsně nad platformu
        y_speed = 0; // Zastavíme vertikální pohyb
    }

    // Pokud je postava pod platformou a pohybuje se nahoru, posuneme ji nad platformu
    if (y < _platform.y && y_speed < 0) {
        y = _platform.y + sprite_height / 2; // Posuneme ji těsně nad platformu
        y_speed = 0; // Zastavíme vertikální pohyb
    }

    // Přidáme horizontální rychlost platformy, pokud je postava nad ní
    if (y + sprite_height / 2 >= _platform.y) {
        x += _platform.x_speed; // Postava se posune s platformou
    }
}

// Detekce kolize s obj_ground a pohyb vertikálně
if (y_speed > 0 && place_meeting(x, y + y_speed, obj_ground)) {
    while (!place_meeting(x, y + sign(y_speed), obj_ground)) {
        y += sign(y_speed);  // Posouvá postavu až těsně nad zem
    }
    y_speed = 0;  // Zastaví vertikální pohyb na `obj_ground`
} else if (y_speed < 0 && place_meeting(x, y + y_speed, obj_ground)) {
    // Pokud postava narazí do `obj_ground` ze spodu
    while (!place_meeting(x, y + sign(y_speed), obj_ground)) {
        y += sign(y_speed);  // Posouvá postavu až těsně nad zem
    }
    y_speed = 0;  // Zastaví vertikální pohyb na `obj_ground`
}

// Detekce kolize s platformou (kontrola shora a zdola)
if (place_meeting(x, y + y_speed, obj_platform)) {
    var _platform_y = instance_place(x, y + y_speed, obj_platform).y;

    // Pokud postava narazí do platformy zespodu
    if (y_speed < 0 && y > _platform_y) {
        y = _platform_y + sprite_height / 2; // Posuneme ji těsně nad platformu
        y_speed = 0; // Zastavíme vertikální pohyb
    } 

    // Pokud postava padá na platformu
    else if (y_speed > 0 && y < _platform_y) {
        while (!place_meeting(x, y + sign(y_speed), obj_ground) && !place_meeting(x, y + sign(y_speed), obj_platform)) {
            y += sign(y_speed);  // Posouvá postavu až těsně nad platformu
        }
        y_speed = 0;  // Zastaví vertikální pohyb na platformě
    }
}

// Když spadne z mapy, aby se portl na začátek (zatím jen provizorně) 
if (y > 1000) {
    x = 478;
    y = 350;
}

// Aby tě skočení na spike vrátilo na začátek
if (place_meeting(x, y, obj_spike)) {
    room_restart();
}

// Aby se při dokončení levelu (dotknutí vlajky) dalo do dalšího levelu
if (place_meeting(x, y, obj_flag)) {
    room_goto_next();
}

// Realný pohyb postavy
x += x_speed;
y += y_speed;
