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

## GLFW (Visual Studio 2022)

- Version: **3.4** (Windows binaries)
- Location: `/home/runner/work/MyEngineLibs/MyEngineLibs/glfw-3.4.bin.WIN64` and `/home/runner/work/MyEngineLibs/MyEngineLibs/glfw-3.4.bin.WIN32`
- Contents: headers (`include`), MSVC import/static libraries and DLLs (`lib-vc2022`), MinGW variants, docs, and original `LICENSE.md`.

### Using with the included Premake helper
The root `premake5.lua` exposes a `use_glfw()` helper. Inside any Premake project:

```lua
project "myapp"
  kind "ConsoleApp"
  language "C++"
  use_glfw() -- adds include/lib paths and copies glfw3.dll for x64/Win32
  files { "src/**.cpp", "src/**.h" }
```
By default the helper points at the `lib-vc2022` folders; set `GLFW_MSVC_LIBDIR` (e.g. to `lib-vc2019`) before running Premake if you need a different toolset folder.

### Manual setup in Visual Studio 2022
1. **Include Directory:** add `C:\path\to\MyEngineLibs\glfw-3.4.bin.WIN64\include` (or the WIN32 folder for 32-bit builds).
2. **Library Directory:** choose the matching `lib-vc2022` folder for your architecture (or another `lib-vc####` folder if you target a different MSVC toolset).
3. **Linker → Input → Additional Dependencies:** add `glfw3dll.lib` (or `glfw3.lib` for static linking) and `opengl32.lib` if you use the OpenGL backend.
4. Copy the matching `glfw3.dll` from `lib-vc2022` next to your built executable (or add a post-build copy step).

## Dear ImGui (GLFW + OpenGL3)

- Version: **1.91.4** (source + backends)
- Location: `/home/runner/work/MyEngineLibs/MyEngineLibs/imgui-1.91.4`
- Contents: core Dear ImGui sources, GLFW/OpenGL3 backend sources, documentation, and original `LICENSE.txt`.

### Using with the included Premake helper
The root `premake5.lua` exposes `use_imgui_glfw_opengl3()` to add the core + GLFW/OpenGL3 backend sources and headers. It defaults to the **GLAD** OpenGL loader; pass a different loader macro if needed.

```lua
project "myapp"
  kind "ConsoleApp"
  language "C++"
  use_glfw()
  use_imgui_glfw_opengl3() -- optionally use_imgui_glfw_opengl3("IMGUI_IMPL_OPENGL_LOADER_GLEW")
  files { "src/**.cpp", "src/**.h" }
```

### Manual setup in Visual Studio 2022
1. **Include Directories:** add `C:\path\to\MyEngineLibs\imgui-1.91.4` and `imgui-1.91.4\backends`.
2. **Source Files:** add `imgui.cpp`, `imgui_demo.cpp`, `imgui_draw.cpp`, `imgui_tables.cpp`, `imgui_widgets.cpp`, `backends/imgui_impl_glfw.cpp`, and `backends/imgui_impl_opengl3.cpp`.
3. **Defines:** ensure one OpenGL loader macro is set (default helper uses `IMGUI_IMPL_OPENGL_LOADER_GLAD`; change to `GLEW`, `GL3W`, `GLBINDING*`, or a custom header to match your loader).
4. **Linker → Input → Additional Dependencies:** add `glfw3dll.lib` (or `glfw3.lib` for static), your OpenGL loader library, and `opengl32.lib`.
5. Copy the matching `glfw3.dll` from the GLFW package next to your built executable (or add a post-build copy step).
