extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var ray_cast: RayCast2D = $RayCast2D
@onready var tile_map: TileMap = %TileMap


var gravityDirection = Vector2i.DOWN
var slipness := false

var temp = [Vector2i.DOWN, Vector2i.UP, Vector2i.LEFT, Vector2i.RIGHT]
var i = 0
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("test"):
		i += 1
		if i > temp.size() -1:
			i = 0
		changeGravity(temp[i])
		print("now up is: ", temp)

func changeGravity(gDirection: Vector2i) -> void:
	if(gravityDirection != gDirection):
		gravityDirection = gDirection
		set_up_direction(Vector2(gDirection.x, -gDirection.y))
		self.rotate(deg_to_rad(180))
		collision_shape.rotate(deg_to_rad(180))
	
func Jump(jumpPower: float) -> void:
	velocity.y = jumpPower * gravityDirection.y

func _physics_process(delta: float) -> void:
	# just triyn to get that goddam tile atlas coord
	if ray_cast.is_colliding():
		var collision_point = ray_cast.get_collision_point()
		var tile_coords = tile_map.local_to_map(collision_point)  + Vector2i.UP
		var tile_atlas_coords = tile_map.get_cell_atlas_coords(1, tile_coords)
		if(tile_atlas_coords == Vector2i(6,2)):
			slipness = true
		else:
			slipness = false
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * gravityDirection.y

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		Jump(JUMP_VELOCITY)
	
	# Handle input
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flippin sprite on given direction and gravity
	if(gravityDirection.y == 1):
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
	else:
		if direction > 0:
			animated_sprite.flip_h = true
		elif direction < 0:
			animated_sprite.flip_h = false
	
	#play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jumpin")
	
	if direction:
		velocity.x = direction * SPEED
	elif slipness:
		velocity.x = move_toward(velocity.x, 0, 1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
