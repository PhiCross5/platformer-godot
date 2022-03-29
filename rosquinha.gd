extends Spatial

var animator: AnimationPlayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	animator = get_node("AnimationPlayer")
	animator.play("girar")
	pass # Replace with function body.

func _process(delta):
	if (not animator.is_playing()):
		animator.play("girar")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
