<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<script>
    var delivery_radio=document.getElementsByName('radio_dlivery');
    // var delivery_radio=document.getElementsByName('delivery');
    var dispaly_pickup = document.querySelectorAll('.cart_dispaly_pickup')
    var dispaly_delivery = document.querySelectorAll('.cart_dispaly_delivery')
    var payment_document = document.getElementById('payment_button');
    var keys_document =document.querySelectorAll('.cart_title_font');

    payment_document.addEventListener('click',payment_event_function);
	
    document.querySelector('input[name="radio_dlivery"]:checked').click();
    
    
	/* setInterval(getinput, 3000);   */
    
    
    console.log('======',keys_document);
    var title_keys = [];
    for(let i=0; i< keys_document.length; i++){
    	console.log(keys_document[i].outerText);
    	title_keys.push(keys_document[i].outerText);
    }
    console.log(title_keys,'title_keys');
    var keys = {};
    for(let i=0;i<title_keys.length;i++){
    	console.log("title_keys");
    	console.log(document.querySelectorAll('.'+title_keys));
        var menu_document =  document.querySelectorAll('.'+title_keys[i]);
        console.log(menu_document);
        var menu_key = [];
        for(let j=0; j <menu_document.length; j++){
            console.log(menu_document[j].defaultValue);
            menu_key.push(menu_document[j].defaultValue);
            console.log(title_keys[i]+'_'+menu_document[j].defaultValue+'_cnt');
            var str = title_keys[i]+'_'+menu_document[j].defaultValue+'_cnt';
            console.log(document.getElementsByName(str));
            document.getElementById(str).addEventListener('input',cnt_function);
        }
        keys[title_keys[i]]=menu_key;
        
        var str_checkbox_all = title_keys[i]+'_checkbox';
    }
    
    
    //delivery_radio.onclick=delivery_radio_function(event);
    var get_id_value = 'delivery';
    

    cnt_function();
    
    function delivery_radio_function(event){
        console.log(event.target.value);
        console.log(event.target.id);
        get_id_value = event.target.value;
        if(event.target.value=='pick_up'){
            console.log(dispaly_pickup);
//            var delivery_fee_document=document.querySelectorAll('.delivery_fee');
            var delivery_fee_document=document.querySelectorAll('.total_price_fee');
            for(let i=0;i<delivery_fee_document.length;i++){
            	delivery_fee_document[i].style.display="none";
            }
            for(let i=0; i<dispaly_pickup.length;i++){
                dispaly_pickup[i].style.display = "block";
                console.log(dispaly_pickup[i].id);
            }
            for(let i=0; i<dispaly_delivery.length;i++){
                dispaly_delivery[i].style.display = "none";

                var str = dispaly_delivery[i].id.split('_')[0];
                for(let i=0;i<title_keys.length;i++){
                	console.log('test2');
                    for(let j=0; j <keys[title_keys[i]].length; j++){
                    	if(str==title_keys[i]){
        	                var str_checkbox = title_keys[i]+'_'+keys[title_keys[i]][j]+'_check';
        	                console.log(str_checkbox);
        	                document.getElementById(str_checkbox).checked=false;
        	                var str_checkbox = title_keys[i]+'_checkbox';
        	            	document.getElementById(str_checkbox).checked=false;
                    	}
                    }
                }
                payment_function();
            }
        }else{
        	//var delivery_fee_document=document.querySelectorAll('.delivery_fee');
        	var delivery_fee_document=document.querySelectorAll('.total_price_fee');
            for(let i=0;i<delivery_fee_document.length;i++){
            	delivery_fee_document[i].style.display="block";
            	console.log("flex");
            }
            for(let i=0; i<dispaly_pickup.length;i++){
                dispaly_pickup[i].style.display = "none";
                
                var str = dispaly_pickup[i].id.split('_')[0];
                for(let i=0;i<title_keys.length;i++){
                	console.log('test2');
                    for(let j=0; j <keys[title_keys[i]].length; j++){
                    	if(str==title_keys[i]){
        	                var str_checkbox = title_keys[i]+'_'+keys[title_keys[i]][j]+'_check';
        	                console.log(str_checkbox);
        	                document.getElementById(str_checkbox).checked=false;
        	                var str_checkbox = title_keys[i]+'_checkbox';
        	            	document.getElementById(str_checkbox).checked=false;
                    	}
                    }
                }
                payment_function();
                
            }
            for(let i=0; i<dispaly_delivery.length;i++){
                dispaly_delivery[i].style.display = "block";
                console.log(dispaly_delivery[i].id);
            }
        }
        payment_function();
        cnt_function();
    }
    
    
    
    
    
    console.log(title_keys);
    console.log(keys);
    
    function count_down(event){
        var id_arr = event.target.id.split('_');
        var cnt_id=id_arr[0]+'_'+id_arr[1]+'_cnt';
        
        var cnt_min=document.getElementById(cnt_id).min;
        var cnt_max=document.getElementById(cnt_id).max;
        if(cnt_min>Number(document.getElementById(cnt_id).value)-1){
        	document.getElementById(cnt_id).value=0;
        }else{
            document.getElementById(cnt_id).value=Number(document.getElementById(cnt_id).value)-1;
        }
        cnt_function();

    }
    function count_up(event){
        var id_arr = event.target.id.split('_');
        var cnt_id=id_arr[0]+'_'+id_arr[1]+'_cnt';
        console.log(document.getElementById(cnt_id).value,"value");
        var cnt_min=document.getElementById(cnt_id).min;
        var cnt_max=document.getElementById(cnt_id).max;
        if(cnt_max<Number(document.getElementById(cnt_id).value)+1){
        	document.getElementById(cnt_id).value=cnt_max;
        }else{
            document.getElementById(cnt_id).value=Number(document.getElementById(cnt_id).value)+1;
        }
        cnt_function();

    }

    function cnt_function(event){
       
        for(let i=0;i<title_keys.length;i++){

            var total_price = 0;
            var menu_document =  document.querySelectorAll('.'+title_keys[i]);
            var total_dis_price=0;
            var menu_key = [];
            for(let j=0; j <menu_document.length; j++){
                var str_cnt = title_keys[i]+'_'+menu_document[j].defaultValue+'_cnt';
                var str_price = title_keys[i]+'_'+menu_document[j].defaultValue+'_price';
                var str_dis_price = title_keys[i]+'_'+menu_document[j].defaultValue+'_discount_price';

                var cnt=document.getElementById(str_cnt).value;
                var price=document.getElementById(str_price).value;
                var dis_price = document.getElementById(str_dis_price).value==null?0:document.getElementById(str_dis_price).value;
               
                console.log("dis_price",dis_price)
                total_price=cnt*price +total_price;
                total_dis_price=cnt*dis_price +total_dis_price;
            }

            
            
            var str_delivery_fee_id =title_keys[i]+'_delivery_fee';
            var total_price_id = title_keys[i]+'_total_price';
            var total_dis_price_id = title_keys[i]+'_total_discount_price';
            var total = title_keys[i]+'_total';

            var delivery_fee = document.getElementById(str_delivery_fee_id).value;

            console.log(delivery_fee);
            console.log(total_price_id);
            console.log(total_price);
            console.log(total_dis_price);
			console.log(total_price,"+++++++--------++++++++");
			if( get_id_value=='pick_up'){
				delivery_fee=0;
            }
			console.log(total_price,total_dis_price,delivery_fee);
            document.getElementById(total_price_id).value=total_price;
            document.getElementById(total_dis_price_id).value=total_dis_price;
            document.getElementById(total).value=total_price-total_dis_price+Number(delivery_fee);

            payment_function();
        }
        
    }

    function checkbox_all_function(event){
        var check_value = event.currentTarget.checked;
        console.log('test');
        console.log(event);
        console.log(event.target.id);
        var check_id = event.target.id.split('_')[0];
        console.log(check_id);
        for(let i=0;i<title_keys.length;i++){
        	console.log('test2');
            for(let j=0; j <keys[title_keys[i]].length; j++){
            	if(check_id==title_keys[i]){
	                var str_checkbox = title_keys[i]+'_'+keys[title_keys[i]][j]+'_check';
	                console.log(str_checkbox);
	                console.log( "---+--",!document.getElementById(str_checkbox).disabled&&check_value);
	                document.getElementById(str_checkbox).checked=!document.getElementById(str_checkbox).disabled&&check_value;
            	}else{
	                var str_checkbox = title_keys[i]+'_'+keys[title_keys[i]][j]+'_check';
	                console.log(str_checkbox);
	                document.getElementById(str_checkbox).checked=false;
            	}
            }
        }
        payment_function();
    }
    function checkbox_function(event) {
		var check_value=event.currentTarget.checked;
        var check_id = event.target.id.split('_')[0];
        var check_menu_id = event.target.id.split('_')[1];
        console.log(check_id);
        // 스켄 하면서 해당 radio를 check 나머진 flase check 박스도 해제
        
        console.log("title_keyaaaaaaa",title_keys);
        for(let i=0; i< title_keys.length;i++){
            console.log("title_keybbbbbbb",title_keys,keys);
            for(let j=0; j< keys[title_keys[i]].length;j++){
                console.log("title_keycccccccc",title_keys,keys);
                if(title_keys[i]!=check_id){
                    console.log("title_keydddddddd",title_keys,keys);
                    var store_name=title_keys[i];
                    var menu_name = keys[title_keys[i]][j];
                    console.log(store_name,menu_name,'+9++++++++++++');
                    document.getElementById(store_name+'_'+menu_name+'_check').checked=false;
                    document.getElementById(store_name+'_checkbox').checked=false;
                }else{
                    var store_name=title_keys[i];
                    document.getElementById(store_name+'_checkbox').checked=true;
                }
            }
        }
        
        /* if(check_value==false){
            var str_checkbox = check_id+'_checkbox';
        	document.getElementById(str_checkbox).checked=check_value;
        } */
        payment_function();
	}
    function payment_function(){
        var payment_total_price=0;
        var payment_total_cnt=0;
        var payment_total_dis_price=0;
        var payment_total_fee_price=0;
        console.log("title_key",title_keys);
        for(let i=0;i<title_keys.length;i++){
            for(let j=0; j <keys[title_keys[i]].length; j++){
                console.log("keys",keys[title_keys[i]]);
                var str_checkbox = title_keys[i]+'_'+keys[title_keys[i]][j]+'_check';
                console.log(str_checkbox);
                var check_document = document.getElementById(str_checkbox).checked;
                console.log(check_document);
                if(check_document){
                    var str_dis_price = title_keys[i]+'_'+keys[title_keys[i]][j]+'_discount_price';

                    var price=Number(document.getElementById(title_keys[i]+'_'+keys[title_keys[i]][j]+'_price').value);
                    var cnt=Number(document.getElementById(title_keys[i]+'_'+keys[title_keys[i]][j]+'_cnt').value);
                    var dis_price = Number(document.getElementById(str_dis_price).value==null?0:document.getElementById(str_dis_price).value);
                    
                    payment_total_price=payment_total_price+price*cnt;
                    console.log(price,payment_total_price,'price+++');
                    payment_total_cnt=payment_total_cnt+cnt;
                    payment_total_dis_price = payment_total_dis_price+dis_price*cnt;
                }
                console.log(title_keys[i]+'_'+keys[title_keys[i]][j]+'_price','aaaaaaaaaaaaaa');
            }
            console.log(get_id_value,check_document,'+++++++');
            var checkbox_radio=document.getElementById(title_keys[i]+'_checkbox').checked;
            //${cart.key}_checkbox
            if(checkbox_radio && get_id_value!='pick_up'){
                var fee = Number(document.getElementById(title_keys[i]+'_delivery_fee').value);
                payment_total_fee_price = payment_total_fee_price + fee;
                document.getElementById('payment_fee').style.display="flex";
                
            }else if(check_document){
                console.log("ppppppppppppp");
                var fee = Number(document.getElementById(title_keys[i]+'_delivery_fee').value);
                payment_total_fee_price = 0;
            	document.getElementById('payment_fee').style.display="none";
            }
        }
        console.log(payment_total_price,payment_total_fee_price,payment_total_dis_price);
        document.getElementById('payment_total_cnt').value=payment_total_cnt;
        document.getElementById('payment_total_price').value=payment_total_price;
        document.getElementById('payment_total_dis_price').value= payment_total_dis_price * -1;
        document.getElementById('payment_total_fee').value=payment_total_fee_price;
        console.log(payment_total_price,payment_total_fee_price,payment_total_dis_price);
        document.getElementById('payment_total').value = payment_total_price + payment_total_fee_price - payment_total_dis_price;
    	
    }
    function payment_event_function(){
        var flag = false;
        //get_id_value = document.getElementById('radio_dlivery').value;
        get_id_value=document.querySelector('input[name="radio_dlivery"]:checked').value;
        console.log(document.querySelector('input[name="radio_dlivery"]:checked').value);
        console.log(get_id_value);
        var obj={'get_id':get_id_value};
        for(let i=0;i<title_keys.length;i++){
            for(let j=0; j <keys[title_keys[i]].length; j++){
                var str_checkbox = title_keys[i]+'_'+keys[title_keys[i]][j]+'_check';
                var str_cnt = title_keys[i]+'_'+keys[title_keys[i]][j]+'_cnt';
                var str_price = title_keys[i]+'_'+keys[title_keys[i]][j]+'_price';
                var str_discount_price = title_keys[i]+'_'+keys[title_keys[i]][j]+'_discount_price';
                var str_fee = title_keys[i]+'_delivery_fee';
                var str_store_id = title_keys[i] + '_store_id';
                var str_store_ip_path = title_keys[i] + '_store_ip_path';


                var check_box_value = document.getElementById(str_checkbox).checked;
                var cnt_value = document.getElementById(str_cnt).value
                var fee_value = document.getElementById(str_fee).value
                var price_value = document.getElementById(str_price).value;
                var discount_price_value = document.getElementById(str_discount_price).value;
                var store_id_value = document.getElementById(str_store_id).value;
                var str_store_ip_path_value = document.getElementById(str_store_ip_path).value;

                if(check_box_value){
                	flag=true;
                    var str = keys[title_keys[i]][j]+'_'+price_value+'_'+cnt_value+'_'+discount_price_value;
                    obj['storeName']=title_keys[i];
                    obj['fee_value']=fee_value;
                    obj['store_id']=store_id_value;
                    obj['store_ip_path']=str_store_ip_path_value;
                    if(obj['menu']==null){
                        obj['menu']=[str];
                    }else{
                        obj['menu'].push(str);
                    }
                }
            }
        }
        console.log(obj);
        console.log(flag);
        if(flag){
            var form = document.createElement("form");
            form.setAttribute("method","post");
            form.setAttribute("action","payment/paymentInsert.do");
            console.log('submit');
	        for(let key in obj){
	        	console.log(obj[key]);
        		if(key!='get_id' && key!='storeName' && key!='fee_value'&& key!='store_id' && key!='store_ip_path'){
		        	for(let i=0; i<obj[key].length; i++){
			        		console.log('not get_id',obj[key][i]);
				            var input = document.createElement("input");
				            input.setAttribute("type","hidden");
				            input.setAttribute("name",key);
				            input.setAttribute("value",obj[key][i]);
				            form.appendChild(input);
		        	}
        		}else{
	        		console.log('get_id',obj[key]);
		            var input = document.createElement("input");
		            input.setAttribute("type","hidden");
		            input.setAttribute("name",key);
		            input.setAttribute("value",obj[key]);
		            form.appendChild(input);
        		}
	        }
	        document.body.appendChild(form);
	        form.submit();
        }
    }
</script>