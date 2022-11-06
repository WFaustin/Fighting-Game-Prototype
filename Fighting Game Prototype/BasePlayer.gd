extends Node3D

@export var playerMaterial : Material 
@export var num : int
@export var deviceNum : int = 0
@export var useKeyboard : bool = false

	

func init(_num:int = 0, _mat:Material = null, _deviceNum : int = 0):
	if _mat != null:
		playerMaterial = _mat
	num = _num 
	deviceNum = _deviceNum
	if deviceNum not in Input.get_connected_joypads():
		deviceNum = -1
		useKeyboard = true
		

# Called when the node enters the scene tree for the first time.
func _ready():
	if playerMaterial != null:
		get_node("PlayerModel").set_surface_override_material (0, playerMaterial)
	pass # Replace with function body.


func removeInputs():
	var ev = InputEventKey.new()
	ev.keycode = KEY_A
	InputMap.action_erase_event("moveLeft", ev)
	print("Removed")
	pass
	
#
func _input(event):
#	if event is InputEventKey and deviceNum == -1 and useKeyboard == true:
#		print(str(name) + " said Hello!")
#		if event.is_action_pressed("moveLeft"):
#			position.x -= .03
#		elif event.is_action_pressed("moveRight"):
#			position.x += .03
#		elif Input.is_action_pressed("crouch"):
#			rotation.z = 80
#		elif Input.is_action_just_released("crouch"):
#			rotation.z = 0
#	if event.device == deviceNum:
#		print(str(name) + " said Hello!")
#		if event.is_action_pressed("moveLeft"):
#			position.x -= .03
#		elif event.is_action_pressed("moveRight"):
#			position.x += .03
#		elif Input.is_action_pressed("crouch"):
#			rotation.z = 80
#		elif Input.is_action_just_released("crouch"):
#			rotation.z = 0
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("moveLeft" + str(name)):
		position.x -= .03
	if Input.is_action_pressed("moveRight" + str(name)):
		position.x += .03
	if Input.is_action_pressed("crouch" + str(name)):
		rotation.z = 80
	if Input.is_action_just_released("crouch" + str(name)):
		rotation.z = 0
	pass
