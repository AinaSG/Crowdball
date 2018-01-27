#include "buzz_controller_set.h"
#include "print_string.h"
#include <iostream>
#include <stdlib.h>
#include "variant.h"


BuzzControllerSet::BuzzControllerSet(hid_device_info *device_info)
{
	device = hid_open_path(device_info->path);

	char buf[256];
	sprintf(buf, "device: %d", device);
	print_line(buf);

	sprintf(buf, "%d", device_info->vendor_id);
	print_line(buf);

	sprintf(buf, "%d", device_info->product_id);
	print_line(buf);

	sprintf(buf, "%d", device_info->serial_number);
	print_line(buf);
	if (!device) 
	{
		print_line("[ERROR]");
	}
	else 
	{
		print_line("[SUCCESS]");
		status = 0;
		hid_set_nonblocking(device, 1);
	}
}

void BuzzControllerSet::close(){
	hid_close(device);
}

void BuzzControllerSet::set_lights(int bitmask)
{
	unsigned char buf[7];
	buf[0] = 0x00;
	buf[1] = 0x00; // 0x00
	buf[2] = (bitmask >> 0) & 0x01; // buzz1
	buf[3] = (bitmask >> 1) & 0x01; // buzz1
	buf[4] = (bitmask >> 2) & 0x01; // buzz1
	buf[5] = (bitmask >> 3) & 0x01; // buzz1
	buf[6] = 0x00;
	int res = hid_write(device, buf, 7);
	if (res < 0) {
		printf("Unable to write()\n");
		printf("Error: %ls\n", hid_error(device));
	}
}

void BuzzControllerSet::set_light_player(int player, bool on){
	if(player >= 0 and player <=3){
		leds[player] = on;
		unsigned char buf[7];
		buf[0] = 0x00;
		buf[1] = 0x00; // 0x00
		buf[2] = (leds[0]) & 0x01; // buzz1
		buf[3] = (leds[1]) & 0x01; // buzz1
		buf[4] = (leds[2]) & 0x01; // buzz1
		buf[5] = (leds[3]) & 0x01; // buzz1
		buf[6] = 0x00;


		int res = hid_write(device, buf, 7);
		if (res < 0) {
			printf("Unable to write()\n");
			printf("Error: %ls\n", hid_error(device));
		}
	}

}

void BuzzControllerSet::update_inputs(){
	unsigned char buf[5]; 
	int res = hid_read(device, buf, 5); // 0 si res, n segons el numero de bytes llegits(8)
	if (res==0){
		return;
	}
	if (res == -1){
		print_line("[UPDATE_INPUT ERROR]");
		return;
	}

	big_red_button[0] = (buf[2]>>0) & 1;
	big_red_button[1] = (buf[2]>>5) & 1;
	big_red_button[2] = (buf[3]>>2) & 1;
	big_red_button[3] = (buf[3]>>7) & 1;

	blue_button[0]    = (buf[2]>>4) & 1;
	blue_button[1]    = (buf[3]>>1) & 1;
	blue_button[2]    = (buf[3]>>6) & 1;
	blue_button[3]    = (buf[4]>>3) & 1;

	orange_button[0]  = (buf[2]>>3) & 1;
	orange_button[1]  = (buf[3]>>0) & 1;
	orange_button[2]  = (buf[3]>>5) & 1;
	orange_button[3]  = (buf[4]>>2) & 1;

	green_button[0]   = (buf[2]>>2) & 1;
	green_button[1]   = (buf[2]>>7) & 1;
	green_button[2]   = (buf[3]>>4) & 1;
	green_button[3]   = (buf[4]>>1) & 1;

	yellow_button[0]  = (buf[2]>>1) & 1;
	yellow_button[1]  = (buf[2]>>6) & 1;
	yellow_button[2]  = (buf[3]>>3) & 1;
	yellow_button[3]  = (buf[4]>>0) & 1;

	//big_red_button = {buf[2]>>0&1, buf[2]>>5&1, buf[3]>>2&1, buf[3]>>7&1};
	//blue_button    = {buf[2]>>4&1, buf[3]>>1&1, buf[3]>>6&1, buf[4]>>3&1};
	//orange_button  = {buf[2]>>3&1, buf[3]>>0&1, buf[3]>>5&1, buf[4]>>2&1};
	//green_button   = {buf[2]>>2&1, buf[2]>>7&1, buf[3]>>4&1, buf[4]>>1&1};
	//yellow_button  = {buf[2]>>1&1, buf[2]>>6&1, buf[3]>>3&1, buf[4]>>0&1};
}

Array BuzzControllerSet::get_buttons_player(int player){
	Array return_values;
	return_values.push_back(Variant(big_red_button[player]));
	return_values.push_back(Variant(blue_button[player]));
	return_values.push_back(Variant(orange_button[player]));
	return_values.push_back(Variant(green_button[player]));
	return_values.push_back(Variant(yellow_button[player]));

	return return_values;
}
