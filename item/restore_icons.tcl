avl_source_script "\$WIALON_SDK_AJAX_ROOT/common/post.tcl"

# depricated from 2016/02/22
set reader "NULL"
# set reader [$svc_params get_object "poiIcons"]
if {$reader != "NULL"} {
	set keys [$reader get_keys]
	if {$keys != "NULL"} {
		# validate input parameters
		if {![$svc_params validate "{resId: long}"]} {
			set svc_error 4
			return
		}
		set item [avl_get_item [$svc_params get_text "resId"] "ADF_ACL_AVL_RES_EDIT_POI"]
		set pl [adf_cast_i_avl_poi_manager_plugin $item]
		if {$pl == "NULL"} {
			set svc_error 7
			return
		}
		for {set i 0} {$i < [$keys get_count]} {incr i} {
			set key [adf_cast_i_string [$keys get_item_by_pos $i]]
			if {$key == "NULL"} {
				continue
			}
			set id [$key get_value]
			set file_url [$reader get_text $id]
			set img [avl_get_uploaded_image "[get_env_val "AVL_APP_BACKUP_URL"]$file_url"]
			set pl_item [$pl get_poi $id]
			if {$pl_item == "NULL"} {
				continue
			}
			if {[$pl update_poi $pl_item [$pl_item get_name] [$pl_item get_text] [$pl_item get_lat] [$pl_item get_lon] $img [$pl_item get_radius] [$pl_item get_flags] [$pl_item get_color] [$pl_item get_text_color] [$pl_item get_text_size] [$pl_item get_min_scale] [$pl_item get_max_scale]] == 0} {
				continue
			}
		}
	}
}

set reader [$svc_params get_object "zoneIcons"]
if {$reader != "NULL"} {
	set keys [$reader get_keys]
	if {$keys != "NULL"} {
		# validate input parameters
		if {![$svc_params validate "{resId: long}"]} {
			set svc_error 4
			return
		}
		set item [avl_get_item [$svc_params get_text "resId"] "ADF_ACL_AVL_RES_EDIT_ZONES"]
		set pl [adf_cast_i_avl_zones_library_plugin $item]
		if {$pl == "NULL"} {
			set svc_error 7
			return
		}
		for {set i 0} {$i < [$keys get_count]} {incr i} {
			set key [adf_cast_i_string [$keys get_item_by_pos $i]]
			if {$key == "NULL"} {
				continue
			}
			set id [$key get_value]
			set file_url [$reader get_text $id]
			set img [avl_get_uploaded_image "[get_env_val "AVL_APP_BACKUP_URL"]$file_url"]
			set pl_item [$pl get_zone $id]
			if {$pl_item == "NULL"} {
				continue
			}
			set zone_writer [adf_avl_create_geozone_writer [$pl_item get_name] [$pl_item get_description] [$pl_item get_zone_type] [$pl_item get_flags] [$pl_item get_color] [$pl_item get_line_width] [$pl_item get_text_color] [$pl_item get_text_size] [$pl_item get_min_scale] [$pl_item get_max_scale] $img]
			if {$zone_writer == "NULL"} {
				set svc_error 4
				return
			}
			set zone_reader [adf_avl_create_geozone_reader]
			if {$zone_reader == "NULL"} {
				set svc_error 4
				return
			}		
			for {set j 0} {$j < [$pl_item get_point_count]} {incr j} {
				$pl_item get_point_info $j $zone_reader
				$zone_writer add_point [$zone_reader get_lat] [$zone_reader get_lon] [$zone_reader get_radius]
			}
			if {[$pl update_zone $id $zone_writer] == 0} {
				continue
			}
		}
	}
}

set reader [$svc_params get_object "driverIcons"]
if {$reader != "NULL"} {
	set keys [$reader get_keys]
	if {$keys != "NULL"} {
		# validate input parameters
		if {![$svc_params validate "{resId: long}"]} {
			set svc_error 4
			return
		}
		set item [avl_get_item [$svc_params get_text "resId"] "ADF_ACL_AVL_RES_EDIT_DRIVERS"]
		set pl [adf_cast_i_avl_drivers_plugin $item]
		if {$pl == "NULL"} {
			set svc_error 7
			return
		}
		for {set i 0} {$i < [$keys get_count]} {incr i} {
			set key [adf_cast_i_string [$keys get_item_by_pos $i]]
			if {$key == "NULL"} {
				continue
			}
			set id [$key get_value]
			set file_url [$reader get_text $id]
			set img [avl_get_uploaded_image "[get_env_val "AVL_APP_BACKUP_URL"]$file_url"]
			set pl_item [$pl get_driver $id]
			if {$pl_item == "NULL"} {
				continue
			}
			if {[$pl update_driver $pl_item [$pl_item get_name] [$pl_item get_code] [$pl_item get_description] [$pl_item get_phone_number] $img [$pl_item get_flags] [$pl_item get_json_params] [$pl_item get_password]] == 0} {
				continue
			}
		}
	}
}

set reader [$svc_params get_object "trailerIcons"]
if {$reader != "NULL"} {
	set keys [$reader get_keys]
	if {$keys != "NULL"} {
		# validate input parameters
		if {![$svc_params validate "{resId: long}"]} {
			set svc_error 4
			return
		}
		set item [avl_get_item [$svc_params get_text "resId"] "ADF_ACL_AVL_RES_EDIT_TRAILERS"]
		set pl [adf_cast_i_avl_drivers_plugin $item]
		if {$pl == "NULL"} {
			set svc_error 7
			return
		}
		for {set i 0} {$i < [$keys get_count]} {incr i} {
			set key [adf_cast_i_string [$keys get_item_by_pos $i]]
			if {$key == "NULL"} {
				continue
			}
			set id [$key get_value]
			set file_url [$reader get_text $id]
			set img [avl_get_uploaded_image "[get_env_val "AVL_APP_BACKUP_URL"]$file_url"]
			set pl_item [$pl get_trailer $id]
			if {$pl_item == "NULL"} {
				continue
			}
			if {[$pl update_trailer $pl_item [$pl_item get_name] [$pl_item get_code] [$pl_item get_description] $img [$pl_item get_flags] [$pl_item get_json_params]] == 0} {
				continue
			}
		}
	}
}

set reader [$svc_params get_object "unitIcons"]
if {$reader != "NULL"} {
	set keys [$reader get_keys]
	if {$keys != "NULL" && [$keys get_count] > 0} {
		set errors 0
		for {set i 0} {$i < [$keys get_count]} {incr i} {
			set key [adf_cast_i_string [$keys get_item_by_pos $i]]
			if {$key == "NULL"} {
				continue
			}
			set id [$key get_value]
			set file_url [$reader get_text $id]
			set img [avl_get_uploaded_image "[get_env_val "AVL_APP_BACKUP_URL"]$file_url"]
			set item [avl_get_item $id "ADF_ACL_ITEM_EDIT_IMAGE"]
			set pl [adf_cast_i_avl_unit_icon_plugin $item]
			if {$pl == "NULL" && [set pl [adf_cast_i_avl_group_icon_plugin $item]] == "NULL"} {
				incr errors
				continue
			}
			if {[$pl set_icon $img] == 0} {
				continue
			}
		}
		if {$errors >= [$keys get_count]} {
			set svc_error 7
			return
		}
	}
}

set svc_error 0
set svc_result "{}"
