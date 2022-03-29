extends Area

export var quad_url = "victory_board.tscn"
var board = load(quad_url)
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



func _on_Destination2_body_entered(body):
	print("player has reached final destination.")
	add_child(board.instance())
	pass # Replace with function body.
