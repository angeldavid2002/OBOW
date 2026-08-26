extends CharacterBody2D


const SPEED = 100.0
@export var Rayo:RayCast2D
@export var Anim:AnimatedSprite2D
@export var Target:Node2D=null

func _physics_process(delta: float) -> void:
	print(Rayo.rotation_degrees)
	animations()
	follow()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func follow():
	if(Target!=null and not Rayo.is_colliding()):
		velocity.x = position.direction_to(Target.position).x * SPEED

func animations():
	
	if(velocity.x<0):
		Anim.flip_h=true
		Rayo.rotation_degrees = 90
	elif(velocity.x>0):
		Anim.flip_h=false
		Rayo.rotation_degrees = 270
	
	if(Rayo.is_colliding()):
		var collider= Rayo.get_collider()
		if(collider.name=="Character"):
			Anim.play("Attack")
	elif(velocity.x>25):
		Anim.play("Walk")
	elif(velocity.x<-25):
		Anim.play("Walk")
	else:
		Anim.play("Idle")
