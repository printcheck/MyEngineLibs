# MyEngineLibs

Pre-packaged third-party binaries to drop into Windows/Visual Studio projects.

## SDL3 (Visual Studio 2022)

- Version: **3.2.28** (developer package)
- Location: `/home/runner/work/MyEngineLibs/MyEngineLibs/SDL3-3.2.28`
- Contents: headers (`include`), x64/x86 libs and DLLs (`lib/x64`, `lib/x86`), CMake config files (`cmake`), and original `LICENSE.txt`.

### Using with the included Premake helper
The root `premake5.lua` now exposes a `use_sdl3()` helper. Inside any project:

```lua
project "myapp"
  kind "ConsoleApp"
  language "C++"
  use_sdl3() -- adds include/lib paths and copies SDL3.dll for x64/Win32
  files { "src/**.cpp", "src/**.h" }
```

### Manual setup in Visual Studio 2022
1. **Include Directory:** add `C:\path\to\MyEngineLibs\SDL3-3.2.28\include`.
2. **Library Directory:** choose `C:\path\to\MyEngineLibs\SDL3-3.2.28\lib\x64` (or `lib\x86` for Win32).
3. **Linker → Input → Additional Dependencies:** add `SDL3.lib` (and `SDL3_test.lib` if you need the test helpers).
4. Copy the matching `SDL3.dll` from `lib\x64` or `lib\x86` next to your built executable (or add a post-build copy step).
5. For CMake users, `SDL3-3.2.28/cmake` contains the `SDL3Config.cmake` files for `find_package(SDL3 CONFIG REQUIRED)`.
