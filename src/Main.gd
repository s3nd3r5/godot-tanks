extends Node

export (PackedScene) var Ball
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.connect("fire", self, '_on_Player_fire')
	$Enemy.connect("hit", self, '_on_Enemy_hit')
	

func _on_Player_fire():
	$PlayerFireTimer.start(1)
	var ball = Ball.instance()
	add_child(ball)
	ball.position = $Player.position
	
	var y_offset = $Player.get_node("CollisionShape2D").shape.extents.y * 2
	var vec_offset = Vector2(0, -y_offset).rotated($Player.rotation)
	
	ball.velocity = Vector2(0, -1).rotated($Player.rotation)
	ball.position += vec_offset

func _on_Enemy_hit():
	pass

func _on_Enemy_dead():
	# game_over()
	pass # Replace with function body.
