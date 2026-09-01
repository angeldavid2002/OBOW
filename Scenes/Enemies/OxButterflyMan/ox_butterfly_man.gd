extends CharacterBody2D


const SPEED = 100.0
@export var Rayo:RayCast2D
@export var Anim:AnimatedSprite2D
@export var HpAnim:AnimatedSprite2D
@export var Target:Node2D=null
@export var Collision:CollisionShape2D
@export var HitBox:CollisionShape2D
@export var HurtBox:CollisionShape2D
@export var HurtArea:Area2D
@export var vida:int
@export var vidaInicial:int
@export var alive:bool=true

func _ready() -> void:
	HitBox.disabled=true
	vidaInicial=vida

func _physics_process(delta: float) -> void:
	HitBox.disabled=true
	if(vida<=0):
		alive=false
	healthBarManager()
	
	if(alive):
		animations()
		follow()
		gravity(delta)
		move_and_slide()
	else:
		if(HurtBox.disabled==false):
			Anim.play("Death")
			HurtBox.disabled=true
			HitBox.set_deferred("disabled", true)
			Collision.set_deferred("disabled", true)
			Rayo.enabled=false

func gravity(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta

func follow():
	if(Target!=null and not Rayo.is_colliding() and Target.is_alive()):
		velocity.x = position.direction_to(Target.position).x * SPEED
	elif(not Target.is_alive()):
		Rayo.enabled=false

func animations():
	if(velocity.x<0):
		Anim.flip_h=true
		Rayo.rotation_degrees = 90
		HitBox.position.x=-14
	elif(velocity.x>0):
		Anim.flip_h=false
		Rayo.rotation_degrees = 270
		HitBox.position.x=14
	if(Rayo.is_colliding()):
		var collider= Rayo.get_collider()
		if(collider.name=="Character"):
			Anim.play("Attack")
			if(Anim.frame==3 or Anim.frame==4):
				HitBox.disabled=false
	elif(velocity.x>25):
		Anim.play("Walk")
	elif(velocity.x<-25):
		Anim.play("Walk")
	else:
		Anim.play("Idle")

func healthBarManager():
	if(vida<=healthPercentage(0)):
		HpAnim.play("0")
	elif(vida<=healthPercentage(25)):
		HpAnim.play("25")
	elif(vida<=healthPercentage(50)):
		HpAnim.play("50")
	elif(vida<=healthPercentage(75)):
		HpAnim.play("75")
	if(vida==vidaInicial):
		HpAnim.play("100")

func healthPercentage(porcentaje: int)->float:
	return (vidaInicial/100)*porcentaje

func _on_hurt_area_area_entered(area: Area2D) -> void:
	if(area.collision_layer==16):
		Anim.modulate="ff0000"
		HpAnim.modulate=Color(1, 1, 1) * 3.0  
		vida=vida-Target.Dmg

func _on_hurt_area_area_exited(area: Area2D) -> void:
	if(area.collision_layer==16):
		Anim.modulate=Color.WHITE
		HpAnim.modulate=Color.WHITE
