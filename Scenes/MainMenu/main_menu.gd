extends Control


@export var PlayButton:BaseButton
@export var InstructionsButton:BaseButton
@export var ExitButton:BaseButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayButton.custom_action=play
	InstructionsButton.custom_action=instructions
	ExitButton.custom_action=exit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play() ->void:
	get_tree().change_scene_to_file("res://Scenes/Test_Scene.tscn")
	pass

func instructions() ->void:
	pass

func exit() -> void:
	get_tree().quit()
