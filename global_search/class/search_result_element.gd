## @author https://github.com/fenix-hub

extends RefCounted
class_name SearchResultElement

var icon: Texture2D
var emoji: String
var title: String
var subtitle: String
var original: Dictionary

func _init(original: Dictionary, title: String, subtitle: String, emoji: String = "📦", icon: Texture2D = null) -> void:
	self.title = title
	self.subtitle = subtitle
	self.icon = icon
	self.emoji = emoji
	self.original = original

func _to_string() -> String:
	return str(get_instance_id(), " ", emoji, " ", original)
