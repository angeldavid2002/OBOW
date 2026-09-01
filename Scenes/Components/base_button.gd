extends Button

var custom_action: Callable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if custom_action.is_valid():
		custom_action.call()
	else:
		print("No se ha asignado ninguna acción a este botón.")
