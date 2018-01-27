shader_type canvas_item;

void fragment() {
	COLOR.rgb = vec3(UV, 0);
	//textureLod(SCREEN_TEXTURE,SCREEN_UV,(1.0-vignette_color.r)*4.0).rgb;
	//COLOR.rgb*= texture(vignette,UV).rgb;
}