def print_parking_state(state):
    symbols = {
        0: '🟢',  # Available
        1: '🔴'   # Occupied
    }

    custom_symbols = {
        0: '🔵',  # Vaga 1 (PCs)
        1: '🟡',  # Vaga 2 (Deficientes)
        2: '🟡'   # Vaga 3 (Deficientes)
    }

    floor_names = ["Térreo", "1º Andar", "2º Andar"]
    total_cars = 0

    # Iterar em ordem inversa
    for floor_index in range(len(state) - 1, -1, -1):
        floor = state[floor_index]
        floor_name = floor_names[floor_index]
        print(f"{floor_name}:", end=" " * (10 - len(floor_name)))  # Adjust spacing
        for slot_index, slot in enumerate(floor):
            if slot['state'] == 1:
                total_cars += 1
            if slot_index in custom_symbols:
                symbol = custom_symbols[slot_index] if slot['state'] == 0 else symbols[slot['state']]
            else:
                symbol = symbols[slot['state']]
            print(symbol, end=" ")
        print()

    print()
    print(f"🚙 - Total de Carros no Estacionamento: {total_cars}")
    print()
    print("\nLegenda:")
    print("🔵 - Vagas para PCs (Pessoa com Deficiência)")
    print("🟡 - Vagas para Deficientes")
    print("🔴 - Vaga Ocupada")
    print("🟢 - Vaga Disponível")
    
