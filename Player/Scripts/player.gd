class_name Player extends CharacterBody2D


var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

func _ready() -> void:
	state_machine.Initialize(self)
	
func _process(delta: float) -> void:
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	

func _physics_process(delta: float) -> void:
	move_and_slide()


func SetDirection() -> bool:
	var new_direction: Vector2 = cardinal_direction

	if direction == Vector2.ZERO:
		return false

	if direction.y == 0:
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN
	elif direction.x > 0 and direction.y < 0: # Handles up-right direction
		if cardinal_direction == Vector2.DOWN || cardinal_direction == Vector2.LEFT:
			new_direction = Vector2.RIGHT
	elif direction.x > 0 and direction.y > 0: # Handles down-right direction
		if cardinal_direction == Vector2.UP || cardinal_direction == Vector2.LEFT:
			new_direction = Vector2.RIGHT
	elif direction.x < 0 and direction.y < 0: # Handles up-left direction
		if cardinal_direction == Vector2.DOWN || cardinal_direction == Vector2.RIGHT:
			new_direction = Vector2.LEFT
	elif direction.x < 0 and direction.y > 0: # Handles down-left direction
		if cardinal_direction == Vector2.UP || cardinal_direction == Vector2.RIGHT:
			new_direction = Vector2.LEFT

	if new_direction == cardinal_direction:
		return false

	cardinal_direction = new_direction
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true


func UpdateAnimation(_state: String) -> void:
	animation_player.play(_state + "_" + AnimDirection())

func AnimDirection() -> String:
	if cardinal_direction == Vector2.UP:
		return "up"
	elif cardinal_direction == Vector2.DOWN:
		return "down"
	else:
		return "side"
