extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var anim:AnimatedSprite2D

func _physics_process(delta: float) -> void:
	#print("Posicion x: ",position.x," Posicion Y: ",position.y)
	#print("Velocity x: ",velocity.x," Velocity Y: ",velocity.y)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	animations()
	move_and_slide()
	
func animations():
	
	if(velocity.x<0):
		anim.flip_h=true
	elif(velocity.x>0):
		anim.flip_h=false
	
	if(Input.is_key_pressed(KEY_X)):
		anim.play("Attack")
	elif (velocity.y<0):
		anim.play("Jump")
	elif(velocity.y>0):
		anim.play("Fall")
	elif(velocity.x>0):
		anim.play("Run")
	elif(velocity.x<0):
		anim.play("Run")
	elif(is_on_floor() and Input.is_action_pressed("ui_down")):
		anim.play("Down")
	elif(is_on_floor()):
		anim.play("Idle")

func RunRight():
	anim.play("Run")
	anim.flip_h=false

func RunLeft():
	anim.play("Run")
	anim.flip_h=true

func IdleAnim():
	anim.play("Idle")

func Jump():
	anim.play("Jump")
