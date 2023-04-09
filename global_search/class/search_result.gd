## @author https://github.com/fenix-hub
##
## An object wrapping the result of a search issued to a search engine through REST APIs.
## Generally used as the return value of the [class SearchBarContainer.mapper_function] used
## used to map the raw ([Dictionary]) response of the request to a search engine specific
## data structure.
extends RefCounted
class_name SearchResult

## The query issued to the search engine
var query: String
## The time required by the search engine to process the request
var time: int
## The number of hits, that is the number of matching results
var hits_size: int
## The hits, that is the list of matching results.
var hits: Array[SearchResultElement]

func _init(query: String, time: int, hits_size: int, hits: Array[SearchResultElement]) -> void:
	self.query = query
	self.time = time
	self.hits_size = hits_size
	self.hits = hits
