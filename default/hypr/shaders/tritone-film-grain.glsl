// TRITONE + FILM GRAIN
// Applies a tritone color map and then adds film grain, vignette, and contrast.
// Use with: hyprshade on tritone-grain

#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
uniform float time;
out vec4 fragColor;

// --- Helper functions from film-grain.glsl ---

float hash(vec2 p) {
    // This is the corrected line
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

// Film grain noise
float filmGrain(vec2 uv, float time) {
    // Animated grain
    vec2 grainUV = uv * 1000.0 + time * 50.0;
    float noise = hash(grainUV);

    // Multiple layers for more organic grain
    noise += hash(grainUV * 2.0) * 0.5;
    noise += hash(grainUV * 4.0) * 0.25;

    return noise / 1.75;
}

// --- Main execution ---

void main() {
    // 1. Sample the original texture
    vec4 originalColor = texture(tex, v_texcoord);

    // --- Logic from tritone.glsl ---
    
    // 2. Convert to grayscale
    float gray = dot(originalColor.rgb, vec3(0.299, 0.587, 0.114));

    // 3. Map to three colors
    vec3 shadowColor = vec3(0.1, 0.05, 0.2);    // Dark purple
    vec3 midtoneColor = vec3(0.6, 0.4, 0.5);   // Mauve
    vec3 highlightColor = vec3(1.0, 0.9, 0.7); // Cream

    vec3 tritone;
    if (gray < 0.5) {
        // Blend between shadow and midtone
        tritone = mix(shadowColor, midtoneColor, gray * 2.0);
    } else {
        // Blend between midtone and highlight
        tritone = mix(midtoneColor, highlightColor, (gray - 0.5) * 2.0);
    }

    // 4. Create the new base color from the tritone result
    vec4 color = vec4(tritone, originalColor.a);

    // --- Logic from film-grain.glsl ---

    // 5. Generate grain
    float grain = filmGrain(v_texcoord, time);

    // 6. Apply grain (centered around 0)
    float grainAmount = (grain - 0.5) * 0.12;
    color.rgb += vec3(grainAmount);

    // 7. Slight vignette for cinematic feel
    vec2 uv = v_texcoord * 2.0 - 1.0;
    float vignette = 1.0 - dot(uv, uv) * 0.15;
    color.rgb *= vignette;

    // 8. Slight contrast boost
    color.rgb = pow(color.rgb, vec3(0.95));

    // --- Final Output ---
    fragColor = color;
}
