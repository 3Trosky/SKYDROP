x_speed = dir * spd;


if (place_meeting(x + x_speed, y, obj_ground) || 
    place_meeting(x + x_speed, y, obj_ground_stonefill) || 
    place_meeting(x + x_speed, y, obj_ground_stone)) 
{
    
    while (place_meeting(x + sign(x_speed), y, obj_ground) ||
           place_meeting(x + sign(x_speed), y, obj_ground_stonefill) || 
           place_meeting(x + sign(x_speed), y, obj_ground_stone))
    {
        x = x - sign(x_speed);
    }
    
    dir = dir * -1;
    x_speed = 0;
}

x = x + x_speed;
