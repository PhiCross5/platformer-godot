extends Spatial

var skipper 

signal onSkip(index)
signal on_out_of_bounds
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _on_skipper_crossed(index):
	print("skipper triggered! to stage ", index)
	emit_signal("onSkip",index)
	pass # Replace with function body.


func _on_boundary_body_entered(body):
	print("boundary triggered! out of bounds.")
	emit_signal("on_out_of_bounds")
	pass # Replace with function body.
