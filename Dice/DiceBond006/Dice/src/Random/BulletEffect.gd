extends Node2D


func _ready() -> void:
	get_node("Particles2D").emitting=true
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()
