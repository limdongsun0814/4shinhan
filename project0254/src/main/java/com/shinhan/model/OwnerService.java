package com.shinhan.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.shinhan.dto.OwnerVO;

@Service("oService")
public class OwnerService {

	@Autowired
	OwnerDAO dao;
	
	public OwnerVO selectByOwnerId(String owner_id) {
		return dao.selectByOwnerId(owner_id);
	}
	
	
	
	
	
	
	
	
}
