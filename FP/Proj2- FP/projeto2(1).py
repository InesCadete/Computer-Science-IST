#Parte 2.1.1
#Contrutor
def cria_posicao(x,y):
    if type(x) != int or type(y) != int or x < 0 or y <0:
        raise ValueError("cria_posicao: argumentos invalidos")
    return (x,y)

def cria_copia_posicao(posicao):
    return (obter_pos_x(posicao), obter_pos_y(posicao))

#Seletores
def obter_pos_x(posicao):
    return posicao[0]

def obter_pos_y(posicao):
    return posicao[1]

#reconhecedores
def eh_posicao(posicao):
    return type(posicao) == tuple and \
        len(posicao) == 2 and \
        type(obter_pos_x(posicao)) == int and \
        type(obter_pos_y(posicao)) == int and \
        obter_pos_x(posicao) > 0 and \
        obter_pos_y(posicao) > 0
#teste
def posicoes_iguais(p1, p2):
    return obter_pos_x(p1) == obter_pos_x(p2) and \
        obter_pos_y(p1)  == obter_pos_y(p2)

def posicao_para_str(posicao):
    return "(" + str(obter_pos_x(posicao)) + ", " + str(obter_pos_y(posicao)) + ")"

#alto nivel
def obter_posicoes_adjacentes(posicao):
    tup_f = ()
    if obter_pos_y(posicao) - 1 >= 0:
    #adiciona a posicao adjacente de cima caso exista
        tup_f += ((obter_pos_x(posicao), obter_pos_y(posicao) - 1),)
    tup_f += ((obter_pos_x(posicao) + 1, obter_pos_y(posicao)),)
    tup_f += ((obter_pos_x(posicao), obter_pos_y(posicao) + 1),)
    if obter_pos_x(posicao) - 1 >= 0:
        tup_f += ((obter_pos_x(posicao) - 1, obter_pos_y(posicao)),)
    return tup_f

def ordenar_posicoes(tup):
    tup_y = ()
    tup_f = ()
    y = 0
    while len(tup_f) < len(tup):
        for tups in tup: 
            if obter_pos_y(tups) == y:
                tup_y += (tups,)
        for el in sorted(tup_y):
            tup_f += (el,)
        y += 1
        tup_y = ()
    return tup_f

#Parte 2.1.2
#construtor
def cria_animal(s,r,a):
    if type(s) != str or s == "" or \
        type(r) != int or r <= 0 or \
        type(a) != int or a < 0:
        raise ValueError("cria_animal: argumentos invalidos")
    return {"especie": s, "freq_reproducao": r, "freq_alimentacao": a, "idade": 0, "fome": 0}
# a1 = cria_animal("fox", 20, 10)
# a2 = {"freq_alimentacao": 10,"especie": "fox", "freq_reproducao": 20,  "idade": 0, "fome": 0}

def cria_copia_animal(a):
    return a.copy()

#seletores    
def obter_especie(a):
    return a["especie"]

def obter_freq_reproducao(a):
    return a["freq_reproducao"]

def obter_freq_alimentacao(a):
    return a["freq_alimentacao"]

def obter_idade(a):
    return a["idade"]

def obter_fome(a):
    return a["fome"]

#modificadores
def aumenta_idade(a):
    a["idade"] = obter_idade(a) + 1
    return a
# print("aumenta idade:", aumenta_idade(a1))

def reset_idade(a):
    a["idade"] = 0
    return a

def aumenta_fome(a):
    if obter_freq_alimentacao(a) > 0:
        a["fome"]= obter_fome(a) + 1
    return a

def reset_fome(a):
    a["fome"] = 0
    return a
# print("reset fome:", reset_fome({"especie": "fluff", "freq_reproducao": 7, "freq_alimentacao": 5, "idade": 0, "fome": 30}))

#reconhecedor
def eh_animal(a):
    return type(a) == dict and len(a) == 5 and \
        all(chave in a for chave in ["especie", "freq_reproducao", "freq_alimentacao", "idade", "fome"])
        # type(obter_especie(a)) == str and obter_especie(a) != "" and \
        # type(obter_freq_reproducao(a)) == int or obter_freq_reproducao(a) > 0 or \
        # type(obter_freq_alimentacao(a)) == int or obter_freq_alimentacao(a) >= 0

def eh_predador(a):
    return  eh_animal(a) and obter_freq_alimentacao(a) != 0

def eh_presa(a):
    return eh_animal(a) and obter_freq_alimentacao(a) == 0
# print("tem de ser false pq e predador: ", eh_presa(a1))

#teste
def animais_iguais(a1,a2):
    return eh_animal(a1) and eh_animal(a2) and \
        obter_especie(a1) == obter_especie(a2) and \
        obter_freq_reproducao(a1) == obter_freq_reproducao(a2) and \
        obter_freq_alimentacao(a1) == obter_freq_alimentacao(a2) and \
        obter_idade(a1) == obter_idade(a2) and \
        obter_fome(a1) == obter_fome(a2)
# print("animais sao iguais:", animais_iguais(a1, a2))

def animal_para_char(a):
    if eh_predador(a):
        return obter_especie(a)[0].upper()
    return obter_especie(a)[0].lower() 
# print("animal para char:" , animal_para_char(a1))

def animal_para_str(a):
    if eh_presa(a):
        return obter_especie(a) + " [" + str(obter_idade(a)) + \
        "/" + str(obter_freq_reproducao(a)) + "]"

    return obter_especie(a) + " [" + str(obter_idade(a)) + \
        "/" + str(obter_freq_reproducao(a)) + ";" + str(obter_fome(a)) + \
        "/" + str(obter_freq_alimentacao(a)) + "]" 
# print("animal para string:" , animal_para_str(a1))

def eh_animal_fertil(a):
 return obter_idade(a) >= obter_freq_reproducao(a)

def eh_animal_faminto(a):
    return eh_predador(a) and obter_fome(a) >= obter_freq_alimentacao(a)
         

def reproduz_animal(a):
    reset_idade(a)
    return reset_fome(cria_copia_animal(a))

# a3 = {"freq_alimentacao": 10,"especie": "fox", "freq_reproducao": 20,  "idade": 50, "fome": 50}

# print("reproduz animal (fome 0, rep 0):",  reproduz_animal(a3))

# print("agr este e o original(fome x, rep 0):" , a3)

#Parte 2.1.3
def cria_prado(d,r,a,p):
    if not eh_posicao(d) or obter_tamanho_x(d) <= 2 or obter_tamanho_y(d) <= 2 or \
       type(r) != tuple or len(r) < 0  or not all(eh_posicao(r1) for r1 in r) or \
       type(a) != tuple or len(a) <= 0 or not all(eh_animal(a1) for a1 in a)  or \
       type(p) != tuple or len(p) != len(a) or not all(eh_posicao(p1) for p1 in p):
       raise ValueError("cria_prado: argumentos invalidos")
    return {"tamanho": d, "rochedos": r, "animais": a, "pos_animais": p}

def cria_copia_prado(p):
    return {"tamanho": p["tamanho"] , "rochedos": p["rochedos"], \
         "animais": p["animais"], "pos_animais": p["pos_animais"]}

# Seletores
def obter_tamanho_x(p):
    return p["tamanho"][0] + 1 #pois comeca no 0

def obter_tamanho_y(p):
    return p["tamanho"][1] + 1

def obter_numero_predadores(p):
    num_pred = 0
    for ans in p["animais"]:
        if eh_predador(ans):
            num_pred += 1
    return num_pred

def obter_numero_presas(p):
    num_pres = 0
    for ans in p["animais"]:
        if eh_presa(ans):
            num_pres += 1
    return num_pres

def obter_posicao_animais(p):
    return ordenar_posicoes(p["pos_animais"])
    

def obter_animal(m,p):
    #ver index de p
    #dar return ao animal cujo index é igual ao index de p
    for index_pos in range(len(m["pos_animais"])):
        if m["pos_animais"][index_pos] == p:
            return m["animais"][index_pos]

def eliminar_animal(m,p):
    #buscar indice do animal depois de obter_animal
    #fazer slicing para tirar o animal e o mesmo para a posicao respetiva
    for index_an in range(len(m["animais"])):
        if m["animais"][index_an] == obter_animal(m,p):
            m["animais"] = m["animais"][:index_an] + m["animais"][index_an + 1:]
            break
            
    for index_pos in range(len(m["pos_animais"])): 
        if m["pos_animais"][index_pos] == p:
            m["pos_animais"] = m["pos_animais"][:index_pos] + m["pos_animais"][index_pos + 1:]
            break
    return m

def mover_animal(m,p1,p2):
    #substituir a p1 por p2 no m["pos_animais"]
    for index_pos in range(len(m["pos_animais"])): 
        if m["pos_animais"][index_pos] == p1:
            m["pos_animais"] = m["pos_animais"][:index_pos] + (p2,) + m["pos_animais"][index_pos + 1:]
            break
    return m

def inserir_animal(m,a,p):
    #acrescentar animal em m["animais"] e p em m["pos_animais"]
    m["animais"] += (a,)
    m["pos_animais"] += (p,)
    return m

#Reconhecedores
#prado1 = {"tamanho": (9,9), "rochedos": (), "animais": ("nala"), "pos_animais": (2,2)}

def eh_prado(arg):
    return type(arg) == dict and len(arg) == 4 and \
        all(chave in arg for chave in ["tamanho", "rochedos", "animais", "pos_animais"])
    #    type(arg["tamanho"]) == tuple and eh_posicao(arg["tamanho"]) and \
    #    type(arg["rochedos"]) == tuple and all(eh_posicao(r) for r in arg["rochedos"]) and \
    #    type(arg["animais"]) == tuple and all(eh_animal(a) for a in arg["animais"]) and \
    #    type(arg["pos_animais"]) == tuple and all(eh_posicao(p) for p in arg["pos_animais"])

def eh_posicao_animal(m,p):
    return p in m["pos_animais"]

def eh_posicao_obstaculo(m,p):
    #se estiver em m["rochedos"] ou se for montanha
    return p in m["rochedos"] or obter_pos_x(p) == 0 or obter_pos_y(p) == 0 or \
         obter_pos_x(p) == obter_tamanho_x(m) - 1 or obter_pos_y(p) == obter_tamanho_y(m) - 1

def eh_posicao_livre(m,p):
    return not eh_posicao_animal(m,p) and\
        not eh_posicao_obstaculo(m,p)

def prados_iguais(p1,p2):
    return eh_prado(p1) and eh_prado(p2) and \
        p1["tamanho"] == p2["tamanho"] and \
        len(p1["rochedos"]) == len(p2["rochedos"]) and all(r in p2["rochedos"] for r in p1["rochedos"]) and \
        len(p1["animais"]) == len(p2["animais"]) and all(a in p2["rochedos"] for a in p1["rochedos"]) and \
        len(p1["pos_animais"]) == len(p2["pos_animais"]) and all(r in p2["pos_animais"] for r in p1["pos_animais"])

#Transformador
def prado_para_str(m):
    tup_pos = ()
    index_y = 0
    while index_y < obter_tamanho_y(m):
        index_x = 0
        while index_x < obter_tamanho_x(m):
            tup_pos += ((index_x, index_y),)
            index_x += 1
        index_y += 1
    s_f = ""
    linha = ""
    for pos in tup_pos:
        
        # se for um dos quatro cantos - print "+"
        if (obter_pos_x(pos) == 0 and obter_pos_y(pos) == 0) or \
        (obter_pos_x(pos) == 0 and obter_pos_y(pos) == obter_tamanho_y(m) - 1) or \
        (obter_pos_x(pos) == obter_tamanho_x(m) - 1 and obter_pos_y(pos) == obter_tamanho_y(m) - 1): 
            linha += "+"
        if (obter_pos_x(pos) == obter_tamanho_x(m) - 1 and obter_pos_y(pos) == 0):
            linha += "+\n"
        #se tiver y = 0 ou y = obter_tamanho_y(p) - print "-"
        elif (obter_pos_y(pos) == 0 or obter_pos_y(pos) == obter_tamanho_y(m) - 1) and 0 < obter_pos_x(pos) < obter_tamanho_x(m) - 1:
            linha += "-"
        #se tiver x = 0 ou x = obter_tamanho_x(p) - print "|"
        elif obter_pos_x(pos) == 0 and 0 < obter_pos_y(pos) < obter_tamanho_y(m) - 1:
            linha += "|"
        elif obter_pos_x(pos) == obter_tamanho_x(m) - 1 and 0 < obter_pos_y(pos) < obter_tamanho_y(m) - 1:
            linha += "|" + "\n"
            
        # elif obter_pos_x(pos) == obter_tamanho_x(m) - 1:
        #     linha += "\n"
        # animais
        elif pos in m["pos_animais"]:
            linha += animal_para_char(obter_animal(m,pos))
        # rochedos
        elif pos in m["rochedos"]:
            linha += "@"
        elif 0 < obter_pos_y(pos) < obter_tamanho_y(m) - 1:
            linha += "."
    # print(linha)
    s_f += linha
    return s_f


        
#print(prado_para_str(cria_prado(cria_posicao(6,6), ((2,2),), ({"especie": "fluff", "freq_reproducao": 7, "freq_alimentacao": 5, "idade": 0, "fome": 30}, {"especie": "fluff1", "freq_reproducao": 7, "freq_alimentacao": 0, "idade": 0, "fome": 0}),((1,1),(1,3)))))

#funcoes alto nivel
def obter_valor_numerico(m,p):
    tup_pos = ()
    index_y = 0
    while index_y < obter_tamanho_y(m):
        index_x = 0
        while index_x < obter_tamanho_x(m):
            tup_pos += ((index_x, index_y),)
            index_x += 1
        index_y += 1
    for index_pos in range(len(tup_pos)):
        if p == tup_pos[index_pos]:
            return index_pos #ver index de p no tuplo com todas as posicoes

def obter_movimento(m,p):

    #tendo as posicoes adjacentes vamos adicionar as q n tem obstaculos e dar return a primeira do tup_f
    #para predadores, deps de tirar os obstaculos, ver se ha presas em alguma e adicionar essas pos ao tup_f
    tup_i = obter_posicoes_adjacentes(p)
    tup_f = ()
    for index_pos in range(len(tup_i)):
        if not eh_posicao_obstaculo(m,tup_i[index_pos]):
            #predador
            if eh_predador(obter_animal(m,p)):
                if eh_presa(obter_animal(m,tup_i[index_pos])):
                    tup_f += (tup_i[index_pos],)
                #dar prioridade as presas sobre posicoes vazias
                elif not eh_animal(obter_animal(m, tup_i[index_pos])):
                    tup_f += (tup_i[index_pos],)

            #presa
            elif eh_presa(obter_animal(m,p)) and \
                not eh_animal(obter_animal(m,tup_i[index_pos])):
                tup_f += (tup_i[index_pos],)
    return tup_f[obter_valor_numerico(m,p) % len(tup_f)] #aplicar a regra ao tuplo filtrado


# dim = cria_posicao
# obs = (cria_posicao(4, 2), cria_posicao(5, 2))
# an1 = tuple(cria_animal('rabbit', 5, 0) for i in range(3))
# an2 = (cria_animal('lynx', 20, 15),)
# pos = tuple(cria_posicao(p[0], p[1]) for p in ((5, 1), (9, 3), (10, 1), (6, 1)))
# prado = cria_prado(dim, obs, an1 + an2, pos)
# print(posicao_para_str(obter_movimento(prado, cria_posicao(6, 1))))


# def obter_movimento(m,p):

#     tup_i = obter_posicoes_adjacentes(p)
#     tup_f = ()
#     if eh_predador(obter_animal(m,p)):
#         #fazer tuplo de presas e se estiver vazio adicionar as posicoes todas
#         for index_pos in range(len(tup_i)):
#             if not eh_posicao_obstaculo(m,tup_i[index_pos]): #retirar obstaculos
#                 if eh_presa(obter_animal(m,tup_i[index_pos])):
#                     tup_f += (tup_i[index_pos],)

#         if tup_f == ():
#             for index_pos in range(len(tup_i)):
#                 if not eh_predador(obter_animal(m,tup_i[index_pos])) and not eh_posicao_obstaculo(m,tup_i[index_pos]):
#                     tup_f += (tup_i[index_pos],) #adicionar as posicoes vazias

#     elif eh_presa(obter_animal(m,p)):
#         for index_pos in range(len(tup_i)):
#             if not eh_posicao_obstaculo(m,tup_i[index_pos]) and not eh_animal(obter_animal(m,tup_i[index_pos])):
#                 tup_f += (tup_i[index_pos],)

#     return tup_f[obter_valor_numerico(m,p) % len(tup_f)] #aplicar a regra ao tuplo filtrado

# dim = cria_posicao
# obs = (cria_posicao(4, 2), cria_posicao(5, 2))
# an1 = tuple(cria_animal('rabbit', 5, 0) for i in range(3))
# an2 = (cria_animal('lynx', 20, 15),)
# pos = tuple(cria_posicao(p[0], p[1]) for p in ((5, 1), (9, 3), (10, 1), (6, 1)))
# prado = cria_prado(dim, obs, an1 + an2, pos)
# print(posicao_para_str(obter_movimento(prado, cria_posicao(6, 1))))


#funcoes adicionais

#geracao

#   Aumenta idade e fome
# 2. Animal tenta movimentarse:
    # a. Presas para posição livre
    # b. Predadores para posição com presa, ou alternativamente, para posição livre

# 3. Se conseguiu movimentar e atingiu idade de repodução
#  Animal reproduz

# 4. Se é predador e movimentou para posição de presa:
    # a. O predador se alimenta
    # b. A presa morre

# 5. Se é predador e fome igual a frequencia de alimentação
#  Predador morre

# def geracao(m):

#     for index_an in range(len(m["animais"])):
#         aumenta_fome(m["animais"][index_an])
#         aumenta_idade(m["animais"][index_an])
    
#     for index_pos in range(len(m["pos_animais"])):
#         m["pos_animais"][index_pos] = obter_movimento(m,m["pos_animais"][index_pos])

#     if 




#     return m
