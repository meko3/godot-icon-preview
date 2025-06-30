@tool
extends Control

const IconItemList = preload("res://addons/icon_preview/item_list.tscn")

@onready var container = $ScrollContainer
@onready var label = $Label
@onready var timer = $Timer

func _ready() -> void:
	timer.timeout.connect(func(): 
		label.visible = false
		timer.stop()
	)
	var theme = EditorInterface.get_editor_theme()
	var iconTypes = theme.get_icon_type_list()
	for type in iconTypes:
		var icons = theme.get_icon_list(type)
		var itemList = IconItemList.instantiate()
		container.add_child(itemList)
		itemList.clear()
		itemList.item_selected.connect(_on_item_selected.bind(itemList))
		for icon_name in icons:
			var icon = theme.get_icon(icon_name, type)
			itemList.add_item(type + ":" + icon_name, icon)
			
func _on_item_selected(index: int, itemList: ItemList) -> void:
	var name = itemList.get_item_text(index)
	DisplayServer.clipboard_set(name)
	show_notification("Copied " + name)

func show_notification(text: String, duration: float = 2.0) -> void:
	var parts = text.split(":")
	var result = ""
	for part in parts:
		result += '"' + part + '"' + ", "
	label.text = result
	label.visible = true
	timer.start(3)
