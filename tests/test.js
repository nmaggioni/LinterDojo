var txt = '';
var person = {
	fname: 'John',
	lname: 'Doe',
	age: 25
};
var x;
for (x in person) {
	txt += person[x] + ' ';
}
var document = null;
document.getElementById('demo').innerHTML = txt;
