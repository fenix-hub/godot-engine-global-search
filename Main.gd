extends Control

@onready var global_search: GlobalSearchContainer = $GlobalSearch

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# These are public APIs
	global_search.search_bar.search_url = "https://s23uakwqftelv6idp.a1.typesense.net/multi_search"
	global_search.search_bar.search_headers = [
		"x-typesense-api-key: 44aUZ6UOyg2tQlfNu89qVTTU2Kd9k1UL",
		"Content-Type: application/json",
		"Accept: */*"
	]
	global_search.search_bar.search_body = {
		searches = [
			{
				q = "{{search_text}}",
				query_by = "author,title",
				highlight_full_fields = "author,title",
				highlight_start_tag = "[bgcolor=#%s]" % Color("006f7e").to_html(),
				highlight_end_tag = "[/bgcolor]",
				collection = "b",
				filter_by = "subjects:=[`Fiction`,`History`,`General`]"
			}
		]
	}
	# Each search_engine's response structure differs.
	# Also, the response contents are different based on the type of documents you look for.
	# You can provide any `mapper_function`, but make sure that it accepts a `Dictionary`
	# and returns a `SearchResult` object. 
	global_search.search_bar.mapper_function = map_typesense_response
	global_search.search_result_list.set_category_attribute("subjects")
	global_search.search_result_list.set_search_result_categories(["Fiction", "History", "General"])


func map_typesense_response(response: Dictionary) -> SearchResult:
	var search_result: Dictionary = response.results[0]
	var hits: Array[SearchResultElement] = []
	hits.assign(search_result.hits.map(typesense_result_to_element))
	return SearchResult.new(
		search_result.request_params.q, 
		search_result.search_time_ms, 
		search_result.found, 
		hits
	)


func typesense_result_to_element(result: Dictionary) -> SearchResultElement:
	var title = result.highlight.get("title", { value = "unknown" })
	if title is Dictionary:
		title = title.get("value")
	var author = result.highlight.get("author", { value = "unknown" })
	if author is Dictionary:
		author = author.get("value")
	return SearchResultElement.new(result, title, author, "📖")


func _on_global_search_search_result_clicked(category, search_result_element) -> void:
	print(category, " >> ", search_result_element)

func _on_header_search_bar_container_header_search_bar_clicked():
	global_search.show()
