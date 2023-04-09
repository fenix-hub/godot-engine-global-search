## @author https://github.com/fenix-hub

@icon("res://global_search/scn/header_search_bar/icon.svg")
extends PanelContainer
class_name HeaderSearchBarContainer

signal header_search_bar_clicked()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gui_input.connect(on_input)
	var input_event: InputEventKey = InputEventKey.new()
	input_event.keycode = KEY_SLASH
	InputMap.add_action("search")
	InputMap.action_add_event("search", input_event)

func on_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and not event.is_pressed() and event.get_button_index() == 1):
		header_search_bar_clicked.emit()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("search"):
		header_search_bar_clicked.emit()
