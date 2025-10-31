#!/bin/sh

# --- Define the two shaders you want to swap between ---
SHADER_A="tritone-dof"
SHADER_B="tritone-film-grain"

# Get the name of the currently active shader
CURRENT_SHADER=$(hyprshade current)

# Check which shader is active and toggle to the other
if [ "$CURRENT_SHADER" = "$SHADER_A" ]; then
    # Shader A is on, switch to Shader B
    hyprshade on "$SHADER_B"
elif [ "$CURRENT_SHADER" = "$SHADER_B" ]; then
    # Shader B is on, switch to Shader A
    hyprshade on "$SHADER_A"
else
    # No shader (or a different shader) is on, default to Shader A
    hyprshade on "$SHADER_A"
fi
