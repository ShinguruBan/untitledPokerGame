const INDEX_NAME = 0
const INDEX_VISUAL_REP = 1
const INDEX_PRIZE = 2
const BIGGEST_COMB_SIZE = 5

const POSSIBLE_COMBINATIONS = {
	#value, vombination name, visual representation, prize
	0 : ["One Pair", ["IconDragon", "IconDragon"], 2],
	1 : ["Two Pairs", ["IconDragon", "IconDragon", "IconChimera", "IconChimera"], 3],
	2 : ["Three of a Kind", ["IconDragon", "IconDragon", "IconDragon"], 4],
	3 : ["Full House", ["IconDragon", "IconDragon", "IconDragon", "IconChimera", "IconChimera"], 6],
	4 : ["Four of a Kind", ["IconDragon", "IconDragon", "IconDragon", "IconDragon"], 8],
	5 : ["Five of a Kind", ["IconDragon", "IconDragon", "IconDragon", "IconDragon", "IconDragon"], 16]
}
