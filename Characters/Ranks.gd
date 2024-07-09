extends Resource

class_name Ranks

@export_range(1,3) var level : int
var rank_name : String

func ranks():
	if level == 1:
		rank_name = "Private"
	elif level == 2:
		rank_name = "Private First Class"
	elif level == 3:
		rank_name = "Corporal"
