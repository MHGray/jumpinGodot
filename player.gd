extends Window

class_name Player

@onready var main_menu: My_Window = $".."
var velocity:Vector2
var grounded:bool
var screenBoundsSize:Vector2i
var distance:float

func _ready() -> void:
	screenBoundsSize = DisplayServer.screen_get_size()
	
	
#func _notification(what:int):
	#if what == NOTIFICATION_WM_MOUSE_ENTER:
		#print("enter")
		#visible = false
	#elif what == NOTIFICATION_WM_MOUSE_EXIT:
		#print("exit")
		#visible = true

func _process(delta: float) -> void:
	var horizInput = Input.get_axis("left", "right")
	
	distance = main_menu.mousepos.distance_to(position + size/2)
	 
	if !visible:
		if distance > 70:
			visible = true
			pass
	else:
		if distance <= 70:
			visible = false
			pass
	
	
	if Input.is_action_just_pressed("up") && grounded:
		velocity.y -= 40
	elif !grounded:
		velocity.y += 100 * delta
	if horizInput:
		velocity.x += horizInput * 100 * delta
	else: 
		velocity.x = 0
	

	#check if grounded
	position += Vector2i(velocity)
	if position.y + size.y >= screenBoundsSize.y:
		position.y = screenBoundsSize.y - size.y
		velocity.y = 0
		grounded = true
	else:
		grounded = false



#func _on_mouse_entered() -> void:
	#print("Hello")
	#visible = false
	#pass # Replace with function body.
#
#
#func _on_mouse_exited() -> void:
	#print("Bye")
	#visible = true
	#
	#pass # Replace with function body.
