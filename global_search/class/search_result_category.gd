## @author https://github.com/fenix-hub

extends RefCounted
class_name SearchResultCategory

var id: int = 0
var name: String = ""
var elements: Array[SearchResultElement] = Array()

func _init(id: int, name: String, elements: Array[SearchResultElement] = Array()) -> void:
	self.id = id
	self.name = name
	self.elements = elements
