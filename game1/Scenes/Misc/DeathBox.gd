extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DeathBox_body_entered(body):
	if "Character" in body.name:
		body.die()
	elif body.is_in_group("bodies"):
		body.queue_free()
