var open_add_address = document.querySelector('#add_address_btn');
var close_add_address = document.querySelector('#add_address_close_btn');
var add_address_form = document.querySelector('#add_address_form');




open_add_address.addEventListener('click',open_add_address_function);
close_add_address.addEventListener('click',close_add_address_function);




function open_add_address_function(){
	console.log("open 모달");
    add_address_form.classList.remove('hidden');
}
function close_add_address_function(){
	console.log("close 모달");
    add_address_form.classList.add('hidden');
}