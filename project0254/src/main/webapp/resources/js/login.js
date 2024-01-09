var open_find_id = document.querySelector('#find_id_button');
var close_find_id = document.querySelector('#find_id_close');
var find_id = document.querySelector('#find_id');

var open_search_password = document.querySelector('#search_password_button');
var close_search_password = document.querySelector('#search_password_close');
var search_password = document.querySelector('#search_password');


open_find_id.addEventListener('click',open_find_id_function);
close_find_id.addEventListener('click',close_find_id_function);

open_search_password.addEventListener('click',open_search_password_function);
close_search_password.addEventListener('click',close_search_password_function);



function open_find_id_function(){
    find_id.classList.remove('hidden');
}

function close_find_id_function(){
    find_id.classList.add('hidden');
}

function open_search_password_function(){
    search_password.classList.remove('hidden');
}

function close_search_password_function(){
    search_password.classList.add('hidden');
}