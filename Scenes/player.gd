extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

# Reference your sprite node here (change "Sprite2D" if named differently)
@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		# Flip the sprite based on direction
		if direction < 0:
			sprite.flip_h = true   # Face left
		elif direction > 0:
			sprite.flip_h = false  # Face right
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
