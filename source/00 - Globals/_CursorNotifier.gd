extends Window
#------------------------------------------------------------------------------#
func _notification(event):
	if event == NOTIFICATION_WM_SIZE_CHANGED: C.resize_cursor(C.current_cursor)
