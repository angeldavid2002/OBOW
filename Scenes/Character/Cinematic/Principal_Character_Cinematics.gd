extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var anim:AnimatedSprite2D

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
