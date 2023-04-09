## @author https://github.com/fenix-hub

@icon("res://global_search/scn/search_bar_container/icon.svg")
extends PanelContainer
class_name SearchBarContainer

signal search_text_changed(text: String)
signal search_result_retrieved(search_result: SearchResult)
signal search_error(error: Dictionary)

@export var search_on_empty: bool = false
@export var search_url: String = ""
@export var search_headers: PackedStringArray = []
@export var search_method: int = HTTPClient.METHOD_POST
@export var search_body: Dictionary = {}
## Function used to map the response coming from the search engine through REST APIs to a [SearchResult] object.
## It must have a [Dictionary] as argument.
@export var mapper_function: Callable

@onready var _search_line_edit: LineEdit = $HBoxContainer/LineEdit 
@onready var _search_request: HTTPRequest = $HTTPRequest

func _ready() -> void:
	pass

func map_response(response: Dictionary) -> SearchResult:
	assert(not mapper_function.is_null(), "Mapper function must be assigned!")
	return mapper_function.call(response)

func _on_line_edit_text_changed(new_text: String) -> void:
	search_text_changed.emit(new_text)
	_search_request.cancel_request()
	if new_text.is_empty() and not search_on_empty:
		return
	var body: String = JSON.stringify(search_body).replace("{{search_text}}", new_text)
	_search_request.request(search_url, search_headers, search_method, body)

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if result == OK:
		var response: Dictionary = JSON.parse_string(body.get_string_from_utf8())
		if response_code in [200, 299]:
			search_result_retrieved.emit(map_response(response))
		else:
			search_error.emit(response)
	else:
		search_error.emit({ result = result })
