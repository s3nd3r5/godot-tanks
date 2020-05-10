extends KinematicBody2D

signal collision

enum states { NORMAL, DAMAGED, DESTROYED }
export var MAX_HEALTH = 3

var screen_size
var state
var prev_state
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_shape_entered", self, '_on_House_area_shape_entered')
	screen_size = get_viewport_rect().size
	#position.x = screen_size.x / 2 + 70
	#position.y = screen_size.y / 2 + 80
	health = MAX_HEALTH
	state = states.NORMAL

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == states.NORMAL && prev_state != states.NORMAL:
		$AnimatedSprite.play("default")
	elif state == states.DAMAGED && prev_state != states.DAMAGED:
		$AnimatedSprite.play("hit")
	elif state == states.DESTROYED && prev_state != states.DESTROYED:
		$AnimatedSprite.play("destroyed")

 
func _on_Hitbox_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.is_in_group("projectile"):
		if state != states.DESTROYED:
			area.queue_free()
			health -= 1
			if health <= 0:
				prev_state = state
				state = states.DESTROYED
			elif health != MAX_HEALTH:
				prev_state = state
				state = states.DAMAGED
	#else:
		#move_and_slide(area)


func _on_Hitbox_body_entered(body):
	pass
