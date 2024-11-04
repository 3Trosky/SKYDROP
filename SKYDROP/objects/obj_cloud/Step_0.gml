// Rychlost pohybu mraku
x += -0.05; // Pohyb do leva, čím větší záporná hodnota, tím rychlejší pohyb

// Pokud mrak vyjede za levý okraj okna, přesuň ho zpět napravo
if (x < -sprite_width) {
    x = room_width + sprite_width; // Umístí mrak zpět na pravou stranu
    y = irandom(room_height - sprite_height); // Nastaví náhodnou výšku
}
