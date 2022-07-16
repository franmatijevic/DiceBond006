extends KinematicBody2D

var dir:=Vector2.ZERO
var speed:float=350.0

func _ready() -> void:
	dir=(get_node("/root/Game/Level/Player").global_position - global_position).normalized()

func _physics_process(delta: float) -> void:
	move_and_slide(dir*speed)


func _on_Wall_body_entered(body: Node) -> void:
	get_node("Sprite").visible=false
	speed=0.0
	queue_free()
