extends KinematicBody2D

var direction:Vector2=Vector2.ZERO
var roll_dir:=Vector2.ZERO
var speed:float=200
var rolling_speed:float=500.0

var spriteAngle:float=0.0

var rolling:bool=false

var health:int=6
var combo:int=0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	spriteAngle=(get_global_mouse_position() - global_position).normalized().angle()
	get_node("DiceSprite").rotation_degrees=rad2deg(spriteAngle)
	var direction: = get_direction()
	
	move_and_slide(direction*speed)
	move_and_slide(roll_dir*rolling_speed)
	
	if(Input.is_action_just_pressed("roll") and !rolling):
		rolling()

func get_direction()->Vector2:
	if(rolling):
		return Vector2.ZERO
	return Vector2(
		(Input.get_action_strength("move_right") - Input.get_action_strength("move_left")),
		(Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	)

func rolling()->void:
	combo=0
	get_node("Bash").monitorable=true
	get_node("Bash").monitoring=true
	rolling=true
	roll_dir=(get_global_mouse_position() - global_position).normalized()
	yield(get_tree().create_timer(0.2), "timeout")
	get_node("Bash").monitorable=false
	get_node("Bash").monitoring=false
	roll_dir=Vector2.ZERO
	rolling=false

func damage(value:int)->void:
	health=health-1
	match health:
		0:
			get_node("/root/Game/Death").play()
			queue_free()
		1:
			get_node("DiceSprite").texture=load("res://Assets/Dice/dice_1.png")
		2:
			get_node("DiceSprite").texture=load("res://Assets/Dice/dice_2.png")
		3:
			get_node("DiceSprite").texture=load("res://Assets/Dice/dice_3.png")
		4:
			get_node("DiceSprite").texture=load("res://Assets/Dice/dice_4.png")
		5:
			get_node("DiceSprite").texture=load("res://Assets/Dice/dice_5.png")

func _on_DetectDamage_body_entered(body: Node) -> void:
	damage(1)
	body.queue_free()


func _on_Bash_body_entered(body: Node) -> void:
	combo=combo+1
	if(combo>1):
		get_node("ComboText").visible=true
		get_node("ComboText").text="x" + str(combo)
		yield(get_tree().create_timer(3), "timeout")
		get_node("ComboText").visible=false
