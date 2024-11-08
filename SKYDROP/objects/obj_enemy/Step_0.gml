/// @description Insert description here
// You can write your code in this editor

x_speed = dir * spd;
y_speed = y_speed + grv;




//horzintlaní posouvání enemy
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

//vertikální posouvání enemy
if(place_meeting(x,y+y_speed,obj_ground)){
	while(!place_meeting(x,y+sign(y_speed),obj_ground))
	{
		y = y + sign(y_speed);
	}
	y_speed = 0;
	

}	
y = y + y_speed;


//ničení enemy když na ně skočímě v if, v else je když nás hitnou tak se to resetnes
if(place_meeting(x,y,obj_player))
{
	if(obj_player.y<y){
		with(obj_player) y_speed = y_speed -12;
		instance_destroy();
		
		audio_play_sound(snd_player_die,1,false); // Zvuk nižení enemy
	}
	
	
       
	else
	{
		// Respawn hráče na spawn
        with (obj_player) 
        {
          x = 225;
          y = 300;
        }
		 audio_play_sound(snd_ememy_die, 1, false);  
 
       // game_restart();
		
	}
}