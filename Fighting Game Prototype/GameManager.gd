extends Node3D

var players = []
var playerInstance = load("res://Character.tscn")
@export var playerNumMax: int = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	createPlayers()
	pass # Replace with function body.


func createPlayers():
	for i in range(0, playerNumMax):
		var mat = load("res://Materials/Player/RedPlayer.tres") if i == 0 else load("res://Materials/Player/BluePlayer.tres")
		var player = playerInstance.instantiate()
		player.init(i+1, mat, i)
		player.name = "Player" + str(player.num)
		players.append(player)
		get_node("Player-Loader").add_child(player)
		player.global_position = get_node("Arena/Structures/Floor/FighterStartPositions").get_children()[i].global_position
		#player.transform = get_node("Arena/Floor/FighterStartPositions").get_children()[i].transform
		print("Hi")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
