extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var timer = float(0.0)
enum {RUMINANDO, AGUARDANDO}
var estado = AGUARDANDO
export var segundos_ruminar = 2
var animator : AnimationPlayer
var chumSeed 
# Called when the node enters the scene tree for the first time.
func _ready():
	animator = get_node("AnimationPlayer")
	chumSeed = fmod(randf(), segundos_ruminar)
	pass # Replace with function body.
func _physics_process(delta):
	match (estado):
		AGUARDANDO:
			timer +=delta
			if timer >= segundos_ruminar + chumSeed:
				timer=0
				animator.play("feed")
				estado = RUMINANDO
		RUMINANDO:
			if !animator.is_playing():
				estado = AGUARDANDO

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
