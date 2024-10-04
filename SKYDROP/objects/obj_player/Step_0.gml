x_speed = 0;

if (keyboard_check(ord("A"))) {
    x_speed = -5; 
}
if (keyboard_check(ord("D"))) {
    x_speed = 5; 
}

if (keyboard_check_pressed(vk_space)) {
    if (place_meeting(x, y + 1, obj_ground)) { //kontrola jestli je hrac na zemi
        y_speed = -12; //jak moc skace
    }
}
//JDE SKAKAT ZAROVEN SPACEM A ZAROVEN DVOJTYM W DOBRY NE 
if (keyboard_check_pressed(ord("W"))) {
    if (place_meeting(x, y + 1, obj_ground)) { //kontrola jestli je hrac na zemi
        y_speed = -12; //jak moc skace
    }
}


y_speed += 0.5;  //gravitace

//aby nemohla postava prochazet zdmi
if (place_meeting(x + x_speed, y, obj_ground)) {
    x_speed = 0;
}

//aby se postava nepropadavala
if (place_meeting(x, y + y_speed, obj_ground)) {
    y_speed = 0;
}

// realny pohyb postavy
x += x_speed;
y += y_speed;
