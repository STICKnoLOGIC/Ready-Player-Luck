extends Node2D

var lose_perecentage=0
var mouse_inside:bool=false
var isPressed:bool=false
var isRGB:bool=false
var rgbColors=[Color.RED,Color.BLUE, Color.GREEN,Color.DARK_ORCHID,Color.DARK_ORANGE,Color.DEEP_PINK,Color.TURQUOISE]
@export var nextColor:Color=Color.RED
var currentColorPos=0
@onready var key = $key
@onready var label = $label

func _ready():
	label.self_modulate=nextColor
	randomize()

func _process(_delta):
	if not isPressed and isRGB:
		label.self_modulate=lerp(label.self_modulate,nextColor,0.1)
	pass

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		mouse_inside=true
		if event.button_index == 1:
			isPressed=event.pressed
			if event.pressed:
				_win_or_lose()
			else:
				key.self_modulate=Color.WHITE
	elif event is InputEventScreenTouch:
		if event.index == 0:
			isPressed=event.pressed
			if event.pressed:
				_win_or_lose()
			else:
				key.self_modulate=Color.WHITE
				
	
func _on_mouse_exited():
	key.self_modulate=Color.WHITE
	mouse_inside=false


func _rg_next_color():
	currentColorPos+=1
	if currentColorPos>=rgbColors.size():
		currentColorPos=0
	nextColor=rgbColors[currentColorPos]
	pass # Replace with function body.

func _win_or_lose():
	key.self_modulate=Color.DARK_GRAY
	if randi_range(1,100) <= lose_perecentage:
		lose_perecentage=0
		Bridge.lost()
	else:
		lose_perecentage+=1
		Bridge.scored()
	pass
