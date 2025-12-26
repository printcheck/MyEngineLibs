local SDL3_DIR = "SDL3-3.2.28"
local SDL3_INCLUDE_DIR = SDL3_DIR .. "/include"
local SDL3_LIB_X86 = SDL3_DIR .. "/lib/x86"
local SDL3_LIB_X64 = SDL3_DIR .. "/lib/x64"

local GLFW_WIN32_DIR = "glfw-3.4.bin.WIN32"
local GLFW_WIN64_DIR = "glfw-3.4.bin.WIN64"
local GLFW_INCLUDE_WIN32 = GLFW_WIN32_DIR .. "/include"
local GLFW_INCLUDE_WIN64 = GLFW_WIN64_DIR .. "/include"
local GLFW_DLL_NAME = "glfw3.dll"

local function resolve_glfw_libdir(base)
  local candidates = {
    os.getenv("GLFW_MSVC_LIBDIR"),
    "lib-vc2022",
    "lib-vc2019",
    "lib-vc2017",
    "lib-vc2015",
    "lib-vc2013",
  }

  for _, folder in ipairs(candidates) do
    if folder and folder ~= "" then
      local candidate = base .. "/" .. folder
      if os.isdir(candidate) then
        return folder
      end
    end
  end

  return candidates[2]
end

local GLFW_LIBDIR_WIN64 = resolve_glfw_libdir(GLFW_WIN64_DIR)
local GLFW_LIBDIR_WIN32 = resolve_glfw_libdir(GLFW_WIN32_DIR)

local IMGUI_DIR = "imgui-1.91.4"
local IMGUI_BACKENDS_DIR = IMGUI_DIR .. "/backends"

function use_sdl3()
  includedirs { SDL3_INCLUDE_DIR }

  filter { "system:windows", "platforms:x64" }
    libdirs { SDL3_LIB_X64 }
    links { "SDL3" }
    postbuildcommands { "{COPY} " .. SDL3_LIB_X64 .. "/SDL3.dll %{cfg.targetdir}" }

  filter { "system:windows", "platforms:win32" }
    libdirs { SDL3_LIB_X86 }
    links { "SDL3" }
    postbuildcommands { "{COPY} " .. SDL3_LIB_X86 .. "/SDL3.dll %{cfg.targetdir}" }

  filter {}
end

function use_glfw()
  filter { "system:windows", "platforms:x64" }
    includedirs { GLFW_INCLUDE_WIN64 }
    libdirs { GLFW_WIN64_DIR .. "/" .. GLFW_LIBDIR_WIN64 }
    links { "glfw3dll" }
    defines { "GLFW_DLL" }
    postbuildcommands { "{COPY} " .. GLFW_WIN64_DIR .. "/" .. GLFW_LIBDIR_WIN64 .. "/" .. GLFW_DLL_NAME .. " %{cfg.targetdir}" }

  filter { "system:windows", "platforms:win32" }
    includedirs { GLFW_INCLUDE_WIN32 }
    libdirs { GLFW_WIN32_DIR .. "/" .. GLFW_LIBDIR_WIN32 }
    links { "glfw3dll" }
    defines { "GLFW_DLL" }
    postbuildcommands { "{COPY} " .. GLFW_WIN32_DIR .. "/" .. GLFW_LIBDIR_WIN32 .. "/" .. GLFW_DLL_NAME .. " %{cfg.targetdir}" }

  filter {}
end

function use_imgui_glfw_opengl3(loader_define)
  -- Defaults to GLAD; pass a different loader macro (e.g. IMGUI_IMPL_OPENGL_LOADER_GLEW or IMGUI_IMPL_OPENGL_LOADER_GL3W) if your project uses another OpenGL loader.
  loader_define = loader_define or "IMGUI_IMPL_OPENGL_LOADER_GLAD"

  includedirs { IMGUI_DIR, IMGUI_BACKENDS_DIR }

  files {
    IMGUI_DIR .. "/imgui.cpp",
    IMGUI_DIR .. "/imgui_demo.cpp",
    IMGUI_DIR .. "/imgui_draw.cpp",
    IMGUI_DIR .. "/imgui_tables.cpp",
    IMGUI_DIR .. "/imgui_widgets.cpp",
    IMGUI_BACKENDS_DIR .. "/imgui_impl_glfw.cpp",
    IMGUI_BACKENDS_DIR .. "/imgui_impl_opengl3.cpp"
  }

  defines { loader_define }

  filter "system:windows"
    links { "opengl32" }

  filter {}
end
