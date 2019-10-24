#! usr/bin/env python3
import os, subprocess
from pathlib import Path

opts = Variables([], ARGUMENTS)

source_environments = ['src/']
source_search = 'src/**.cpp'
target_path = 'bin/'
output_name = 'world_data'

# Gets the standard flags CC, CCX, etc.
env = DefaultEnvironment()

# Define our options
opts.Add(EnumVariable('target', "Compilation target", 'debug', ['d', 'debug', 'r', 'release']))
opts.Add(EnumVariable('platform', "Compilation platform", '', ['', 'windows', 'x11', 'linux', 'osx']))
opts.Add(EnumVariable('p', "Compilation target, alias for 'platform'", '', ['', 'windows', 'x11', 'linux', 'osx']))
opts.Add(BoolVariable('use_llvm', "Use the LLVM / Clang compiler", 'no'))
opts.Add(PathVariable('target_path', 'The path where the lib is installed.', target_path))
opts.Add(PathVariable('target_name', 'The library name.', output_name, PathVariable.PathAccept))

# Local dependency paths, adapt them to your setup
godot_headers_path = "godot-cpp/godot_headers/"
cpp_bindings_path = "godot-cpp/"
cpp_library = "libgodot-cpp"

bits = 64

opts.Update(env)

env['target_path'] += 'x11/'
cpp_library += '.linux'
if env['target'] in ('debug', 'd'):
    env.Append(CCFLAGS=['-fPIC', '-g3', '-Og'])
    env.Append(CXXFLAGS=['-std=c++17'])
else:
    env.Append(CCFLAGS=['-fPIC', '-g', '-O3'])
    env.Append(CXXFLAGS=['-std=c++17'])

if env['target'] in ('debug', 'd'):
    cpp_library += '.debug'
else:
    cpp_library += '.release'

cpp_library += '.' + str(bits)

# make sure our binding library is properly includes
env.Append(CPPPATH=['.', godot_headers_path, cpp_bindings_path + 'include/', cpp_bindings_path + 'include/core/', cpp_bindings_path + 'include/gen/'])
env.Append(LIBPATH=[cpp_bindings_path + 'bin/'])
env.Append(LIBS=[cpp_library])

# source-folders
env.Append(CPPPATH=source_environments)

# for filename in Path('src')

folders = []
sources = []

for root, subdirs, files in os.walk('src'):
    print('path: ' + root+'/')
    new_sources = Glob(root+'/*.cpp')
    sources += new_sources

source_files = Path('src').glob('**/*.cpp')

for source in sources:
    print('\n\n ' + source.rstr() + '\n\n')

library = env.SharedLibrary(target=env['target_path'] + env['target_name'] , source=sources)

Default(library)

# Generates help for the -h scons option.
Help(opts.GenerateHelpText(env))
