#ifndef BUZZ_CONTROLLER_SET_H
#define BUZZ_CONTROLLER_SET_H

#include <hidapi/hidapi.h>
#include "array.h"

class BuzzControllerSet  {

private:
   hid_device *device;
   bool leds[4] = {false, false, false, false};

   bool big_red_button[4] = {false, false, false, false};
   bool blue_button[4]    = {false, false, false, false};
   bool orange_button[4]  = {false, false, false, false};
   bool green_button[4]   = {false, false, false, false};
   bool yellow_button[4]  = {false, false, false, false};

   bool last_big_red_button[4] = {false, false, false, false};
   bool last_blue_button[4]    = {false, false, false, false};
   bool last_orange_button[4]  = {false, false, false, false};
   bool last_green_button[4]   = {false, false, false, false};
   bool last_yellow_button[4]  = {false, false, false, false};

public:
	Array get_buttons_player(int player);
	Array get_buttons_just_pressed_player(int player);
	void set_lights(int bitmask);
	void update_inputs();
	void set_light_player(int player, bool on);
	BuzzControllerSet(hid_device_info *device_info);
	void close();
	int status = -1;
};

#endif
