extends CharacterBody2D

const SPEED = 300.0
@onready var rotulo_nome = $NomeJogador
var nome_jogador = "Anônimo"
var cor_jogador = ""
func _enter_tree() -> void:

	set_multiplayer_authority(name.to_int())
	
func _ready() -> void:
	rotulo_nome.text = nome_jogador
	if (is_multiplayer_authority()):
		var camera = Camera2D.new()
		add_child(camera)
		camera.zoom = Vector2(3.5, 3.5)
	
func mudar_nome(novo_nome):
	nome_jogador = novo_nome
	rotulo_nome.text = novo_nome
# Referência à sprite do jogador
	var player_sprite : Sprite2D
# Armazenar a cor da skin ou o nome do arquivo
	var current_skin : String = "default"  # Exemplo inicial, a skin padrão pode ser "default"

# Função para mudar a skin do jogador
#func change_skin(skin_color: String):
	#current_skin = skin_color
	
	# Dependendo da skin escolhida, troque a textura
	#match skin_color:
	#	"rosa":
		#	player_sprite.texture = load("")  # Caminho da textura
		#"azul":
		#	player_sprite.texture = load("")  # Outro caminho de textura
		# Adicione outras skins conforme necessário
		#_:
		#	player_sprite.texture = load("")  # Valor padrão

# Se não tiver um "player_sprite", você pode configurar isso no _ready  # Supondo que seu sprite esteja dentro do nó

func _physics_process(delta: float) -> void:
	if (is_multiplayer_authority()):
		
		var direction_horizontal := Input.get_axis("ui_left", "ui_right")
		if direction_horizontal:
			velocity.x = direction_horizontal * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
		var direction_vertical := Input.get_axis("ui_up", "ui_down")
		if direction_vertical:
			velocity.y = direction_vertical * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
