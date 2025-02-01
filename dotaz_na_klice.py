import json

# Cesta k souboru clients.json
file_path = "/mnt/data/clients.json"

# Načtení obsahu JSON souboru
with open(file_path, "r") as file:
    data = json.load(file)

# Získání seznamu klientů
clients = data["clients"]

# Výpis všech klíčů pro každého klienta
for index, client in enumerate(clients):
    print(f"Klient {index + 1}:")
    for key in client.keys():
        print(f" - {key}")
    print()  # Nový řádek mezi jednotlivými klienty