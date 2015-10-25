extends KinematicBody2D

const speed = 40

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	move(Vector2 (1,0))