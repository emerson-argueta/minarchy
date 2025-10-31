// DEPTH OF FIELD + TRITONE + FILM GRAIN
// Applies focus blur, then tritone color, then film grain.
// Use with: hyprshade on dof-tritone-grain

#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
uniform float time;
out vec4 fragColor;

// --- Helper functions from film-grain.glsl ---

float hash(vec2 p) {
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
    // 1. Get the original color at this pixel
    vec4 originalColor = texture(tex, v_texcoord);

    // --- 1. DEPTH OF FIELD LOGIC ---
    // This must be calculated first, using the original texture 'tex'.

    // Define focus area (center of screen is in focus)
    vec2 center = vec2(0.5, 0.5);
    float distFromCenter = length(v_texcoord - center);

    // Focus range - center is sharp, edges are blurred
    float focusStart = 0.15; // Sharp up to this distance
    float focusEnd = 0.6;   // Fully blurred at this distance

    // Calculate blur amount based on distance
    float blurAmount = smoothstep(focusStart, focusEnd, distFromCenter);

    // Start with the sharp original color
    vec4 dofColor = originalColor;

    // Apply blur based on distance
    if (blurAmount > 0.01) {
        vec4 blurred = vec4(0.0);
        float total = 0.0;

        // Blur kernel size increases with distance
        float blurRadius = blurAmount * 3.0;

        for(float x = -3.0; x <= 3.0; x++) {
            for(float y = -3.0; y <= 3.0; y++) {
                vec2 offset = vec2(x, y) * 0.002 * blurRadius;
                float weight = 1.0 - length(vec2(x, y)) / 5.0;
                
                // Sample the *original* texture at neighbors
                blurred += texture(tex, clamp(v_texcoord + offset, 0.0, 1.0)) * weight;
                total += weight;
            }
        }
        blurred /= total;

        // Mix sharp and blurred based on distance
        dofColor = mix(originalColor, blurred, blurAmount);
    }

    // --- 2. TRITONE LOGIC ---
    // Now, apply tritone to the "focused" (dofColor) image

    // Convert focused color to grayscale
    float gray = dot(dofColor.rgb, vec3(0.299, 0.587, 0.114));

    // Map to three colors
    vec3 shadowColor = vec3(0.1, 0.05, 0.2);    // Dark purple
    vec3 midtoneColor = vec3(0.6, 0.4, 0.5);   // Mauve
    vec3 highlightColor = vec3(1.0, 0.9, 0.7); // Cream

    vec3 tritone;
    if (gray < 0.5) {
        tritone = mix(shadowColor, midtoneColor, gray * 2.0);
    } else {
        tritone = mix(midtoneColor, highlightColor, (gray - 0.5) * 2.0);
    }

    // This is our new base color
    vec4 color = vec4(tritone, dofColor.a);

    // --- 3. FILM GRAIN & FINAL TOUCHES ---
    // Apply grain, vignette, and contrast to the final tritone color

    // Generate grain
    float grain = filmGrain(v_texcoord, time);
    float grainAmount = (grain - 0.5) * 0.12;
    color.rgb += vec3(grainAmount);

    // Single vignette (from film-grain / depth-of-field)
    vec2 uv = v_texcoord * 2.0 - 1.0;
    float vignette = 1.0 - dot(uv, uv) * 0.15;
    color.rgb *= vignette;

    // Contrast boost (from film-grain)
    color.rgb = pow(color.rgb, vec3(0.95));

    // Focus pulse (from depth-of-field)
    float focusPulse = sin(time * 0.5) * 0.05;
    color.rgb *= 1.0 + focusPulse * (1.0 - blurAmount);

    // --- Final Output ---
    fragColor = color;
}
