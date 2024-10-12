x_speed = 0

if (keyboard_check(ord("A"))) {
    x_speed = -5
}
if (keyboard_check(ord("D"))) {
    x_speed = 5
}

if (keyboard_check_pressed(vk_space)) {
    if (place_meeting(x, y + 1, obj_ground)) { //kontrola jestli je hrac na zemi
        y_speed = -12 //jak moc skace
    }
}
//JDE SKAKAT ZAROVEN SPACEM A ZAROVEN DVOJTYM W DOBRY NE 
if (keyboard_check_pressed(ord("W"))) {
    if (place_meeting(x, y + 1, obj_ground)) { //kontrola jestli je hrac na zemi
        y_speed = -12 //jak moc skace
    }
}


y_speed += 0.5  //gravitace

//aby nemohla postava prochazet zdmi
if (place_meeting(x + x_speed, y, obj_ground)) {
    x_speed = 0
}

//aby se postava nepropadavala
if (place_meeting(x, y + y_speed, obj_ground)) {
    y_speed = 0
}
// kdyz spadne z mapy aby se portl na zacatek (zatim jen provizorne) 
if(y > 1000){
		x = 478 
		y = 350
}

//Aby tě skočení na spike vrátilo na začátek
if place_meeting(x,y,obj_spike){
	room_restart()
}

//aby se při dokončeni levelu(dotknutí vlajky), dalo do dalšiho levelu
if place_meeting(x,y,obj_flag){
	room_goto_next()
}


// realny pohyb postavy
x += x_speed;
y += y_speed;
