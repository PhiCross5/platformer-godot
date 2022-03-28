extends Area

signal crossed(index)

export var destination = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	monitoring = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_skipper_area_entered(area):
	pass # Replace with function body.


func _on_skipper_body_entered(body):
	print("entered skipper to stage ", destination, 
	"intersected by: ", body)
	emit_signal("crossed",destination)
	pass # Replace with function body.
