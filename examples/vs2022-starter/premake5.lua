dofile("../../premake5.lua")

workspace "VS2022Starter"
  architecture "x64"
  startproject "StarterApp"
  configurations { "Debug", "Release" }
  location "build"

project "StarterApp"
  kind "ConsoleApp"
  language "C++"
  cppdialect "C++20"
  targetdir ("bin/%{cfg.buildcfg}")
  objdir ("bin-int/%{cfg.buildcfg}")
  files { "src/**.h", "src/**.cpp" }
  includedirs { "src" }

  use_sdl3()

  filter "system:windows"
    systemversion "latest"
    defines { "_CRT_SECURE_NO_WARNINGS" }

  filter "configurations:Debug"
    runtime "Debug"
    symbols "On"

  filter "configurations:Release"
    runtime "Release"
    optimize "On"
