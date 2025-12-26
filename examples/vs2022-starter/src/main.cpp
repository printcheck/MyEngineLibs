#include <SDL3/SDL.h>
#include <cstdio>

int main(int /*argc*/, char** /*argv*/) {
    if (SDL_Init(SDL_INIT_VIDEO) != 0) {
        SDL_Log("Failed to init SDL3: %s", SDL_GetError());
        return 1;
    }

    SDL_Window* window = SDL_CreateWindow("MyEngineLibs Starter", 800, 600, SDL_WINDOW_OPENGL);
    if (!window) {
        SDL_Log("Failed to create window: %s", SDL_GetError());
        SDL_Quit();
        return 1;
    }

    SDL_Delay(1000);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}
