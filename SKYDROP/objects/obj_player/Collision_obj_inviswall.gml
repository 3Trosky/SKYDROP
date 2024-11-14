if (x_speed != 0) {
    while (!place_meeting(x + sign(x_speed), y, obj_inviswall)) {
        x += sign(x_speed);
    }
    x_speed = 0; 
}

if (y_speed != 0) {
    
    while (!place_meeting(x, y + sign(y_speed), obj_inviswall)) {
        y += sign(y_speed);
    }
    y_speed = 0; 
}
