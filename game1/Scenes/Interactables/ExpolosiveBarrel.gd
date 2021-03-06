extends RigidBody2D


export (int) var damage
export (int) var type
var hits
var primed 


# Called when the node enters the scene tree for the first time.
func _ready():
	hits = 0
	if type == 0:
		$AnimatedSprite.play("default")
	elif type == 1:
		$AnimatedSprite.play("redCell")

func _process(delta):
	if $AnimatedSprite.get_frame() == 8:
		$AnimatedSprite.visible = false
		$Particles2D.visible = false

func hit(damage, hitBy, knock, type):
	hits += 1
	if hits == 3 || type == 1:
		$Timer.stop()
		$audio.play()
		$Explosion.explode()
		$AnimatedSprite.visible = false
		$Particles2D.visible = false
		yield(get_tree(), "idle_frame")
		$Area2D/CollisionShape2D.disabled = false
	elif hits == 2 && !primed:
		$Timer.start()
		$Particles2D.emitting = true
		primed = true
	


func _on_Area2D_body_entered(body):
	if body.has_method("hit"):
		body.hit(damage, self, true, 1)


func _on_Timer_timeout():
	$audio.play()
	$Explosion.explode()
	$AnimatedSprite.visible = false
	$Particles2D.visible = false
	$Area2D/CollisionShape2D.disabled = false


func _on_audio_finished():
	queue_free()
