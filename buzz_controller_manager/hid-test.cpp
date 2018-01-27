#include <stdio.h>
#include <string.h>
#include <hidapi/hidapi.h>
#include <bitset>
#include <iostream>
#include <unistd.h>
#include <stdlib.h>

#define MSG_NONE		0x00
#define MSG_DOWN		0x01
#define MSG_UP			0x02
#define MSG_LEFT		0x04
#define MSG_RIGHT		0x08
#define MSG_FIRE		0x10
#define MSG_STOP		0x20
#define MSG_STATUS		0x40
#define MAX_STR 255

using namespace std;


void print_info(hid_device *handle)
{
	int res;
	wchar_t wstr[MAX_STR];

	// Read the Manufacturer String
	wstr[0] = 0x0000;
	res = hid_get_manufacturer_string(handle, wstr, MAX_STR);
	if (res < 0)
		printf("Unable to read manufacturer string\n");
	printf("Manufacturer String: %ls\n", wstr);

	// Read the Product String
	wstr[0] = 0x0000;
	res = hid_get_product_string(handle, wstr, MAX_STR);
	if (res < 0)
		printf("Unable to read product string\n");
	printf("Product String: %ls\n", wstr);

	// Read Indexed String 1
	wstr[0] = 0x0000;
	res = hid_get_indexed_string(handle, 1, wstr, MAX_STR);
	if (res < 0)
		printf("Unable to read indexed string 1\n");
	printf("Indexed String 1: %ls\n", wstr);
}

void set_lights(hid_device *handle, unsigned char v)
{
	unsigned char buf[7];
	buf[0] = 0x00;
	buf[1] = 0x00; // 0x00
	buf[2] = (v >> 0) & 0x01; // buzz1
	buf[3] = (v >> 1) & 0x01; // buzz1
	buf[4] = (v >> 2) & 0x01; // buzz1
	buf[5] = (v >> 3) & 0x01; // buzz1
	buf[6] = 0x00;
	int res = hid_write(handle, buf, 7);
	if (res < 0) {
		printf("Unable to write()\n");
		printf("Error: %ls\n", hid_error(handle));
	}
}

int main(int argc, char* argv[])
{
	
	unsigned char buf[256];
	int res;
	hid_device *handle;
	hid_device_info *devices;

	devices = hid_enumerate(0x054c, 0x0002);

	if (devices == NULL) exit(1);
	
	cout << "asd" << endl;
	//printf("%s\n", devices->serial_number);
	cout << devices->serial_number << " asd" << endl;

    handle = hid_open(0x054c, 0x0002, devices->serial_number);
	if (!handle) {
		printf("unable to open device\n");
 		return 1;
	}


	print_info(handle);

	
	// write lights
	unsigned int microseconds = 100000;
	unsigned char v = 0x01;
	while(true) 
	{
		set_lights(handle, v);	
		usleep(microseconds);
		v <<= 1;
		if (v > 8) v = 0x01;
	}
	

	/*hid_set_nonblocking(handle, 1);

	int cc = 0;
	while(true) 
	{
		cout << cc++ << " -> ";
		res = hid_read(handle,buf,8);
		//if (res > 0)
		{
			for (int i = 0; i < 8; ++i) cout << bitset<8>(buf[i]) << "|";
			cout << endl;
		}
	}
*

	hid_close(handle);*/

	hid_exit();
	return 0;
}