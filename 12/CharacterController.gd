extends Node

# member variables here, example:
# var a=2
# var b="textvar"

var player_pos
var direction

func _ready():
	# Initialization here
	print("oh nice the game started")
	

func _process(delta):
	
	player_pos.x+=1
	
	if (Input.is_action_pressed("move_right")):
		get_node("AnimatedSprite").set_pos(0,0)