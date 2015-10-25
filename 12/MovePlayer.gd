extends KinematicBody2D

const speed = 40
var jump = false
var jump_done = true;
var jump_total = 0;
var min_jump = 15
var max_jump = 25
var velocity = Vector2()

const FLOOR_ANGLE_TOLERANCE = 40

func _ready():
	set_fixed_process(true)
	var bulletscene = load("res://p1bullet.scn") # will load when the script is instanced
	
func _fixed_process(delta):
	var direction = Vector2(0,0)
	
	if (jump == false):
		
		if (jump_done == false):
			direction += Vector2(0,1)
		
		else:
			move( Vector2(0,1) ) #move down 1 pixel per physics frame
		
	
	if ( Input.is_action_pressed("p1_up") and jump == false and jump_done == true ):
		jump = true
		jump_done = false
		
	if (jump == true):
		direction += Vector2(0, -1)
		jump_total = jump_total + 1;
	
	if (jump_total >= min_jump and !Input.is_action_pressed("p1_up")):
		jump = false
		jump_total = 0
		
	if (jump_total >= max_jump):
		jump = false
		
		
	"""if ( Input.is_action_pressed("p1_down") ):
		direction += Vector2(0,1)"""
		
	if ( Input.is_action_pressed("p1_left") ):
		direction += Vector2(-1,0)
		
		if (get_node("AnimatedSprite/AnimationPlayer").get_current_animation() != "run"):
			get_node("AnimatedSprite/AnimationPlayer").set_current_animation("run")
		
		get_node("AnimatedSprite").set_flip_h(true)
		
	if ( Input.is_action_pressed("p1_right") ):
		direction += Vector2(1,0)
		if (get_node("AnimatedSprite/AnimationPlayer").get_current_animation() != "run"):
			get_node("AnimatedSprite/AnimationPlayer").set_current_animation("run")
		
		get_node("AnimatedSprite").set_flip_h(false)
	

	if (!Input.is_action_pressed("p1_up") and !Input.is_action_pressed("p1_down") and !Input.is_action_pressed("p1_left") and !Input.is_action_pressed("p1_right") and !Input.is_action_pressed("p1_shoot")):
		if (get_node("AnimatedSprite/AnimationPlayer").get_current_animation() != "idle"):
			get_node("AnimatedSprite/AnimationPlayer").set_current_animation("idle")
	
	if ( Input.is_action_pressed("p1_shoot") ):
		if (get_node("AnimatedSprite/AnimationPlayer").get_current_animation() != "shoot"):
			get_node("AnimatedSprite/AnimationPlayer").set_current_animation("shoot")
			
			var bullet = load("res://p1bullet.scn")
			
			var bi = bullet.instance()
			get_parent().add_child(bi)
			#bi_set_pos(get_pos() + get_node("GunPos").get_pos())
			
			
			"""var scene = load("res://p1bullet.scn")
			
			var node = scene.instance()
			add_child(KinematicBody2D)"""
			
	if (jump_done == false):
		get_node("AnimatedSprite/AnimationPlayer").set_current_animation("fall")
		
	
	move( direction * speed * delta )
	
	
	
	
	if is_colliding():  # colliding with Static, Kinematic, Rigid
		# do something
		#print ("Collision with ", get_collider() )  # get_collider() returns CollisionObject
		var n = get_collision_normal()
		
		if ( rad2deg(acos(n.dot( Vector2(0,-1)))) < FLOOR_ANGLE_TOLERANCE ):
			#if angle to the "up" vectors is < angle tolerance
			#char is on floor
			jump_done = true
			
		direction = n.slide( direction )
		move(direction*speed*delta)
		