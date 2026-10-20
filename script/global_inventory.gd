extends Node

# Jumlah maksimal slot di tas kita (misal 15: 5 buat hotbar, 10 buat backpack)
const MAX_SLOTS = 15 

# Array ini yang bakal nyimpen data item kita. 
# Null artinya slot kosong.
var items: Array = [] 

# Nunjuk ke indeks slot hotbar yang lagi dipakai/dipegang player (0 - 4)
var active_hotbar_slot: int = 0 

func _ready():
	# Pas game mulai, siapin 15 slot kosong
	for i in range(MAX_SLOTS):
		items.append(null)

# Nanti kita bikin fungsi add_item() dan remove_item() di sini
