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
    if (place_meeting(x, y + 1, obj_ground) || (place_meeting(x, y + 1, obj_platform) && y < instance_place(x, y + 1, obj_platform).y)) { 
        // Kontrola, zda je postava na zemi nebo na platformě a je NAD platformou
        y_speed = -12; // Výška skoku
    }
}

// Gravitace
y_speed += 0.5;

// Detekce kolize se zdí a pohyb horizontálně (pro `obj_ground`)
if (place_meeting(x + x_speed, y, obj_ground)) {
    // Zastaví horizontální pohyb, pokud dojde k nárazu
    if (x_speed > 0) {
        while (!place_meeting(x + 1, y, obj_ground)) {
            x += 1; // Posune hráče doprava
        }
    } else if (x_speed < 0) {
        while (!place_meeting(x - 1, y, obj_ground)) {
            x -= 1; // Posune hráče doleva
        }
    }
    x_speed = 0; // Zastaví horizontální pohyb
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
    room_goto(rm_lvl2);

}

// Realný pohyb postavy
x += x_speed;
y += y_speed;


// PLATFORMA 



// Detekce kolize s obj_platform (bez možnosti proskakování)
var _platform = instance_place(x, y + y_speed, obj_platform);

if (_platform != noone) {
    // Pokud postava narazí na platformu ze spodu
    if (y_speed < 0) {
        // Pokud narazí do platformy zespodu, zastaví vertikální pohyb
        while (!place_meeting(x, y + sign(y_speed), _platform)) {
            y += sign(y_speed);  // Posouvá postavu až těsně nad platformu
        }
        y_speed = 0;  // Zastaví vertikální pohyb
    } 
    // Pokud postava může přistát na platformě (je NAD platformou)
    else if (y_speed > 0 && y < _platform.y) {
        // Postava se posune na přesnou výšku vrchu platformy
        y = _platform.y - sprite_height / 2;

        y_speed = 0;  // Zastaví vertikální pohyb na platformě

        // Posun spolu s platformou (pokud se platforma pohybuje)
        x += _platform.x_speed;  // Přidá horizontální rychlost platformy k pozici hráče
        y += _platform.y_speed;  // Přidá vertikální rychlost platformy k pozici hráče
    }
}

// Kontrola horizontální kolize s obj_ground
if (place_meeting(x + x_speed, y, obj_ground)) {
    // Zastaví horizontální pohyb, pokud dojde k nárazu
    if (x_speed > 0) {
        while (place_meeting(x + 1, y, obj_ground)) {
            x -= 1; // Posune hráče zpět, pokud je přilepený
        }
    } else if (x_speed < 0) {
        while (place_meeting(x - 1, y, obj_ground)) {
            x += 1; // Posune hráče zpět, pokud je přilepený
        }
    }
    x_speed = 0; // Zastaví horizontální pohyb
}
