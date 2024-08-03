extends CharacterBody2D

var pos=null
var speed=50
var onyx_fall=null
var player=null
var player_chase=null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_height=-300
var target_position=Vector2(0,0)
var already_in_movement=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player!=null:
		fall()
		if onyx_fall:
			velocity.y += gravity * delta
			if is_on_floor():
				onyx_fall=false
				$PositionTimer.start()
		if player_chase==true:
			chase_player()
			velocity.y += gravity/2 * delta
			if is_on_floor():
				player_chase=false
				$PositionTimer.start()
				velocity.x=0
	move_and_slide()

func _on_detection_area_player_body_entered(body):
	if body.is_in_group("Player"):
		onyx_fall=false
		player=body
		
func _on_detection_area_player_body_exited(body):
	if body.is_in_group("Player"):
		player_chase=false
		player=null
		onyx_fall=false
		velocity.y=jump_height
		$PositionTimer.stop()
		$WaitingTimerGoBackToPosition.start()

func fall():
	pos=(player.global_position - self.global_position).normalized()
	if (pos.x<=0.01) and (pos.x>=-0.01):
		onyx_fall=true
		
func chase_player():
	if player_chase:
		if !already_in_movement:
			var direction = (player.global_position - self.position).normalized()* speed
			print(direction)
			if direction.x>0:
					get_node("AnimatedSprite2D").flip_h=true
			else:
					get_node("AnimatedSprite2D").flip_h = false
			pos=sign(direction.x)*speed
			velocity.x=pos
			already_in_movement=true
			#velocity.y = -sqrt(2 * gravity * jump_height)
	else:
		velocity = lerp(velocity, Vector2.ZERO, 0.01)
		velocity.x = 0  # Stop horizontal movement when `player_chase` is disabled
	move_and_slide()
func _on_position_timer_timeout():
	player_chase=true
	velocity.y=jump_height
	already_in_movement=false
	# Calcul de la position cible
	
func _on_waiting_timer_go_back_to_position_timeout():
	velocity.y=jump_height


func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		death()

func death():
	queue_free()
