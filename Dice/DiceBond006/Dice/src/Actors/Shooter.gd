extends KinematicBody2D


var time:float=0.0
var player_near:=false
var shooting:bool=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	time+=delta
	if(time>1.0):
		time=0.0
		shoot()


func shoot()->void:
	if(!player_near):
		return
	shooting=true
	var bullet=preload("res://src/Random/Bullet.tscn").instance()
	bullet.position=position
	get_parent().add_child(bullet)
	time=0.0

func _on_DetectPlayer_body_entered(body: Node) -> void:
	player_near=true

func _on_DetectPlayer_body_exited(body: Node) -> void:
	player_near=false


func _on_Bash_area_entered(area: Area2D) -> void:
	queue_free()
