extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed_scale = 50

var velocity = Vector2.ZERO

var floating=0 #is not affected by gravity ?

var jump=Vector2(0,5)

var coyote_jump = 0

var frixion = 25

var gravity=3 #gravity strength

var p_hrunSpeed = 5 

onready var collision_polygon_2d = $"../terrain de test/CollisionPolygon2D"








# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if area_entered onready var terrain_de_test = $"../terrain de test"

	p_mvt(delta)
	
	pass

func p_mvt(delta):
	var vec_gravity = Vector2(0,gravity)
	var input_vector = Vector2.ZERO
	input_vector.x=p_hrunSpeed * (Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left"))
	input_vector.y=p_hrunSpeed * (Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up"))
	
	print(input_vector)
	
	velocity=apply_accel(delta,[input_vector,vec_gravity],velocity)
	"""if input_vector.x==0:
		input_vector.x = move_toward(input_vector.x,0,frixion)
	"""
	
	velocity = move_and_slide(velocity)
	
	if position.y <0:
		position.y = 0
		velocity.y=0
	if position.y >360:
		position.y = 360
		velocity.y=0
	
		
	


func apply_accel(delta,a_vectors,v_vector,max_Speed=800):
	var a_vector = Vector2.ZERO
	for i in range(len(a_vectors)):
		a_vector.x += a_vectors[i].x
		a_vector.y += a_vectors[i].y
	
	a_vector.y -= gravity*floating #applying wether the player is bound to gravity or not ==> should be made into a vector in the list of vectors
	
	
	
	if a_vector.x==0 and get_collision_mask_bit(24):
		if v_vector.x==0:
			pass
		else:
			v_vector = v_vector.move_toward(Vector2(0,v_vector.y),frixion)
	#a_vector.x*=speed_scale
	#a_vector.y*=speed_scale
	v_vector += a_vector
	
	#v_vector.x
	
	
	print(v_vector)
	return v_vector




func apply_accel_SHMUP(delta,a_vectors,v_vector,max_Speed=200):
	var a_vector = Vector2.ZERO
	for i in range(len(a_vectors)):
		a_vector.x += a_vectors[i].x
		a_vector.y += a_vectors[i].y
	
	a_vector.y -= gravity*floating #applying wether the player is bound to gravity or not ==> should be made into a vector in the list of vectors
	
	
	
	if a_vector.x==0:
		if v_vector.x==0:
			pass
		else:
			v_vector = v_vector.move_toward(Vector2.ZERO,frixion)
	#a_vector.x*=speed_scale
	#a_vector.y*=speed_scale
	v_vector += a_vector
	
	v_vector
	
	v_vector.limit_length(max_Speed)
	return v_vector










func _on_gravity_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	
	
	
	return gravity
	
	pass # Replace with function body.


































