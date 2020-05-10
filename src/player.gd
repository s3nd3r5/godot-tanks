extends KinematicBody2D

signal fire

enum Dirs { UP, DOWN, LEFT, RIGHT }
# Declare member variables here. Examples:
export var speed = 4000

var screen_size
var sprite_extents
var face_dir
var firing

func is_facing(check_dir):
	return face_dir == check_dir
	
func turn(dir):
	if is_facing(Dirs.LEFT):
		if dir == Dirs.UP:
			rotate(PI / 2)
		elif dir == Dirs.DOWN:
			rotate(PI / 2 * -1)
		else:
			rotate(PI)
	elif is_facing(Dirs.RIGHT):
		if dir == Dirs.UP:
			rotate(PI / 2 * -1)
		elif dir == Dirs.DOWN:
			rotate(PI / 2)
		else:
			rotate(PI)
	elif is_facing(Dirs.UP):
		if dir == Dirs.LEFT:
			rotate(PI / 2 * -1)
		elif dir == Dirs.RIGHT:
			rotate(PI / 2)
		else:
			rotate(PI)
	elif is_facing(Dirs.DOWN):
		if dir == Dirs.LEFT:
			rotate(PI / 2)
		elif dir == Dirs.RIGHT:
			rotate(PI / 2 * -1)
		else:
			rotate(PI)
	face_dir = dir

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	sprite_extents = get_node("CollisionShape2D").shape.extents
	# position.x = screen_size.x
	# position.y = screen_size.y
	face_dir = Dirs.UP
	firing = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		if is_facing(Dirs.RIGHT):
			velocity.x += 1
		else:
			turn(Dirs.RIGHT)
	elif Input.is_action_pressed("ui_left"):
		if is_facing(Dirs.LEFT):
			velocity.x -= 1
		else:
			turn(Dirs.LEFT)
	elif Input.is_action_pressed("ui_up"):
		if is_facing(Dirs.UP):
			velocity.y -= 1
		else:
			turn(Dirs.UP)
	elif Input.is_action_pressed("ui_down"):
		if is_facing(Dirs.DOWN):
			velocity.y += 1
		else:
			turn(Dirs.DOWN)
		
	if Input.is_action_pressed("ui_fire") && !firing:
		emit_signal("fire")
		firing = true
		
	# is moving
	if velocity.length() > 0: 
		velocity = velocity * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	#position += velocity * delta

	move_and_slide(velocity * delta)
	position.x = clamp(position.x,
		sprite_extents.x,
		screen_size.x - sprite_extents.x)
	position.y = clamp(position.y,
		sprite_extents.y,
		screen_size.y - sprite_extents.y)

func _on_PlayerFireTimer_timeout():
	firing = false
