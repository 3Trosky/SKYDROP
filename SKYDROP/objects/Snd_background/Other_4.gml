/// @description Insert description here
// You can write your code in this editor
// Kontrola, zda jsme v hlavním menu
if (room == rm_menu || room == rm_Zending_screen) {
    // Pokud jsme v menu, zastavíme hudbu, pokud stále hraje
    if (audio_is_playing(snd_background)) {
        audio_stop_sound(snd_background);
    }
} else {
    // Pokud nejsme v menu, spustíme hudbu (s kontrolou, aby neběžela dvakrát)
    if (!audio_is_playing(snd_background)) {
        audio_play_sound(snd_background, 1, true); // Spuštění hudby s loopem
    }
}