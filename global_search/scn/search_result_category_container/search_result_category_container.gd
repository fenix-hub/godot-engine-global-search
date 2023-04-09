## @author https://github.com/fenix-hub

extends PanelContainer
class_name SearchResultCategoryContainer

signal search_result_clicked(
	category: String, 
	search_result_element: SearchResultElement
)

@onready var vbox: VBoxContainer = $VBoxContainer
@onready var results_container: VBoxContainer = vbox.get_node("Results")
@onready var category_label: Label = vbox.get_node("CategoryName")
@onready var search_result_container: PackedScene = preload("res://global_search/scn/search_result_container/search_result_container.tscn")

@export var category_name: String = "" :
	set(value):
		category_name = update_category_name(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	category_label.set_text(category_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_category_name(category_name: String) -> String:
	category_label.set_text(category_name)
	return category_name

func set_results(results: Array[SearchResultElement]) -> void:
	if results.is_empty():
		hide()
	for result in results:
		add_result(result)

func add_result(result_element: SearchResultElement) -> void:
	var _container: SearchResultContainer = search_result_container.instantiate()
	results_container.add_child(_container)
	_container.load_from_element(result_element)
	_container.search_result_clicked.connect(on_search_result_clicked)
	show()

func get_results() -> Array[SearchResultContainer]:
	return results_container.get_children() as Array[SearchResultContainer]

func clear_results() -> void:
	for result in results_container.get_children():
		result.queue_free()
	hide()

func on_search_result_clicked(search_result_element: SearchResultElement) -> void:
	search_result_clicked.emit(category_name, search_result_element)
