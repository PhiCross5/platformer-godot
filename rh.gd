extends KinematicBody

signal hit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


#physics parameters
var velocity =  Vector3(0,0,0)
const GRAVITY = Vector3(0,-1,0)
export var gravityMultiplier = 20

var gravityPull = 0
export var terminalVelocity = 75
export var terminalFall = 75
export var jumpingForce = 0.3
export var moveSpeed = 6
export var jumpingFallout = 0.3
var jumpHold : bool
var flip : bool = false

var originalBasis = transform.basis

#state machine definitions
enum {IDLE, WALKING, AIRBORNE, JUMPING}
export var currentState = WALKING

#child nodes controlled
var animator : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animator = get_node("MeshInstance/rh5-GEOMETRY/AnimationPlayer")
	jumpHold = false
	pass # Replace with function body.
	
func _physics_process(delta):
	#movement ATTEMPTED by the character
	var self_move = Vector3(0,0,0)
	

	#COMPUTE PHYSICS VECTORS 
	
	#EVALUATE FORCES AND COLLISION 
	stateMachine(delta);
	#velocity = self_move
	pass

func stateMachine(delta):
	#COMPÚTE MOVEMENT VECTOR
	var movement = Vector3.ZERO
	if (Input.is_action_pressed("ui_right")):
		flip = false
		movement += Vector3(1,0,0) * moveSpeed
		transform.basis = Basis.IDENTITY * originalBasis
	if (Input.is_action_pressed("ui_left")):
		flip = true
		movement += Vector3(-1,0,0) * moveSpeed
		transform.basis = Basis.FLIP_X * originalBasis
	#ACTUAL STATE MACHINE PART
	match currentState:
		IDLE:
			if movement != Vector3.ZERO:
				animator.play("run")
				currentState = WALKING
			jumpCheck()
		WALKING:
			#JUMPING ACTION
			jumpCheck()
			idleCheck(movement)
			if movement == Vector3.ZERO:
				currentState = IDLE
				pass
			move_and_slide(movement + (gravityPull * GRAVITY))
			if !get_last_slide_collision():
				currentState = AIRBORNE
				pass
			if !animator.is_playing():
				animator.play("run")
		AIRBORNE:
			if jumpHold:
				gravityPull = gravityPull + (gravityMultiplier * delta * jumpingFallout)
				if (!Input.is_action_pressed("ui_up") || gravityPull >0):
					jumpHold=false
			else:
				gravityPull = min(gravityPull+(gravityMultiplier * delta), terminalFall)
			var collision = move_and_collide((movement + (gravityPull * GRAVITY)) * delta)
			if collision and collision.normal.dot(Vector3(0,1,0))>0.9 :
				gravityPull= 0
				currentState = WALKING

	


func limitVector (vector, length):
	if(vector.length_squared() > length * length):
		return (vector.normalized() * length)
	else:
		return vector

func jumpCheck():
	var willJump = Input.is_action_pressed("ui_up")
	if willJump:
		jumpHold=true
		gravityPull = (-1 * jumpingForce * gravityMultiplier)
		currentState = AIRBORNE
func idleCheck(movement):
	if movement == Vector3.ZERO:
		currentState = IDLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

