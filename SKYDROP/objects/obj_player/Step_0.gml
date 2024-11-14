var on_ground_or_platform = place_meeting(x, y + 1, obj_ground) || 
                            place_meeting(x, y + 1, obj_platform) || 
                            place_meeting(x, y + 1, obj_ground_stone) ||
                            place_meeting(x, y + 1, obj_ground_stonefill);

x_speed = 0;


if (keyboard_check(ord("A"))) {
    x_speed = -2;
    
    image_speed = 0.2;  
    if (on_ground_or_platform) {
        image_index = 5;  
    }
}
else if (keyboard_check(ord("D"))) {
    x_speed = 2;
    
    image_speed = 0.2;  
    if (on_ground_or_platform) {
        image_index = 1;  
    }
}
else {
    image_speed = 0;  
    if (image_index != 9) {  
        image_index = 0;  
    }
}

var on_ground_or_platform = place_meeting(x, y + 1, obj_ground) || 
                            place_meeting(x, y + 1, obj_platform) || 
                            place_meeting(x, y + 1, obj_ground_stone) ||
                            place_meeting(x, y + 1, obj_ground_stonefill);
if ((keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"))) && on_ground_or_platform) {
    y_speed = -8; 
    audio_play_sound(snd_jump, 1, false); 
    image_index = 9;  
    image_speed = 0; 
}

if (on_ground_or_platform && x_speed != 0) {
    image_speed = 0.2; 
} else if (on_ground_or_platform && x_speed == 0) {
    image_index = 0;
    image_speed = 0;
}

y_speed += 0.4;

if (place_meeting(x + x_speed, y, obj_ground) || 
    place_meeting(x + x_speed, y, obj_groundfill) || 
    place_meeting(x + x_speed, y, obj_inviswall) || 
    place_meeting(x + x_speed, y, obj_ground_stone) || 
    place_meeting(x + x_speed, y, obj_ground_stonefill)) {
    
    while (!place_meeting(x + sign(x_speed), y, obj_ground) &&
           !place_meeting(x + sign(x_speed), y, obj_groundfill) &&
           !place_meeting(x + sign(x_speed), y, obj_inviswall) &&
           !place_meeting(x + sign(x_speed), y, obj_ground_stone) &&
           !place_meeting(x + sign(x_speed), y, obj_ground_stonefill)) {
        
        x += sign(x_speed);
    }
    x_speed = 0;
}

var _platform = instance_place(x, y + 1, obj_platform);
if (_platform != noone && y + sprite_height / 2 <= _platform.y) {
    x += _platform.x_speed;
    
    
    if (y_speed > 0) {
        y_speed = 0;
    }
}

if (y_speed > 0 && (place_meeting(x, y + y_speed, obj_ground) || 
                    place_meeting(x, y + y_speed, obj_ground_stone) || 
                    place_meeting(x, y + y_speed, obj_ground_stonefill))) {
    while (!place_meeting(x, y + sign(y_speed), obj_ground) &&
           !place_meeting(x, y + sign(y_speed), obj_ground_stone) &&
           !place_meeting(x, y + sign(y_speed), obj_ground_stonefill)) {
        y += sign(y_speed);
    }
    y_speed = 0;
} else if (y_speed < 0 && (place_meeting(x, y + y_speed, obj_ground) || 
                           place_meeting(x, y + y_speed, obj_ground_stone) || 
                           place_meeting(x, y + y_speed, obj_ground_stonefill))) {
    while (!place_meeting(x, y + sign(y_speed), obj_ground) &&
           !place_meeting(x, y + sign(y_speed), obj_ground_stone) &&
           !place_meeting(x, y + sign(y_speed), obj_ground_stonefill)) {
        y += sign(y_speed);
    }
    y_speed = 0;
}

if (place_meeting(x, y + y_speed, obj_platform)) {
    var _platform_y = instance_place(x, y + y_speed, obj_platform).y;
    if (y_speed < 0 && y > _platform_y) {
        y = _platform_y + sprite_height / 2;
        y_speed = 0;
    } else if (y_speed > 0 && y < _platform_y) {
        while (!place_meeting(x, y + sign(y_speed), obj_ground) && 
               !place_meeting(x, y + sign(y_speed), obj_platform)) {
            y += sign(y_speed);
        }
        y_speed = 0;
    }
}

if (place_meeting(x, y, obj_spike)) {
    room_restart();
}

if (place_meeting(x, y, obj_flag)) {
    room_goto_next();
    audio_play_sound(snd_next_level, 1, false);
}

x += x_speed;
y += y_speed;
