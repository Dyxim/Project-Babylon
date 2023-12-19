extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed_scale = 50

var velocity = Vector2.ZERO

var floating=0 #is not affected by gravity ?

var jump= 300

var coyote_jump = 0

var frixion = 25

var gravity=-3 #gravity strength

var p_hrunSpeed = 5 

onready var collision_polygon_2d = $"../terrain de test/CollisionPolygon2D"

var up_direction = Vector2(0,-1)

var centered_gravity=true

var select_not_pressed=true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if area_entered onready var terrain_de_test = $"../terrain de test"
	
	if Input.is_action_pressed("ui_select"):
		if select_not_pressed:
			centered_gravity=not centered_gravity
		select_not_pressed=false
	if centered_gravity:
		var center=Vector2(position.x,position.y)
		up_direction=-center.normalized()
		
	else:
		if Input.is_action_pressed("ui_accept") and not Input.is_action_pressed("ui_select"):
			up_direction=up_direction.rotated(delta*PI/2)
			up_direction=up_direction.normalized()
	p_mvt(delta)
	
	pass

func p_mvt(delta):
	var vec_gravity = up_direction*gravity
	var accel = []
	var input_vector = Vector2.ZERO
	input_vector = up_direction.tangent()*p_hrunSpeed * (Input.get_action_strength("ui_left")-Input.get_action_strength("ui_right"))
	accel.append(vec_gravity)
	if is_on_floor():
		coyote_jump = 0.3
	
	if not is_on_floor():
		coyote_jump -= delta
	if Input.is_action_pressed("ui_up"):
		if coyote_jump>0:
			input_vector += jump*up_direction 
			coyote_jump=0
	
	
	#print(input_vector)
	
	accel.append(input_vector)
	velocity=apply_accel(delta,accel,velocity)
	"""if input_vector.x==0:
		input_vector.x = move_toward(input_vector.x,0,frixion)
	"""
	
	velocity = move_and_slide(velocity,up_direction)
	
	
	#if position.y < 0:
	#	position.y = 0
	#	velocity.y = 0
	#if position.y > 360:
	#	position.y = 360
	#	velocity.y = 0
	
		
	


func apply_accel(delta,a_vectors,v_vector,max_Speed=800):
	var a_vector = Vector2.ZERO
	for i in range(len(a_vectors)):
		a_vector.x += a_vectors[i].x
		a_vector.y += a_vectors[i].y
	
	a_vector.y -= gravity*floating #applying wether the player is bound to gravity or not ==> should be made into a vector in the list of vectors
	
	
	#if get_collision_mask_bit(24):
	if a_vector.x==0 :
		if v_vector.x==0:
			pass
		else:
			v_vector = v_vector.move_toward(Vector2(0,v_vector.y),frixion)
	#a_vector.x*=speed_scale
	#a_vector.y*=speed_scale
	v_vector += a_vector
	
	#v_vector.x
	
	
	#print(v_vector)
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
	
	
	
	v_vector.limit_length(max_Speed)
	return v_vector










func _on_gravity_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	"""note : this only is launched once ???"""
	var vec_gravity = Vector2(0,gravity)
	print(velocity)
	velocity+=vec_gravity
	print(velocity)
	pass # Replace with function body.


































