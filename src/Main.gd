extends Node

export (PackedScene) var Ball
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.connect("fire", self, '_on_Player_fire')
	

func _on_Player_fire():
	$PlayerFireTimer.start(5)
	var ball = Ball.instance()
	add_child(ball)
	ball.position = $Player.position
	
	var y_offset = $Player.get_node("CollisionShape2D").shape.extents.y * 2
	var x_offset = $Player.get_node("CollisionShape2D").shape.extents.x * 2
	
	if $Player.is_facing($Player.Dirs.UP):
		ball.move(0, -1)
		ball.position.y -= y_offset
	elif $Player.is_facing($Player.Dirs.DOWN):
		ball.move(0, 1)
		ball.position.y += y_offset
	elif $Player.is_facing($Player.Dirs.LEFT):
		ball.move(-1, 0)
		ball.position.x -= x_offset
	elif $Player.is_facing($Player.Dirs.RIGHT):
		ball.move(1, 0)
		ball.position.x += x_offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
