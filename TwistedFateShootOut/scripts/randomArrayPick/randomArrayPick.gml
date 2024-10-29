//Pick Something randomly from the array
function randomArrayPick(_array){
	var randChoice = irandom_range(0, array_length(_array)-1);
	return _array[randChoice];
}