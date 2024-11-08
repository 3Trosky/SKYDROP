// Zajištění těsné kolize s neviditelnou stěnou
if (x_speed != 0) {
    // Horizontální pohyb - posun až ke stěně
    while (!place_meeting(x + sign(x_speed), y, obj_inviswall)) {
        x += sign(x_speed);
    }
    x_speed = 0; // Zastavení horizontální rychlosti při kolizi
}

if (y_speed != 0) {
    // Vertikální pohyb - posun až ke stěně
    while (!place_meeting(x, y + sign(y_speed), obj_inviswall)) {
        y += sign(y_speed);
    }
    y_speed = 0; // Zastavení vertikální rychlosti při kolizi
}
