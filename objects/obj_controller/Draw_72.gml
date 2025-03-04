/// @description Clear app surf last frame
// You can write your code in this editor


if !surface_exists(surf_entities) {
	surf_entities = surface_create(global.w+1,global.h);
	}	
else {
	surface_set_target(surf_entities);
	camera_apply(camera);
	draw_clear_alpha(c_black,0);
	surface_reset_target()
	}		
	
if !surface_exists(surf_water) {
	surf_water = surface_create(global.w+256,global.h);
	}	
	
if !surface_exists(surf_shaded_entities) {
	surf_shaded_entities = surface_create(global.w+1,global.h);
	}	
	
if !surface_exists(surf_rendered_water) {
	surf_rendered_water = surface_create(global.w+256,global.h);
	}	
