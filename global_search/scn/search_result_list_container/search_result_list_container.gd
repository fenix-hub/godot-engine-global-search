## @author https://github.com/fenix-hub

@icon("res://global_search/scn/search_result_list_container/icon.svg")
extends PanelContainer
class_name SearchResultListContainer

signal search_result_clicked(category: String, search_result_element: SearchResultElement)

@export var category_attribute: String = ""
@export var show_uncategorized: bool = false

@onready var search_result_scroll: ScrollContainer = $VBoxContainer/ScrollContainer
@onready var search_result_list_categories: VBoxContainer = search_result_scroll.get_node("Categories")

var search_result_category_scn: PackedScene = preload("res://global_search/scn/search_result_category_container/search_result_category_container.tscn")

var uncategorized_search_result_category: SearchResultCategoryContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	uncategorized_search_result_category = add_search_result_category("Uncategorized")
	search_result_scroll.hide()

func set_category_attribute(category_attribute: String) -> void:
	clear_categories()
	self.category_attribute = category_attribute

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_search_result_categories(categories: Array[String]) -> void:
	for category in categories:
		add_search_result_category(category)

func add_search_result_category(category_name: String) -> SearchResultCategoryContainer:
	var _element: SearchResultCategoryContainer = search_result_category_scn.instantiate()
	search_result_list_categories.add_child(_element)
	_element.category_name = category_name
	_element.search_result_clicked.connect(func(c, e): search_result_clicked.emit(c, e))
	resize()
	return _element

func set_search_results(search_results: Array[SearchResultElement]) -> void:
	clear_results()
	for result in search_results:
		var categories: PackedStringArray = result.original.document.get(category_attribute)
		if categories.is_empty() and show_uncategorized:
			categories.append("Uncategorized")
		for category in categories:
			var search_result_category: SearchResultCategoryContainer = get_search_result_category(category)
			if not search_result_category == null:
				search_result_category.add_result(result)
		resize()
	search_result_scroll.show()

func get_search_result_categories() -> Array[Node]:
	return search_result_list_categories.get_children()

func get_search_result_category(category: String, default: String = "Uncategorized") -> SearchResultCategoryContainer:
	var matching_categories: Array[Node] = get_search_result_categories().filter(func(srcc: Node): return (srcc as SearchResultCategoryContainer).category_name.to_lower() == category.to_lower())
	if matching_categories.is_empty():
		return uncategorized_search_result_category if show_uncategorized else null
	return matching_categories[0]

func clear_categories() -> void:
	for s in get_search_result_categories():
		if s != uncategorized_search_result_category:
			s.queue_free()

func clear_results() -> void:
	for search_result_category in get_search_result_categories():
		(search_result_category as SearchResultCategoryContainer).clear_results()
	search_result_scroll.hide()

func _on_item_rect_changed() -> void:
	resize()

func resize() -> void:
	if search_result_scroll == null:
		return
	search_result_scroll.custom_minimum_size.y = min(
		search_result_list_categories.size.y,
		get_window().size.y - position.y - 80
	)
	search_result_scroll.queue_sort()


func _on_categories_resized() -> void:
	resize()
