package com.shinhan.model;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class EmitterRepository {
	//모든 Emitter 저장하는 ConcurrentHashMap
	private final Map<String, SseEmitter> emitters = new ConcurrentHashMap<String, SseEmitter>();
	
	
	//주어진 아이디와, Emitter를 저장
	public void save(String id, SseEmitter emitter) {
		emitters.put(id, emitter);
	}
	
	//주어진 아이디 Emitter 제거
	public void deleteById(String id) {
		emitters.remove(id);
	}
	
	//주어진 아이디 Emitter 가져옴
	public SseEmitter get(String id) {
		return emitters.get(id);
	}
	
	
}
