if (room == rm_menu || room == rm_Zending_screen) {
   
    if (audio_is_playing(snd_background)) {
        audio_stop_sound(snd_background);
    }
} else {
    
    if (!audio_is_playing(snd_background)) {
        audio_play_sound(snd_background, 1, true); 
    }
}