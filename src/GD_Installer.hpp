#ifndef GD_INSTALLER_H
#define GD_INSTALLER_H

#include "Godot.hpp"
#include "Node.hpp"

namespace godot {

    class GD_Installer : public Node {
        GODOT_CLASS(GD_Installer, Node);
    public:
        String _source_path;
        String _target_path;
    private:
    public:
        static void _register_methods();
        
        GD_Installer();
        ~GD_Installer();

        void _init();
        void copyDirectory();

    private:
    };


}


#endif // GD_INSTALLER_H