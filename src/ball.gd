extends Area2D

export var speed = 200

var velocity
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	add_to_group("projectile")
	$AnimatedSprite.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = velocity.normalized () * speed
	position += velocity * delta


func _on_Visibility_screen_exited():
	queue_free()
