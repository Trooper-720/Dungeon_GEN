/// @description Destroy self and update amount of coins
global.coins++;
audio_play_sound(sn_coinPickup, 100, false);
instance_destroy(self);