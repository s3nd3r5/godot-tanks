extends Area2D

signal enemy_hit

enum Dirs { UP, DOWN, LEFT, RIGHT }
# Declare member variables here. Examples:
export var speed = 100
export var firing = false
export var face_dir = Dirs.UP

var screen_size

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
	position.x = screen_size.x / 2
	position.y = 50
	face_dir = Dirs.DOWN
	rotate(PI)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()

	# is moving
	if velocity.length() > 0: 
		velocity = velocity.normalized () * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	


func _on_Enemy_body_entered(body):
	hide()
	emit_signal("enemy_hit")
