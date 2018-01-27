#include "register_types.h"
#include "class_db.h"
#include "buzz_controller_manager.h"
#include "engine.h"

BuzzControllerManager *_buzz_controller_manager = NULL;

void register_buzz_controller_manager_types() {
    _buzz_controller_manager = memnew(BuzzControllerManager);
    ClassDB::register_class<BuzzControllerManager>();
    Engine::get_singleton()->add_singleton(Engine::Singleton("BuzzControllerManager",BuzzControllerManager::get_singleton()));
}

void unregister_buzz_controller_manager_types() {
   if (_buzz_controller_manager) memdelete(_buzz_controller_manager);
}

