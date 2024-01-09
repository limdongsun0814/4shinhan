var cart_key = document.querySelectorAll(".miniCartTitle");
var index = 0;
var Prev = document.querySelector(".miniCartPrev");
var Next = document.querySelector(".miniCartNext");
var title = document.querySelector(".miniCartTitleDispaly");

move_ment();

Prev.onclick=prev_function;
Next.onclick=next_function;
if(cart_key.length!=0){
	title.textContent= cart_key[0].id;
}
function move_ment(){
    for(let i=0; i< cart_key.length; i++){
        if(index!=i){
            cart_key[i].classList.remove('miniCartTitle');
            cart_key[i].classList.add('displayNone');
        }else{
            cart_key[i].classList.remove('displayNone');
            cart_key[i].classList.add('miniCartTitle');
            title.innerHTML= cart_key[i].id;
        }
    }
}
function prev_function(){
    index=index-1;
    if(index<0){
        index=cart_key.length-1;
    }
    console.log(index);
    move_ment();
}
function next_function(){
    index=index+1;
    if(index>cart_key.length-1){
        index=0;
    }
    console.log(index);
    move_ment();
}