extends CharacterBody2D

var pos=-30
var speed=100
var onyx_fall=null
var player=null
var player_chase=null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var pos_calcul=0
var direction
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
				player_chase=true
				$PositionTimer.start()
			if player_chase==true:
				chase_player()
	move_and_slide()

func _on_detection_area_player_body_entered(body):
	if body.is_in_group("Player"):
		onyx_fall=false
		player=body
		
func _on_detection_area_player_body_exited(body):
	if body.is_in_group("Player"):
		player_chase=false
		player=null

func fall():
	pos=(player.global_position - self.global_position).normalized()
	if (pos.x<=0.01) and (pos.x>=-0.01):
		onyx_fall=true
		
func chase_player():
	pos_calcul=pos.y**2+10
	velocity.y=pos_calcul
	pos.y=pos.y+1
	direction = (player.global_position - self.global_position).normalized()
	velocity.x = direction.x * speed

func _on_position_timer_timeout():
	$PositionTimer.start()



