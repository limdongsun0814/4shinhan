package com.shinhan.util;

import com.shinhan.dto.OwnerDTO;
import com.shinhan.dto.OwnerVO;

public class VOToDTO {
	public OwnerDTO ownervo_to_ownerdto(OwnerVO ownerVO){
		OwnerDTO ownerDTO = new OwnerDTO();
		ownerDTO.setOwner_address(ownerVO.getOwner_address());
		ownerDTO.setOwner_address_detail(ownerVO.getOwner_address_detail());
		ownerDTO.setOwner_address_latitude(ownerVO.getOwner_address_latitude());
		ownerDTO.setOwner_address_longitude(ownerVO.getOwner_address_longitude());
		ownerDTO.setOwner_email(ownerVO.getOwner_email());
		ownerDTO.setOwner_id(ownerVO.getOwner_id());
		ownerDTO.setOwner_name(ownerVO.getOwner_name());
		ownerDTO.setOwner_phone(ownerVO.getOwner_phone());
		return ownerDTO;
	}
}
