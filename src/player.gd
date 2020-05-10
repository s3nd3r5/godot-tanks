extends KinematicBody2D

signal fire

enum Dirs { UP, DOWN, LEFT, RIGHT }
# Declare member variables here. Examples:
export var speed = 4000

const ROTATION = PI / 100
const BASE_VEC = Vector2(0, -1)

var screen_size
var sprite_extents
var firing


func normalize_rotation(rot):
	return rot - (2 * PI) * floor((rot + PI) / (2 * PI))

func turn(dir):
	rotate(ROTATION * dir)
	# rotation = normalize_rotation(rotation)

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	sprite_extents = get_node("CollisionShape2D").shape.extents
	# position.x = screen_size.x
	# position.y = screen_size.y
	firing = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()

	if Input.is_action_pressed("ui_right"):
		turn(1)
	elif Input.is_action_pressed("ui_left"):
		turn(-1)
	elif Input.is_action_pressed("ui_up"):
		velocity = BASE_VEC.rotated(rotation)

	if Input.is_action_pressed("ui_fire") && !firing:
		emit_signal("fire")
		firing = true

	if velocity.length() > 0:
		velocity = velocity * speed
		$AnimatedSprite.play()
		move_and_slide(velocity * delta)
		position.x = clamp(position.x,
			sprite_extents.x,
			screen_size.x - sprite_extents.x)
		position.y = clamp(position.y,
			sprite_extents.y,
			screen_size.y - sprite_extents.y)
	else:
		$AnimatedSprite.stop()


func _on_PlayerFireTimer_timeout():
	firing = false
