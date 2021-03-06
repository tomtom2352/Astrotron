extends KinematicBody2D

const gravity = 50
const speed = 60
const FLOOR = Vector2(0, -1)

var hp
var velocity = Vector2();
var direction = 1

var is_dead = false 
# Called when the node enters the scene tree for the first time.

func _ready():
	hp = 100

func hit(damage):
	hp -= damage
	if hp <=0:
		dead()

func dead(): 
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead")
	$Timer.start()
	$CollisionShape2D.call_deferred("set_disabled", true)
	$BodyDetector/CollisionShape2D.call_deferred("set_disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if is_dead==false:
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		
		$AnimatedSprite.play("walk")
		velocity.x = speed*direction
		
		velocity.y += gravity
		
		velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
	
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1


func _on_Timer_timeout():
	queue_free()



func _on_BodyDetector_body_entered(body):
	body.die()
