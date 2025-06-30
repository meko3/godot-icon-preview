@tool
extends EditorPlugin

const MainPanel = preload("res://addons/icon_preview/preview.tscn")
var main_panel_instance

func _enter_tree():
	var menu_buttons = get_editor_interface().get_editor_main_screen()
	main_panel_instance = MainPanel.instantiate()
	menu_buttons.add_child(main_panel_instance)
	_make_visible(false)

func _exit_tree():
	if main_panel_instance:
		main_panel_instance.queue_free()
		
func _has_main_screen():
	return true
	
func _make_visible(visible):
	if main_panel_instance:
		main_panel_instance.visible = visible
		
func _get_plugin_name():
	return "Icon Preview"
	
func _get_plugin_icon():
	return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")
