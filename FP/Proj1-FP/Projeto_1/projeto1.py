#Projeto1- LEIC - Ines Cadete - ist1102935

#Parte1
#1.2.1
def corrigir_palavra(pal):
    """
    1.2.1 corrigir palavra: cad. carateres → cad. carateres
    A funcao recebe uma cadeia de carateres e apaga os pares de letras maiuscula-minuscula, devolvendo-a corrigida
    """
    i = 0
    lst_pal = list(pal)
    while i < len(lst_pal)- 1:
        if abs(ord(lst_pal[i]) - ord(lst_pal[i + 1])) == abs(ord("A")-ord("a")): #se for par de maiúscula e minúscula (codigo UTF8)
            del (lst_pal[i])
            del (lst_pal[i]) #apaga o par de elementos
            i -= 1 #nao avanca uma unidade porque a lista atualizou
        else:
            i += 1
    pal_f = "".join(lst_pal) #converte lista para string
    return pal_f

#1.2.2  
def eh_anagrama(pal1,pal2):
    """
    1.2.2 eh anagrama: cad. carateres × cad. carateres → booleano
    A funcao recebe duas cadeias de carateres correspondentes a duas palavras e devolve
    True se forem anagramas, ignorando maiusculas e minusculas 
    """
    pal1 = pal1.lower()
    pal2 = pal2.lower() #considerar letras maiusculas = minusculas
    return sorted(pal1) == sorted(pal2)

#1.2.3
def corrigir_doc(doc):
    """
    1.2.3 corrigir doc: cad. carateres → cad. carateres
    Recebe uma cadeia de carateres e corrige palavras com pares maiuscula-minuscula
    e apaga anagramas, devolvendo uma cadeia de carateres ou
    gerando ValueError caso a cadeia de carateres nao seja constituida por letras (e espacos)
    ou se tiver mais do que um espaco entre palavras
    """
    if type(doc) != str or doc == " ":
        raise ValueError("corrigir_doc: argumento invalido")

    lst_doc = doc.split() #converter string inicial para lista (de palavras) sem espacos
    lst2_doc = []
    for pal in lst_doc:
        if not pal.isalpha(): #verificar se os carateres sao do alfabeto
            raise ValueError("corrigir_doc: argumento invalido")
    if " ".join(lst_doc) != doc: #verificar se a lista tem apenas 1 espaço entre palavras
            #e ver se a lista (palavras juntas com apenas um espaço- join) e igual a inicial
                raise ValueError("corrigir_doc: argumento invalido")

    for pal in lst_doc: #dividir palavras da lst_doc em letras
        lst2_doc += [corrigir_palavra(pal)] #adicionar as palavras corrigidas a lista vazia

    index_pal1 = 0
    index_pal2 = 1
    while index_pal1 < len(lst2_doc) - 1: 
        while index_pal2 < len(lst2_doc) :
            if eh_anagrama(lst2_doc[index_pal1], lst2_doc[index_pal2]) and\
            lst2_doc[index_pal1].lower() != lst2_doc[index_pal2].lower():
                del lst2_doc[index_pal2]
            else:
                index_pal2 += 1 #apenas avança caso nao seja anagrama pois a lista atualiza
                
        index_pal1 += 1 
        index_pal2 = index_pal1 + 1

    lst2_doc= " ".join(lst2_doc) #converte a lista para string com um espaco entre palavras
    return lst2_doc

#Parte 2
#2.2.1
def obter_posicao(let,n):
    """
    2.2.1 obter posicao: cad. carateres × inteiro → inteiro
    Esta funcao recebe um carater (‘C’, ‘B’, ‘E’ ou ‘D’) que representa
    a direcao de um unico movimento  e um inteiro (1, 2, 3, 4, 5, 6, 7, 8 ou 9) representando a
    posicao incial e devolve o inteiro que corresponde a nova posicao
    """
    if (n == 1 or n == 2 or n ==3) and let == "C": #restricao para numeros das extremidades
        return n
    elif (n == 7 or n == 8 or n == 9) and let == "B":
        return n
    elif (n == 1 or n == 4 or n ==7) and let == "E":
        return n
    elif (n == 3 or n == 6 or n == 9) and let == "D":
        return n
    else:
        if let == "C" and n >3:
            n -= 3
        elif let == "B" and n<7:
            n += 3
        elif let == "D" and n % 3:
            n += 1
        else:
            n -= 1    
        return n

#2.2.2
def obter_digito(lets,n):
    """
    2.2.2 obter digito: cad. carateres × inteiro → inteiro
    Recebe varias letras (‘C’, ‘B’, ‘E’ ou ‘D’) e, começando no numero n, devolve a posicao final do digito
    """
    for letra in lets:
        n = obter_posicao(letra,n)
    return n

#2.2.3
def obter_pin(t):
    """
    2.2.3 obter pin: tuplo → tuplo
    Recebe um tuplo contendo entre 4 e 10 sequencias de carateres(movimentos) e devolve
    o tuplo de inteiros que contˆem o pin codificado de acordo com o tuplo de movimentos.
    Caso o argumento nao seja tuplo ou nao tenha entre 4 e 10 sequencias, gera um ValueError
    """
    tuplo_final = ()
    a = 5 #posicao inicial
    letras_poss = ["C", "B", "E","D"]
    if type(t) != tuple or len(t) < 4 or len(t) > 10:
        raise ValueError("obter_pin: argumento invalido")
    for seq in t:
        if len(seq) == 0:       
            raise ValueError("obter_pin: argumento invalido")
        for let in seq:
            if let not in letras_poss:
                raise ValueError("obter_pin: argumento invalido")
    for seq in range(len(t)):
        tuplo_final += (obter_digito(t[seq], a),)
        a = obter_digito(t[seq],a)
    return tuplo_final

#Parte 3
#3.2.1
def eh_entrada(cad):
    """
    3.2.1 eh entrada: universal → booleano
    Recebe um argumento de qualquer tipo e devolve True se o mesmo
    corresponde a um tuplo com 3 campos: duas cadeias de carateres e um tuplo
    """

    def check_min_traco(cad):
        for let in cad:
            if not ((let.isalpha() and let.islower()) or let == "-"):
                #se nao for letra minusculao ou espaco- return False
                return False
        return True
    
    def check_min(cad):
        for let in range(1,len(cad)-1):
            if not (cad[let].isalpha() and cad[let].islower()):
                #se nao for letra minuscula- return False
                return False
        return True
    
    def num_pos(cad): #verifica se o tuplo contem apenas numeros inteiros
        for num in cad[2]:
            if type(num) != int or num < 0:
                return False
        return True

    return type(cad) == tuple and \
       len(cad) == 3 and \
       type(cad[0]) == str and \
       len(cad[0]) >= 1 and \
       check_min_traco(cad[0]) and \
       cad[0][0] != "-" and \
       cad[0][-1] != "-" and \
       type(cad[1]) == str and \
       len(cad[1]) == 7 and \
       check_min(cad[1]) and \
       cad[1][0] == "[" and \
       cad[1][-1] == "]" and \
       type(cad[2]) == tuple and \
       len(cad[2]) >= 2 and \
       num_pos(cad)
       
#3.2.2
def conta_ocorren(cif):
    """
    3.2.2 validar cifra: cad. carateres × cad. carateres → booleano
    Recebe uma cadeia de carateres contendo uma cifra e uma outra cadeia de
    carateres contendo uma sequencia de controlo, e devolve True se a sequencia de
    controlo e coerente com a cifra 
    """
    dic_let = {}
    lst_string= list(cif)
    a = sorted(lst_string) #fica ordenado alfabeticamente
    for el in a:
        if el != "-":
            dic_let[el] = a.count(el)
    #devolve as chaves do dicionario ordenadas pela ocorrencia (descendente)        
    lf = sorted(dic_let, key=dic_let.get, reverse = True)
    dic_let = sorted(dic_let)

    return lf

def validar_cifra(cif, ctrl):
    string_final = "["
    for let in range(5):
        string_final += conta_ocorren(cif)[let]
    string_final += "]" 
    return string_final == ctrl

#3.2.3
def filtrar_bdb(bdb):
    """
    3.2.3 filtrar bdb: lista → lista
    Recebe uma lista contendo uma ou mais entradas da BDB (tuplo com 3 campos:
    duas cadeias de carateres e um tuplo) e devolve apenas
    a lista contendo as entradas em que o checksum nao e coerente com a cifra correspondente,
    na mesma ordem da lista original. Tambem verifica se a entrada e lista nao vazia
    com entradas validas
    """
    lf = []
    if type(bdb) != list or bdb == " ":
        raise ValueError("filtrar_bdb: argumento invalido")
    for entrada in range(len(bdb)):
        if not eh_entrada(bdb[entrada]):
            raise ValueError("filtrar_bdb: argumento invalido")

        if not validar_cifra(bdb[entrada][0], bdb[entrada][1]):
            lf += (bdb[entrada],) 

    return lf

#parte 4
#4.2.1 = 3.2.1
#4.2.2
def obter_num_seguranca(tup_num):
    """
    4.2.2 obter num seguranca: tuplo → inteiro
    Esta funcao recebe um tuplo de numeros inteiros positivos e
    devolve o numeros de seguranca conforme descrito (a menor diferenca positiva
    entre qualquer par de numeros).
     """
    lista_nums = list(tup_num)
    num_seg = abs(lista_nums[0] - lista_nums[1])
    index_num1 = 0
    index_num2 = 2 #começar pelo segundo pois dif_menor ja tem a dif do primeiro
    while index_num1 < len(lista_nums):
        while index_num2 < len(lista_nums) :
            dif = abs(lista_nums[index_num1]- lista_nums[index_num2]) #menor diferenca entre elementos
            if dif < num_seg :
                num_seg = dif
            index_num2 += 1
        index_num1 += 1 
        index_num2 = index_num1 + 1 #avanca mais um para comparar com o proximo
    return num_seg

#4.2.3
def decifrar_texto(cad, numseg):
    """
    4.2.3 decifrar texto: cad. carateres × inteiro → cad. carateres
    Recebe uma cadeia de carateres contendo uma cifra e um numero de seguranca,
    e devolve o texto decifrado conforme descrito.
    """
    l_let = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]   
    l_cad = list(cad)       
    sf = ""
    n = (numseg % 26) #numero de index a passar
    for index_letra in range(len(l_cad)):
        if l_cad[index_letra] == "-":
            l_cad[index_letra] = " "
        else:
            #subtrair 26 (len(l_cad)) e adicionar o numero a andar para chegar ao index desejado
            if index_letra % 2 == 0: 
                l_cad[index_letra] = l_let[n + l_let.index(l_cad[index_letra]) - 26 + 1]
                
            elif index_letra % 2 == 1: 
                l_cad[index_letra] = l_let[n + l_let.index(l_cad[index_letra]) - 26 - 1]
    for letra in l_cad:
        sf += letra 
    return sf

#4.2.4
def  decifrar_bdb(bdb):
    """
    4.2.4 decifrar bdb: lista → lista
    recebe uma lista contendo uma ou mais entradas da BDB e devolve uma lista
    , contendo o texto das entradas decifradas na mesma ordem.
    Tambem verifica se a lista contem apenas entradas
    """
    lf = []
    for entrada in range(len(bdb)): 
        if type(bdb) != list or not eh_entrada(bdb[entrada]):   
            raise ValueError("decifrar_bdb: argumento invalido")
        else:
            lf.append(decifrar_texto(bdb[entrada][0], obter_num_seguranca(bdb[entrada][2])))
            #adiciona os elementos errados a lista final
    return lf

#parte 5 
#5.2.1
def eh_utilizador(cad):
    """
    5.2.1 eh utilizador: universal → booleano
    Recebe um argumento de qualquer tipo e devolve True se o seu
    argumento corresponde a um dicionario contendo nome, senha e regra individual.
    """
    chaves = ["name", "pass", "rule"]
    return type(cad) == dict and len(cad) == 3 and \
        all(chave in cad for chave in ["name", "pass", "rule"]) and \
        type(cad["name"]) == str and cad["name"] != "" and \
        type(cad["pass"]) == str and cad["pass"] != "" and \
        type(cad["rule"]) == dict and len(cad["rule"]) == 2 and \
        type(cad["rule"]["vals"]) == tuple and len(cad["rule"]["vals"]) == 2 and \
        cad["rule"]["vals"][0] <= cad["rule"]["vals"][1] and \
        cad["rule"]["vals"][0] > 0 and cad["rule"]["vals"][1] >= 0 and \
        type(cad["rule"]["char"]) == str and len(cad["rule"]["char"]) == 1

#5.2.2
def eh_senha_valida(cad, dic):
    """
    5.2.2 eh_senha_valida: cad. carateres × dicionario → booleano 
    Recebe uma cadeia de carateres correspondente a uma senha e um dicionario
    e devolve True se a senha cumpre com todas as regras de definicao
    gerais- 3 vogais e pelo menos 1 carater repetido e individuais- numero de ocorrencias
    de um carater
    """
    conta_vog = 0
    repetido = 0
    list_cad = list(cad)
    list_vog = ["a","e","i","o","u"]
    for carater in cad:
        if carater in list_vog:
            conta_vog += 1
    sorted(list_cad)
    for index_car in range(len(list_cad) - 1):
        if list_cad[index_car] == list_cad[index_car + 1]:
            #estando ordenados, se houver repetidosna lista, estao consecutivos
            repetido += 1
    
    return conta_vog >= 3 and repetido >= 1 and \
        cad.count(dic["char"]) >= dic["vals"][0] and \
        cad.count(dic["char"]) <= dic["vals"][1]

#5.2.3
def filtrar_senhas(bdb):
    """
    5.2.3 filtrar senhas: lista → lista
    Recebe uma lista contendo um ou mais dicionarios (entradas da BDB),
    e devolve a lista ordenada alfabeticamente com os nomes dos utilizadores com senhas erradas. 
    Tambem gera um ValueError se nao os elementos da lista nao forem validos.
    """
    lista_inicial = []
    if type(bdb) != list or len(bdb) < 1:
        raise ValueError("filtrar_senhas: argumento invalido")
    for dic in bdb:    
        if type(dic) != dict or not eh_utilizador(dic):
            raise ValueError("filtrar_senhas: argumento invalido")
        else:   
            if not eh_senha_valida(dic["pass"], dic["rule"]): 
                lista_inicial.append(dic["name"])
                #adiciona os elementos que nao sao senhas
    lista_final = sorted(lista_inicial)
    return lista_final