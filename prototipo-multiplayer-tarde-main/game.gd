extends Node2D

var peer = ENetMultiplayerPeer.new()
const ADDRESS = "127.0.0.1"
const PORT =  3333
@onready var log = $CanvasLayer/Log
@onready var ui = $MultiplayerUI
@onready var campoNick = $MultiplayerUI/Panel/CampoNick
@export var jogador_scene : PackedScene
var jogadores_nome = {}


#Exibir mensagem quando o servidor for criado e exibir mensagens sempre que
#um usuário se conectar
#Esconder menu de Multiplayer ao se conectar ou criar servidor com sucesso

#Na função de join, identificar se o jogador conseguiu se conectar. Se não conseguir
#exibir no log "Falha ao conectar ao servidor"
func _on_botao_join_pressed() -> void:
	var resultado = peer.create_client(ADDRESS, PORT)
	
	if resultado == OK:
		multiplayer.multiplayer_peer = peer
		multiplayer.connected_to_server.connect(sinal_criar_jogador)
		log.text += "Conectado ao servidor! \n"
		ui.visible = false
	else:
		log.text += "Não foi possivel se conectar! Erro: "+str(resultado)+"\n"


func _on_botao_host_pressed() -> void:
	var resultado = peer.create_server(PORT)
	
	if resultado == OK:
		multiplayer.multiplayer_peer = peer
		multiplayer.peer_connected.connect(player_conectado)
		log.text += "Servidor criado na porta "+str(PORT)+"!\n"
		adicionar_jogador(multiplayer.get_unique_id(), campoNick.text)
		ui.visible = false
		#criar personagem
	
	else:
		log.text += "Erro ao criar servidor! Código do erro: "+str(resultado) +"\n"
		
#Na função player_conectado realizar uma chamada rpc, para a função atualizar_log
#Deve rodar o adicionar_jogador
#Colocar um label no player para exibir o seu número de id
func sinal_criar_jogador():
	rpc_id(1, "adicionar_jogador", multiplayer.get_unique_id(), campoNick.text)
	
func player_conectado(id_jogador):
	log.text += "Cliente "+str(id_jogador)+" conectado ao servidor!\n"
	#Chamada rpc aqui
	rpc("atualizar_log", log.text)
	
@rpc("any_peer","call_local","reliable")
func adicionar_jogador(id_jogador, nick_jogador):
	if multiplayer.is_server():
		var novo_jogador = jogador_scene.instantiate()
		novo_jogador.name = str(id_jogador) 
		novo_jogador.nome_jogador = nick_jogador
		add_child(novo_jogador)
		jogadores_nome[id_jogador] = nick_jogador
		rpc_id(id_jogador,"atualizar_nomes", jogadores_nome)
		
		
@rpc("any_peer", "call_local", "reliable")
func atualizar_nomes(jogadores):
	for id in jogadores:
		var novo_jogador = get_node_or_null(str(id))
		if novo_jogador:
			novo_jogador.mudar_nome(jogadores[id])
			
	print(jogadores)
	
#Criar a função atualizar_log em que recebe o log.text do servidor e modifica o próprio log
@rpc("any_peer", "call_local", "reliable")
func atualizar_log(novo_log):
	log.text = novo_log

# Referência ao jogador (se já tiver um script de jogador, use o que já está configurado)
var player : Node = null


#botão amarelo
func _on_skinamarela_pressed() -> void:
	pass # Replace with function body.
func _on_skinamarela_mouse_entered() -> void:
	$MultiplayerUI/Fantasmaamarelo2.visible = true
func _on_skinamarela_mouse_exited() -> void:
	$MultiplayerUI/Fantasmaamarelo2.visible = false
	
	#botão verde
func _on_skinverde_pressed() -> void:
	pass # Replace with function body.
func _on_skinverde_mouse_entered() -> void:
	$MultiplayerUI/Fantasmaaverdee2.visible = true
func _on_skinverde_mouse_exited() -> void:
	$MultiplayerUI/Fantasmaaverdee2.visible = false

#botão azul
func _on_skinazul_pressed() -> void:
	pass # Replace with function body.
func _on_skinazul_mouse_entered() -> void:
	$MultiplayerUI/Fantasmaazul.visible = true
func _on_skinazul_mouse_exited() -> void:
	$MultiplayerUI/Fantasmaazul.visible = false

#Botão vermelho
func _on_skinamarela_5_pressed() -> void:
	pass # Replace with function body.
func _on_skinamarela_5_mouse_entered() -> void:
	$MultiplayerUI/Fantasmavermelho2.visible = true
func _on_skinamarela_5_mouse_exited() -> void:
	$MultiplayerUI/Fantasmavermelho2.visible = false

#botão ciano
func _on_skinciano_pressed() -> void:
	pass # Replace with function body.
func _on_skinciano_mouse_entered() -> void:
	$MultiplayerUI/Fantasmaciano2.visible = true
func _on_skinciano_mouse_exited() -> void:
	$MultiplayerUI/Fantasmaciano2.visible = false
	
#botão bege
func _on_skinbege_pressed() -> void:
	pass # Replace with function body.
func _on_skinbege_mouse_entered() -> void:
	$MultiplayerUI/Fantasmabege2.visible = true
func _on_skinbege_mouse_exited() -> void:
	$MultiplayerUI/Fantasmabege2.visible = false

#botão laranja
func _on_skinlaranja_pressed() -> void:
	pass # Replace with function body.
func _on_skinlaranja_mouse_entered() -> void:
	$MultiplayerUI/Fantasmalaranja2.visible = true
func _on_skinlaranja_mouse_exited() -> void:
	$MultiplayerUI/Fantasmalaranja2.visible = false

#botão purple
func _on_skinpurpura_pressed() -> void:
	pass
func _on_skinpurpura_mouse_entered() -> void:
	$MultiplayerUI/Fantasmapurpura2.visible = true
func _on_skinpurpura_mouse_exited() -> void:
	$MultiplayerUI/Fantasmapurpura2.visible = false

#botão rosa
func _on_skinpink_pressed() -> void:
	pass 
func _on_skinpink_mouse_entered() -> void:
	$"MultiplayerUI/Fantasmarosio2-Cópia".visible = true
func _on_skinpink_mouse_exited() -> void:
	$"MultiplayerUI/Fantasmarosio2-Cópia".visible = false
	
#botão roxo
func _on_skinroxo_pressed() -> void:
	pass 
func _on_skinroxo_mouse_entered() -> void:
	$MultiplayerUI/Fantasmaroxo2.visible = true
func _on_skinroxo_mouse_exited() -> void:
	$MultiplayerUI/Fantasmaroxo2.visible = false
	
#botão roxo claro
func _on_skinroxoclaro_pressed() -> void:
	pass
func _on_skinroxoclaro_mouse_entered() -> void:
	$MultiplayerUI/Fantasmaroxoclaro2.visible = true
func _on_skinroxoclaro_mouse_exited() -> void:
	$MultiplayerUI/Fantasmaroxoclaro2.visible = false
	
#botão verde mato
func _on_skinverdemato_pressed() -> void:
	pass 
func _on_skinverdemato_mouse_entered() -> void:
	$MultiplayerUI/Fantasmaverdemato2.visible = true
func _on_skinverdemato_mouse_exited() -> void:
	$MultiplayerUI/Fantasmaverdemato2.visible = false
	
#botão vermelho alaranjado
func _on_skinvermelhoalaranjado_pressed() -> void:
	pass
func _on_skinvermelhoalaranjado_mouse_entered() -> void:
	$MultiplayerUI/Fantasmavermelhoescuro2.visible = true
func _on_skinvermelhoalaranjado_mouse_exited() -> void:
	$MultiplayerUI/Fantasmavermelhoescuro2.visible = false
	
#botão azul claro
func _on_skinazulclaro_pressed() -> void:
	pass 
func _on_skinazulclaro_mouse_entered() -> void:
	$MultiplayerUI/Fantasmaazulclaro.visible = true
func _on_skinazulclaro_mouse_exited() -> void:
	$MultiplayerUI/Fantasmaazulclaro.visible = false

#botão all
func _on_all_mouse_entered() -> void:
	$MultiplayerUI/Fantasmaazulclaro.visible = true
	$MultiplayerUI/Fantasmavermelhoescuro2.visible = true
	$MultiplayerUI/Fantasmaverdemato2.visible = true
	$MultiplayerUI/Fantasmaroxoclaro2.visible = true

func _on_all_mouse_exited() -> void:
	$MultiplayerUI/Fantasmaazulclaro.visible = false
	$MultiplayerUI/Fantasmavermelhoescuro2.visible = false
	$MultiplayerUI/Fantasmaverdemato2.visible = false
	$MultiplayerUI/Fantasmaroxoclaro2.visible = false
