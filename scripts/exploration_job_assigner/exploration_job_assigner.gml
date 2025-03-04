// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function exploration_job_assigner(){
	var _soldiers = ds_list_size(global.peasant_list[jobs.soldier]);
	for (var i = 0; i<2 ;i++) {
		exploration_cooldown[i] = max(exploration_cooldown[i]-1,0);
		if exploration_active[i] {
			exploration_progress[i]+=units_exploring[i]/2;
			
			if exploration_progress[i]>=exploration_progress_target {
				exploration_active[i] = false;
				if i == explore.left_side {
					min_camera_chunk = max(min_camera_chunk-exploration_chunk_reward,0);
					}
				else {
					max_camera_chunk = min(max_camera_chunk+exploration_chunk_reward,global.world.size);
					}
				exploration_progress[i] = 0;
				exploration_cooldown[i] = exploration_wait_value;
				//units_going_to_explore[i] = 0;
				//units_exploring[i] = 0;
				break;
				}
			if units_going_to_explore[i] < 2 {
				var _free_soldier = noone;
				var _min_distance = 999999;
				for (var j = 0; j<_soldiers;j++) {
					var _soldier = global.peasant_list[jobs.soldier][|j];
					if _soldier.state == wander and abs(x-_soldier.x)<_min_distance {
						_free_soldier = _soldier;
						_min_distance = abs(x-_soldier.x);
						}
					}
				if _free_soldier != noone {
					show_debug_message("adding instance: "+string(_free_soldier));
					
					_free_soldier.check_state = exploration_is_active;
					_free_soldier.state = move_to_pos;
					_free_soldier.next_state = explore_new_land;
					_free_soldier.on_finish_state = start_exploring;
					_free_soldier.cancel_state = cancel_exploration;
					
					_free_soldier.target_instance = noone;
					_free_soldier.target_side = i;
					if i == explore.left_side {
						_free_soldier.target_x = (min_camera_chunk-2)*64;
						}
					else {
						_free_soldier.target_x = (max_camera_chunk+2)*64;
						}
					
					units_going_to_explore[i]++;
					}
				}
			}
		}
	}
