package com.shinhan.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.dto.MemberAddressDTO;
import com.shinhan.dto.MemberAddressVO;
import com.shinhan.dto.MemberUpdateDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.dto.memberSingUpDTO;

@Service
public class MemberService {
	
	@Autowired
	MemberDAO dao;
	
	
	public List<MemberVO> selectAll() {
		return dao.selectAll();
	}
	
	public MemberVO getMyInfo(String member_id) {
		return dao.selectById(member_id);
	}
	public int deleteMember(String member_id) {
		return dao.deleteMember(member_id);
	}
	public int updateMember(MemberUpdateDTO memberUpdateDTO) {
		return dao.updateMember(memberUpdateDTO);
	}

	public List<Map<Object, Object>> getBreadAlarm(String member_id) {
		return dao.getBreadAlarm(member_id);
	}

	public List<Map<Object, Object>> getNoticeAlarm(String member_id) {
		return dao.getNoticeAlarm(member_id);
	}

	public List<Map<Object, Object>> getSubscribeAlarm(String member_id) {
		return dao.getSubscribeAlarm(member_id);
	}
	//회원 가입시 주소 정보 저장
	public int addBaseMemberAddress(memberSingUpDTO sign_up_address) {
		return dao.addBaseMemberAddress(sign_up_address);
	}
	
	public List<MemberAddressDTO> get_memberaddress_list(String id){
		return dao.get_memberaddress_list(id);
	}
	public int addMoreMemberAddress(MemberAddressDTO address) {
		return dao.addMoreMemberAddress(address);
	}
	public MemberAddressVO get_memberaddress(MemberAddressVO memberAddress) {
		return dao.get_memberaddress(memberAddress);
	}

	//회원정보 수정시 비밀번호 확인
	public String getPasswordByMemberId(String memberId) {
		return dao.getPasswordByMemberId(memberId);
	}
	
	public int updateMemberPathById(String member_id, String member_ip_path) {
		return dao.updateMemberPathById(member_id, member_ip_path);
	}

	public int deleteAllAlarm(String member_id) {
		return dao.deleteAllAlarm(member_id);
	}

	public int changeCheckAlarm(String member_id) {
		return dao.changeCheckAlarm(member_id);
	}

	public int countNewAlarm(String member_id) {
		return dao.countNewAlarm(member_id);
	}
	
}
