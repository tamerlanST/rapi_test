# validate input parameters
if {![$svc_params validate "{itemId: long, fileId: uint}"]} {
	set svc_error 4
	return
}

set superclass [avl_get_item_superclass [$svc_params get_text "itemId"]]
set item "NULL"
if {$superclass == "avl_unit" || $superclass == "avl_unit_group"} {
	# fetch item with desired ACL
	set item [avl_get_item [$svc_params get_text "itemId"] "ADF_ACL_ITEM_DELETE,ADF_ACL_ITEM_EDIT_AFIELDS,ADF_ACL_ITEM_EDIT_CFIELDS,ADF_ACL_ITEM_EDIT_FILE,ADF_ACL_ITEM_EDIT_IMAGE,ADF_ACL_ITEM_EDIT_NAME,ADF_ACL_ITEM_EDIT_OTHER,ADF_ACL_AVL_UNIT_EDIT_CMD_ALIASES,ADF_ACL_AVL_UNIT_EDIT_COUNTERS,ADF_ACL_AVL_UNIT_EDIT_HW,ADF_ACL_AVL_UNIT_REG_EVENTS,ADF_ACL_AVL_UNIT_EDIT_REPORT_SETTINGS,ADF_ACL_AVL_UNIT_EDIT_SENSORS,ADF_ACL_AVL_UNIT_EDIT_MAINTENANCE"]
} elseif {$superclass == "avl_resource"} {
	# fetch item with desired ACL
	set item [avl_get_item [$svc_params get_text "itemId"] "ADF_ACL_ITEM_DELETE,ADF_ACL_ITEM_EDIT_FILE,ADF_ACL_AVL_RES_EDIT_DRIVERS,ADF_ACL_AVL_RES_EDIT_JOBS,ADF_ACL_AVL_RES_EDIT_NF,ADF_ACL_AVL_RES_EDIT_POI,ADF_ACL_AVL_RES_EDIT_REPORTS,ADF_ACL_AVL_RES_EDIT_TRAILERS,ADF_ACL_AVL_RES_EDIT_ZONES"]
} elseif {$superclass == "user"} {
	# fetch item with desired ACL
	set item [avl_get_item [$svc_params get_text "itemId"] "ADF_ACL_ITEM_DELETE,ADF_ACL_USER_SET_ITEMS_ACCESS,ADF_ACL_USER_OPERATE_AS,ADF_ACL_USER_EDIT_FLAGS"]
} elseif {$superclass == "avl_route"} {
	# fetch item with desired ACL
	set item [avl_get_item [$svc_params get_text "itemId"] "ADF_ACL_ITEM_DELETE,ADF_ACL_AVL_ROUTE_EDIT_SETTINGS"]
} elseif {$superclass == "avl_retranslator"} {
	# fetch item with desired ACL
	set item [avl_get_item [$svc_params get_text "itemId"] "ADF_ACL_ITEM_DELETE,ADF_ACL_AVL_RETR_EDIT_SETTINGS,ADF_ACL_AVL_RETR_EDIT_UNITS"]
} else {
	set item [avl_get_item [$svc_params get_text "itemId"] "ADF_ACL_ITEM_DELETE,ADF_ACL_ITEM_EDIT_NAME,ADF_ACL_ITEM_EDIT_CFIELDS,ADF_ACL_ITEM_EDIT_OTHER,ADF_ACL_ITEM_EDIT_SUB_ITEMS,ADF_ACL_ITEM_EDIT_AFIELDS,ADF_ACL_ITEM_EDIT_FILE,ADF_ACL_AVL_UNIT_EDIT_HW,ADF_ACL_AVL_UNIT_EDIT_SENSORS,ADF_ACL_AVL_UNIT_EDIT_COUNTERS,ADF_ACL_AVL_UNIT_EDIT_MAINTENANCE,ADF_ACL_AVL_UNIT_EDIT_CMD_ALIASES,ADF_ACL_AVL_UNIT_EDIT_REPORT_SETTINGS"]
}
if {$item == "NULL"} {
	set svc_error 7
	return
}

avl_source_script "\$WIALON_SDK_AJAX_ROOT/common/post.tcl"
# setup result
set svc_result [avl_proxy_app_request [get_env_val "AVL_APP_BACKUP_URL"] "/file?itemId=[${svc_params} get_text itemId]&fileId=[${svc_params} get_text fileId]&type=[${item} get_type_name]"]
if {$svc_result == "NULL"} {
	set svc_error 4
	return
}
set svc_error 0
