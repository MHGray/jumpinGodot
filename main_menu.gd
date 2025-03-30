extends Node2D

class_name  My_Window

@onready var rich_text_label: RichTextLabel = $RichTextLabel
const ENEMY = preload("res://enemy.tscn")
@onready var player: Player = $Player
const ENEMY_2 = preload("res://enemy2.tscn")

var mousepos:Vector2
var window_position:Vector2
@onready var rich_text_label_2: RichTextLabel = $RichTextLabel2
var enemies:Array[Enemy]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_position = DisplayServer.window_get_position()
	for i in 5:
		var enemy = ENEMY_2.instantiate()
		add_child(enemy)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	window_position = DisplayServer.window_get_position()
	
	mousepos = get_global_mouse_position() + window_position
	rich_text_label_2.text = str(player.distance)
	rich_text_label.text = str(mousepos)
	pass
