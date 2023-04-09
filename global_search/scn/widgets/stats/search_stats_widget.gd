## @author https://github.com/fenix-hub

@icon("res://global_search/scn/widgets/stats/icon.svg")
extends RichTextLabel
class_name SearchStatsWidget

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_stats("", 0, 0)


func update_stats(search_text: String, time: int, hits: int) -> void:
	set_text(
		("⚡️ [b]%s[/b] search results found " % hits) + 
		("" if search_text.is_empty() else "for [b]\"%s\"[/b] " % search_text) +
		("in [b]%s[/b]ms" % time) 
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
