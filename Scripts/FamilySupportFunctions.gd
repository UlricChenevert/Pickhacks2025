extends Node

func getAllWorkers(familyNodes : Array[Family]) -> Array[Worker]:
	var returnedWorkerNodes : Array[Worker]
	
	for family in familyNodes:
		var children = family.get_children()
		
		for child in children:
			if (child is Worker):
				returnedWorkerNodes.append(child)
				
	
	return returnedWorkerNodes
	
func getAllFamiles(parent : Node) -> Array[Family]:
	var rawChildrenNodes = parent.get_children()
	var familyNodes : Array[Family]
	
	for node in rawChildrenNodes:
		if (node is Family):
			familyNodes.append(node)
	return familyNodes


func printFamilyInfo(family : Family):
	print(" -> " + family.name + ": {" + str(family.familyProfession) + ", " + str(family.food) + ", " + str(family.clothes) + ", " + str(family.leather) + ", " + str(family.cows) + "}")
