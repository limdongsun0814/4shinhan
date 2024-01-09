package com.shinhan.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.dto.MemberAddressDTO;
import com.shinhan.dto.MemberAddressVO;
import com.shinhan.dto.MemberUpdateDTO;
import com.shinhan.dto.MemberVO;
import com.shinhan.dto.memberSingUpDTO;

@Repository
public class MemberDAO {

	@Autowired
	SqlSession sqlSession;
	String namespace = "com.shinhan.member.";

	public List<MemberVO> selectAll() {
		List<MemberVO> memberList = sqlSession.selectList(namespace + "selectAll");
		return memberList;
	}

	// 멤버 정보 조회하기
	public MemberVO selectById(String member_id) {
		MemberVO member = sqlSession.selectOne(namespace + "selectById", member_id);
		return member;
	}

	// 회원탈퇴
	public int deleteMember(String member_id) {
		int result = sqlSession.delete(namespace + "deleteMember", member_id);
		return result;
	}

	// 회원정보 수정
	public int updateMember(MemberUpdateDTO memberUpdateDTO) {
		int result = sqlSession.update(namespace + "updateMember", memberUpdateDTO);
		return 0;
	}

	
	// 회원가입시 MEMBER_ADDRESS DB 추가
	public int addBaseMemberAddress(memberSingUpDTO sign_up) {
		int result = sqlSession.insert(namespace + "addBaseMemberAddress", sign_up);
		return result;
	}

	public List<MemberAddressDTO> get_memberaddress_list(String id) {
		List<MemberAddressDTO> result = sqlSession.selectList(namespace + "get_memberaddress_list", id);
		return result;
	}

	public int addMoreMemberAddress(MemberAddressDTO address) {
		System.out.println("DAO");
		System.out.println(address);
		int address_check = sqlSession.selectOne(namespace + "address_check", address);
		int result =0;
		System.out.println(address_check+"address_chek");
		if(address_check==0) {
			result = sqlSession.insert(namespace + "addMoreMemberAddress", address);
			System.out.println(result+"addMoreMemberAddress");
		}
		return result;
	}
	public MemberAddressVO get_memberaddress(MemberAddressVO memberAddress) {
		MemberAddressVO result = sqlSession.selectOne(namespace + "get_address", memberAddress);
		return result;
	}
	
	public List<Map<Object, Object>> getBreadAlarm(String member_id) {
		List<Map<Object, Object>> getBreadAlarm = sqlSession.selectList(namespace + "getBreadAlarm", member_id);
		return getBreadAlarm;
	}

	public List<Map<Object, Object>> getNoticeAlarm(String member_id) {
		List<Map<Object, Object>> getNoticeAlarm = sqlSession.selectList(namespace + "getNoticeAlarm", member_id);
		return getNoticeAlarm;
	}

	public List<Map<Object, Object>> getSubscribeAlarm(String member_id) {
		List<Map<Object, Object>> getSubscribeAlarm = sqlSession.selectList(namespace + "getSubscribeAlarm", member_id);
		return getSubscribeAlarm;
	}
	public int updateMemberPathById(String member_id, String member_ip_path) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		map.put("member_ip_path", member_ip_path);
		int result = sqlSession.update(namespace+"updateMemberPathById", map);
		return result;
  }

	public String getPasswordByMemberId(String memberId) {
		String password = sqlSession.selectOne(namespace + "getPasswordByMemberId", memberId);
		return password;
	}

	public int deleteAllAlarm(String member_id) {
		int result = sqlSession.delete(namespace + "deleteAllAlarm", member_id);
		return result;
	}

	public int changeCheckAlarm(String member_id) {
		int result = sqlSession.update(namespace + "changeCheckAlarm", member_id);
		return result;
	}

	public int countNewAlarm(String member_id) {
		int alarmCount = sqlSession.selectOne(namespace + "countNewAlarm", member_id);
		return alarmCount;
	}
}
