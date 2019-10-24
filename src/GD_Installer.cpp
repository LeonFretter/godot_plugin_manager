#include "GD_Installer.hpp"
#include <stdlib.h>
#include <string>

using namespace godot;

// static methods

void GD_Installer::_register_methods() {
    //register methods
    register_method("copyDirectory", &GD_Installer::copyDirectory);

    //register properties
    register_property<GD_Installer, String>("source_path", &GD_Installer::_source_path, String("source-path"));
    register_property<GD_Installer, String>("target_path", &GD_Installer::_target_path, String("target-path"));
}

// constructors and destructors

GD_Installer::GD_Installer() {}

GD_Installer::~GD_Installer() {}

// public methods

void GD_Installer::_init() {
    _source_path = String("source-path");
    _target_path = String("target-path");

}

void GD_Installer::copyDirectory() {
    const char* source = _source_path.alloc_c_string();
    const char* target = _target_path.alloc_c_string();

    std::string command;
    command.append("cp -rT ");
    command.append(source);
    command.append(" ");
    command.append(target);

    Godot::print(command.c_str());

    system(command.c_str());
}

// private methods