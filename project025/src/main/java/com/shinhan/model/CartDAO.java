package com.shinhan.model;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.CartProductVO;
import com.shinhan.dto.CartStoreDTO;
import com.shinhan.dto.CartUpdateDTO;
import com.shinhan.dto.deleteCartDTO;

@Repository
public class CartDAO  {
	@Autowired
	SqlSession sqlSession;
	String namespace = "com.shinhan.cart.";
	
	public List<CartStoreDTO> get_cart_store_list(HashMap<String, Object> id) {
		List<CartStoreDTO> result = sqlSession.selectList(namespace + "getCartStoreList",id);
		System.out.println(result);
		return result;
	}
	public void update_Cart(CartUpdateDTO cartUpdate) {
		int result = sqlSession.update(namespace + "updateCart",cartUpdate);
		System.out.println("업데이트 결과"+result);
	}
	public void delete_Cart(deleteCartDTO deleteCart) {
		int result = sqlSession.delete(namespace + "deleteCart",deleteCart);
		System.out.println("삭제 결과"+result);
	}
	public void delete_cart_store(deleteCartDTO deleteCart) {
		int result = sqlSession.delete(namespace + "deleteCartStore",deleteCart);
		System.out.println("삭제 스토어 결과"+result);
	}
	public int insert_cart(CartProductVO cartproduct) {
		int result=0;
		int check = sqlSession.selectOne(namespace+"cartCheck",cartproduct);
		if(check==0) {
			result=sqlSession.insert(namespace+"insertCart",cartproduct);
		}else {
			result=sqlSession.insert(namespace+"updateCartProduct",cartproduct);
		}
		return result;
	}
}
