extends Node2D


@export var level_right:PackedScene
@export var level_left:PackedScene
@export var level_up:PackedScene
@export var level_down:PackedScene
@export var level_door1:PackedScene
@export var level_door2:PackedScene
@export var level_door3:PackedScene
@export var level_door4:PackedScene



#var adjacent_levels = {'right'=n_level_right,'left'= n_level_left,'up'=n_level_up,'down'=n_level_down,'door1'=n_level_door1,'door2'=n_level_door2,'door3'=n_level_door3,'door4'=n_level_door4}




# Called when the node enters the scene tree for the first time.
func _ready():
	Events.main_menu.connect(to_main_menu)
	Events.right_level.connect(change_level_right)
	Events.left_level.connect(change_level_left)
	Events.up_level.connect(change_level_up)
	Events.down_level.connect(change_level_down)
	Events.door1.connect(change_level_door1)
	Events.door2.connect(change_level_door2)
	Events.door3.connect(change_level_door3)
	Events.door4.connect(change_level_door4)
	#get_tree().change_scene_to_packed(n_level_up)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_scene(new_scene) -> void:
	await $LevelTransition.fade_to_black()
	if new_scene is PackedScene:
		await get_tree().change_scene_to_packed(new_scene)
	elif new_scene is String:
		await get_tree().change_scene_to_file(new_scene)
	else:
		return
	$LevelTransition.fade_from_black()

func to_main_menu():
	print('main')
	await change_scene("res://main_menu.tscn")

func change_level_right():
	await change_scene(level_right)

func change_level_left():
	await change_scene(level_left)

func change_level_up():
	await change_scene(level_up)



func change_level_down():
	await change_scene(level_down)


func change_level_door1():
	await change_scene(level_door1)


func change_level_door2():
	await change_scene(level_door2)


func change_level_door3():
	await change_scene(level_door3)


func change_level_door4():
	await change_scene(level_door4)
	



