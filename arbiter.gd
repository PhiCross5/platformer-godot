extends Node

export var player_path="rh"
var respawn_point



var player 
var camera
var stages
var stageList = ["stage1.tscn","stage2.tscn"]
export var initialStage = 0
var stageNode
signal change_stage(index)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#set up available stages to skip between
	stages = Array()
	for url in stageList:
		stages.append(load(url))	
		
	assert(stages.size() > 0)
	stageNode=stages[initialStage].instance()
	add_child(stageNode)
	
	setup_signals()
	#hook up with player
	player = get_node(player_path)
	assert(player != null)
	
	pass # Replace with function body.

func switch_to_stage(index):
	stageNode.queue_free()
	stageNode=stages[index].instance()
	setup_signals()
	add_child(stageNode)
	player.translation=Vector3(0,0,0)

func setup_signals():
	#attach signals from child node.
	stageNode.connect("onSkip",self,"stage_onSkip")
	stageNode.connect("on_out_of_bounds",self,"stage_on_out_of_bounds")


func stage_onSkip(index):
	print("skipping to stage ", index)
	switch_to_stage(index)
	
	pass # Replace with function body.

func stage_on_out_of_bounds():
	player.translation=Vector3(0,0,0)
