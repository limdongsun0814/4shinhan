package com.shinhan.model;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.OwnerVO;

@Repository
public class OwnerDAO {

	@Autowired
	SqlSession sqlSession;
	String namespace = "net.firstzone.owner."; //
	
	public OwnerVO selectByOwnerId(String owner_id) {
		OwnerVO owner = sqlSession.selectOne(namespace + "selectByOwnerId", owner_id);
		return owner;
	}
	
}
