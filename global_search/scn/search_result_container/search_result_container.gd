## @author https://github.com/fenix-hub

extends PanelContainer
class_name SearchResultContainer

signal search_result_clicked(search_result_element: SearchResultElement)

@onready var _icon: TextureRect = $Box/IconImage
@onready var _icon_emoji: Label = $Box/IconEmoji
@onready var _title: RichTextLabel = $Box/Info/Title
@onready var _subtitle: RichTextLabel = $Box/Info/Subtitle

var styles: Array[StyleBox] = [
	load("res://global_search/scn/search_result_container/styles/default.tres") as StyleBox,
	load("res://global_search/scn/search_result_container/styles/hover.tres") as StyleBox
]

var search_result_element: SearchResultElement

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func load_from_element(search_result_element: SearchResultElement) -> void:
	self.search_result_element = search_result_element
	_icon.set_texture(search_result_element.icon)
	_icon_emoji.set_text(search_result_element.emoji)
	_title.set_text(search_result_element.title)
	_subtitle.set_text(search_result_element.subtitle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	set("theme_override_styles/panel", styles[1])


func _on_mouse_exited() -> void:
	set("theme_override_styles/panel", styles[0])


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and !event.is_pressed() and event.get_button_index() == 1:
		search_result_clicked.emit(search_result_element)
		get_viewport().set_input_as_handled()
