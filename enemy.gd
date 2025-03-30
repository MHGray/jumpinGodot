extends Window

class_name Enemy

@export var speed:float
var velocity:Vector2
@export var _position:Vector2
var grounded:bool
var screenBoundsSize:Vector2i
var decision_cooldown_max:float = 1
var decision_cooldown:float = decision_cooldown_max
var doing:THINGS_TO_DO
var distance:float
var main_menu:My_Window

enum THINGS_TO_DO {
	WALK_LEFT,WALK_RIGHT,JUMP
}

func _ready() -> void:
	main_menu = get_parent()
	screenBoundsSize = DisplayServer.screen_get_size()
	_position = Vector2(randi_range(0,screenBoundsSize.x),randi_range(0,screenBoundsSize.y))

func _process(delta: float) -> void:
	distance = main_menu.mousepos.distance_to(position + size/2)
	 
	if !visible:
		print(floor(distance))
		if distance > 70:
			visible = true
			pass
	else:
		if distance <= 70:
			visible = false
			pass
	
	decide_what_to_do(delta)
	match doing:
		
		THINGS_TO_DO.WALK_LEFT:
			_position.x -= speed * delta
		THINGS_TO_DO.WALK_RIGHT:
			_position.x += speed*delta
		THINGS_TO_DO.JUMP:
			if grounded:
				velocity.y -= 40
				decision_cooldown = 0
				grounded = false
	if !grounded:
		velocity.y += 100 * delta
	#check if grounded
	_position += Vector2(velocity)
	if _position.x < 0:
		decision_cooldown = 0
		_position.x = 0
	elif _position.x + size.x > screenBoundsSize.x:
		_position.x = screenBoundsSize.x - size.x
		decision_cooldown = 0
		
	if _position.y + size.y >= screenBoundsSize.y:
		_position.y = screenBoundsSize.y - size.y
		velocity.y = 0
		grounded = true
	else:
		grounded = false
	position = Vector2i(_position)

func decide_what_to_do(delta:float) -> void:
	decision_cooldown -= delta
	if decision_cooldown > 0: return
	decision_cooldown = decision_cooldown_max
	var num_things = THINGS_TO_DO.keys().size()
	var new_action = randi_range(0, num_things) 
	if doing == new_action:
		doing = THINGS_TO_DO.JUMP
	else:
		doing = new_action
	pass
