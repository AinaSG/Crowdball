#include "buzz_controller_manager.h"
#include "print_string.h"

BuzzControllerManager *BuzzControllerManager::singleton = NULL;

BuzzControllerManager *BuzzControllerManager::get_singleton() {
	return singleton;
}

BuzzControllerManager::BuzzControllerManager() {
	singleton = this;
}

BuzzControllerManager::~BuzzControllerManager() {
	print_line("[[Deleting BuzzControllerManager]]");
}

void BuzzControllerManager::_bind_methods() {
    ClassDB::bind_method(D_METHOD("find_controllers"), &BuzzControllerManager::find_controllers);
    ClassDB::bind_method(D_METHOD("set_lights", "bitmask"), &BuzzControllerManager::set_lights);   
	ClassDB::bind_method(D_METHOD("set_light_player", "player", "on"), &BuzzControllerManager::set_light_player);
	ClassDB::bind_method(D_METHOD("get_buttons_player", "player"), &BuzzControllerManager::get_buttons_player);  
    ClassDB::bind_method(D_METHOD("update_inputs"), &BuzzControllerManager::update_inputs);
    ClassDB::bind_method(D_METHOD("init"), &BuzzControllerManager::init);
    ClassDB::bind_method(D_METHOD("get_num_players"), &BuzzControllerManager::get_num_players);
}

void BuzzControllerManager::init() {
	hid_init();
	find_controllers();
}

void BuzzControllerManager::find_controllers() {
	print_line("[[Finding controllers...]]");
	for (auto& set : connected_sets) {
		set.close();
	}

	connected_sets = std::vector<BuzzControllerSet>();
	
	hid_device_info *devices = hid_enumerate(0x054c,0x0002);
	
	while (devices != nullptr)
	{
		BuzzControllerSet set(devices);
		if (set.status == 0)
		{
			connected_sets.push_back(set);
		}
		devices = devices->next;
	}
}

int BuzzControllerManager::get_num_players() {
	return connected_sets.size() * 4;
}

void BuzzControllerManager::set_lights(int bitmask){
	for (auto& set : connected_sets){
		set.set_lights(bitmask);
		bitmask = bitmask >> 4;
	}
}

void BuzzControllerManager::update_inputs(){
	for (auto& set: connected_sets){
		set.update_inputs();
	}
}

void BuzzControllerManager::set_light_player(int player, bool on){
	int set = player / 4;
	int player_in_set = player%4;
	
	if (set >= connected_sets.size()) {
		print_line("[set_light_player] Player index too high.");
		return;
	}
	
	connected_sets[set].set_light_player(player_in_set, on);
}

Array BuzzControllerManager::get_buttons_player(int player){
	int set = player / 4;
	int player_in_set = player%4;

	if (set >= connected_sets.size()) {
		print_line("[get_buttons_player] Player index too high.");
		return Array();
	}

	return connected_sets[set].get_buttons_player(player_in_set);
}