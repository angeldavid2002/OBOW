extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var anim:AnimatedSprite2D
@export var vida:int
@export var texto:Label
@export var alive:bool=true
@export var HurtBox:CollisionShape2D
@export var HitBox:CollisionShape2D
@export var Dmg:float
var bloqueado: bool = false 

func _ready() -> void:
	texto.text = "vida: "+ str(vida)
	HitBox.disabled=true
	Dmg=13

func _physics_process(delta: float) -> void:
	HitBox.disabled=true
	gravity(delta)
	move_and_slide()
	if(vida<=0):
			alive=false
	if(alive):
		if(not bloqueado):
			move()
			animations()
	else:
		if(HurtBox.disabled==false):
			anim.play("Death")
		HurtBox.disabled=true

func move():
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = get_direction_x()
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func get_direction_x()->int:
	if Input.is_action_pressed("right"):
		return 1
	elif(Input.is_action_pressed("left")):
		return -1
	else:
		return 0

func gravity(delta:float):
	if not is_on_floor():
		velocity += get_gravity() * delta

func animations():
	if(velocity.x<0):
		anim.flip_h=true
		HitBox.position.x=-14
	elif(velocity.x>0):
		anim.flip_h=false
		HitBox.position.x=14
	
	if(Input.is_action_pressed("attack")):
		anim.play("Attack")
		if(anim.frame==1 or anim.frame==5 or anim.frame==6):
			HitBox.disabled=false
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

func _on_hurt_area_area_entered(area: Area2D) -> void:
	if(area.collision_layer==8):
		vida=vida-10
		texto.text = "vida: "+ str(vida)
		anim.modulate="ff0000"
		anim.play("Hurt")
		bloqueado=true
		await anim.animation_finished
		bloqueado=false

func _on_hurt_area_area_exited(area: Area2D) -> void:
	if(area.collision_layer==8):
		anim.modulate=Color.WHITE

func is_alive()->bool:
	return alive
