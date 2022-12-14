extends CharacterBody3D

@export var playerMaterial : Material 
@export var num : int
@export var deviceNum : int = 0
@export var useKeyboard : bool = false
@export var jumpHeight : float = 4.0

var hitboxes = [] 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func init(_num:int = 0, _mat:Material = null, _deviceNum : int = 0):
	if _mat != null:
		playerMaterial = _mat
	num = _num 
	deviceNum = _deviceNum
	if deviceNum not in Input.get_connected_joypads():
		deviceNum = -1
		useKeyboard = true
	hitboxes.append(get_node("."))
	hitboxes.append(get_node("PlayerModel/Arms/Arm1/StaticBody3D"))
	hitboxes.append(get_node("PlayerModel/Arms/Arm2/StaticBody3D"))
		
# Called when the node enters the scene tree for the first time.
func _ready():
	if playerMaterial != null:
		get_node("PlayerModel").set_surface_override_material (0, playerMaterial)
		get_node("PlayerModel/Arms/Arm1").set_surface_override_material (0, playerMaterial)
		get_node("PlayerModel/Arms/Arm2").set_surface_override_material (0, playerMaterial)
	pass # Replace with function body.


func addInputs():
	#adds the keyboard inputs for players with no controllers
	pass

func playAttacks(version):
	match(version):
		"light":
			get_node("AnimationPlayer").play("LightAttack")
			pass
		"medium":
			get_node("AnimationPlayer").play("MediumAttack")
			pass
	pass

func turnCollisions(isOn):
	for i in hitboxes:
		i.set_collision_mask_value(2, isOn)	
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


func _physics_process(delta):
	velocity.x = 0
	if Input.is_action_pressed("moveLeft" + str(name)):
		position.x -= .03
	if Input.is_action_pressed("moveRight" + str(name)):
		position.x += .03
	if Input.is_action_pressed("crouch" + str(name)):
		turnCollisions(false)
		rotation.z = -(PI/4)
	if Input.is_action_just_released("crouch" + str(name)):
		turnCollisions(true)
		rotation.z = 0
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump" + str(name)) and is_on_floor():
		print("Jump")
		velocity.y = jumpHeight
		turnCollisions(false)

	if velocity.y < -.01 and not Input.is_action_pressed("crouch" + str(name)):
		turnCollisions(true)
		
	if Input.is_action_just_pressed("lightAttack" + str(name)):
		playAttacks("light")
		
	if Input.is_action_just_pressed("mediumAttack" + str(name)):
		playAttacks("medium")
		
	move_and_slide()

