package com.shinhan.model;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;


import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationService {
	private static final Long DEFAULT_TIMEOUT = 10 * 60L * 1000; //10분, 60초, 1000밀리초 = 기본 타임아웃 10분
	private final EmitterRepository emitterRepository;
	
	private static final Logger logger = LoggerFactory.getLogger(NotificationService.class);
	
	
	//클라이언트의 구독 호출
	public SseEmitter subscribe(String memberId) {
		SseEmitter emitter = createEmitter(memberId);
		System.out.println("이미터");
		System.out.println(emitter);
		
		sendToClient(memberId, "주문 현황 알림 시작! 주문자: "+memberId.substring(13));
		return emitter;
	}
	
	
	//서버의 이벤트를 클라이언트에게 보냄. 사용자 id, 전송할 이벤트 객체
	public void notify(String memberId, Object event) {
		sendToClient(memberId, event);
	}

	
	
	//를라이언트에 데이터 전송. utf-8 바이트 형식으로 보내서 js에서 디코딩
	private void sendToClient(String id, Object data) {
		System.out.println("to client send");
		logger.info("send to client", id, data);
		System.out.println(data);
		SseEmitter emitter = emitterRepository.get(id);
		System.out.println("이미터");
		System.out.println(emitter);
		
		//인코딩 처리
		String encodedString = null;
		try {
			encodedString = URLEncoder.encode(data.toString(), "UTF-8");
			encodedString = encodedString.replaceAll("\\+", "%20");			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(emitter != null) {
			try {
				//emitter 저장 시에 String으로 지정하고, 열어놓을 서버명+id로 저장해야?
				emitter.send(SseEmitter.event().id(String.valueOf(id))
						.name("sse").data(encodedString));
			} catch (IOException e) {
				emitterRepository.deleteById(id);
				emitter.completeWithError(e);
				logger.error("sse 연결 실패");
			}
		}
	}
	
	
	//가게 ID 기반 이벤트 Emitter 생성
	private SseEmitter createEmitter(String id) {
		SseEmitter emitter = new SseEmitter(DEFAULT_TIMEOUT);
		emitterRepository.save(id, emitter);
		
		//emitter 데이터 전송 완료 시 삭제?
		emitter.onCompletion(() -> emitterRepository.deleteById(id));
		
		//emitter 타임아웃 시(지정 시간 동안 어떠한 이벤트도 전송되지 않음)
		emitter.onTimeout(() -> emitterRepository.deleteById(id));
		
		
		return emitter;
	}
}