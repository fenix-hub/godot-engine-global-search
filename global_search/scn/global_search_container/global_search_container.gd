## @author https://github.com/fenix-hub

@icon("res://global_search/scn/global_search_container/icon.svg")
extends Control
class_name GlobalSearchContainer

signal search_result_clicked(category: String, search_result_element: SearchResultElement)

@onready var search_bar: SearchBarContainer = $SearchBarContainer
@onready var stats_widget: SearchStatsWidget = $SearchStatsWidget
@onready var search_result_list: SearchResultListContainer = $SearchResultList


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	search_result_list.hide()

func _input(event: InputEvent) -> void:
	if (event.is_action_released("ui_cancel")):
		hide()

func set_search_results(hits: Array[SearchResultElement]) -> void:
	search_result_list.set_search_results(hits)

func _on_search_result_list_search_result_clicked(category: String, search_result_element: SearchResultElement) -> void:
	search_result_clicked.emit(category, search_result_element)


func _on_search_bar_container_search_result_retrieved(search_result: SearchResult) -> void:
	set_search_results(search_result.hits)
	stats_widget.update_stats(search_result.query, search_result.time, search_result.hits_size)


func _on_search_bar_container_search_text_changed(text: String) -> void:
	search_result_list.visible = not text.is_empty()
	if text.is_empty():
		search_result_list.clear_results()
		stats_widget.update_stats("", 0, 0)

func _on_visibility_changed():
	if visible:
		search_bar._search_line_edit.grab_focus()
