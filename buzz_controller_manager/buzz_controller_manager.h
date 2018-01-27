#ifndef BUZZ_CONTROLLER_MANAGER_H
#define BUZZ_CONTROLLER_MANAGER_H

#include "object.h"
#include <hidapi/hidapi.h>
#include "buzz_controller_set.h"
#include <vector>
#include "array.h"

class BuzzControllerManager : public Object {
    GDCLASS(BuzzControllerManager, Object);

    static BuzzControllerManager* singleton;
protected:
    static void _bind_methods();
    std::vector<BuzzControllerSet> connected_sets;

public:
	static BuzzControllerManager *get_singleton();
    
    BuzzControllerManager();
    ~BuzzControllerManager();

	void init();
	void find_controllers();
	
	void _process();
	void set_lights(int bitmask);
	void set_light_player(int player, bool on);

	void update_inputs();
	Array get_buttons_player(int player);

	int get_num_players();


};

#endif
