workspace "glfw-ws"
  configurations { "Debug", "Release" }
  platforms { "win32", "x64" }
  location "build"

local SDL3_DIR = "SDL3-3.2.28"
local SDL3_INCLUDE_DIR = SDL3_DIR .. "/include"
local SDL3_LIB_X86 = SDL3_DIR .. "/lib/x86"
local SDL3_LIB_X64 = SDL3_DIR .. "/lib/x64"

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

project "glfw"
  kind "StaticLib"
  language "C"
  targetdir "build/lib/%{cfg.buildcfg}"
  files { "glfw/include/**.h", "glfw/src/**.c" }
  includedirs { "glfw/include" }
  defines { "_GLFW_USE_CONFIG_H" }
  filter "system:windows"
    links { "opengl32", "gdi32", "user32", "kernel32" }
  filter "configurations:Debug"
    symbols "On"
  filter "configurations:Release"
    optimize "On"

project "glfwW"
  kind "ConsoleApp"
  language "C++"
  targetdir "bin/%{cfg.buildcfg}"
  
  files { 
      "glfwW/**.h", 
      "glfwW/**.cpp"
  }
  
  includedirs { 
      "../../mylibaries/glfw-3.4.bin.WIN32/glfw-3.4.bin.WIN32/include"
  }
  
  libdirs { 
      "../../mylibaries/glfw-3.4.bin.WIN32/glfw-3.4.bin.WIN32/lib-vc2022"
  }
  
  links { 
      "glfw3",
      "opengl32"
  }
  
  filter "configurations:Debug"
    defines { "DEBUG" }
    symbols "On"
  
  filter "configurations:Release"
    defines { "NDEBUG" }
    optimize "On"
