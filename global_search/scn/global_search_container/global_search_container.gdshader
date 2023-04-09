shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap_anisotropic;

uniform float transparency: hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float amount: hint_range(0.0, 5.0, 0.1) = 1.0;

void fragment() {
    vec3 c = textureLod(screen_texture, SCREEN_UV, amount).rgb;
    c.rgb = mix(vec3(0.0), c.rgb, transparency);

    COLOR.rgb = c;
}