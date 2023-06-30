extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var slading = false
var target
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		_animated_sprite.play("Jump")
		velocity.y += gravity * delta
		
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		
		velocity.y = JUMP_VELOCITY
	print_orphan_nodes()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		if is_on_floor():
			_animated_sprite.play("Run")
		velocity.x = direction * SPEED
	else:
		if is_on_floor():
			_animated_sprite.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if slading == true:
		_animated_sprite.play("Slide")
		velocity.x += 10
		if velocity.x > target:
			slading == false
		
	if Input.is_action_just_pressed("Slide"):
		print("asd")
		target = velocity.x + 50 
		slading = true
		_animated_sprite.play("Slide")

	move_and_slide()
