extends Camera

export var target_path = "../stage/rh"
var target: Spatial
export var afastamento : Vector3 = Vector3(0,9,47)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node(target_path)
	pass # Replace with function body.

func _physics_process(delta):
	transform.origin = target.transform.origin + afastamento

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
