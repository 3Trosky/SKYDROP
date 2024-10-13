/// @description Insert description here
// You can write your code in this editor

x_speed = dir * spd;

if(place_meeting(x+x_speed,y,obj_ground)){
	while(!place_meeting(x+sign(x_speed),y,obj_ground))
	{
		x = x + sign(x_speed);
	}
	//odraženi aby bezel na druhou stranu
	dir = dir*-1;
	
	
	x_speed = 0;
}
x = x + x_speed;
