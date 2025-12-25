workspace "glfw-ws"
  configurations { "Debug", "Release" }
  platforms { "win32", "x64" }
  location "build"

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
