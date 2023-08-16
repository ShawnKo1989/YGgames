package websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/serverChat")
public class ServerChat {
	private static Map<String, Set<Session>> roomSessions = new HashMap<>();

	@OnOpen
	public void onOpen(Session session) {
		String room = getQueryParamValue(session.getRequestURI().getQuery(), "room");
		Set<Session> sessions = roomSessions.getOrDefault(room, new HashSet<>());

		// "room" 파라미터가 "admin"인 경우에는 "admin" 속성 추가
		if ("admin".equals(room)) {
			session.getUserProperties().put("role", "admin");
		} else {
			// 그 외의 경우 "user" 속성 추가
			session.getUserProperties().put("role", "user");
			// "user" 세션일 때만 "admin" 세션을 채팅룸에 추가
			// "admin" 세션을 가져오기
			Session adminSession = getAdminSession();
			if (adminSession != null) {
				sessions.add(adminSession);
			}
		}
		
	    // "admin" 세션일 때만 채팅방에 추가하고, "user" 세션들과 연결하지 않음
	    if ("admin".equals(session.getUserProperties().get("role"))) {
	        sessions.add(session);
	        for (Session s : sessions) {
	            if ("admin".equals(s.getUserProperties().get("role")) && s != session) {
	                try {
						s.getBasicRemote().sendText("SERVER: Admin has joined the chat.");
					} catch (IOException e) {
						e.printStackTrace();
					}
	            }
	        }
	    }
		
		roomSessions.put(room, sessions);
	}

	// "admin" 세션을 찾아서 반환하는 메서드
	private Session getAdminSession() {
		for (Session session : roomSessions.getOrDefault("room", new HashSet<>())) {
			if ("admin".equals(session.getUserProperties().get("role"))) {
				return session;
			}
		}
		return null; // "admin" 세션이 없으면 null 반환
	}

	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		String room = getQueryParamValue(session.getRequestURI().getQuery(), "room");
		Set<Session> sessions = roomSessions.getOrDefault(room, new HashSet<>());

		int firstPipeIndex = message.indexOf('|');
		int secondPipeIndex = message.indexOf('|', firstPipeIndex + 1);

		String type = message.substring(0, firstPipeIndex);
		String nickname = message.substring(firstPipeIndex + 1, secondPipeIndex);
		String content = message.substring(secondPipeIndex + 1);

		String regex = "^(message)";
		Pattern pattern = Pattern.compile(regex);
		String regex2 = "^(notice)";
		Pattern pattern2 = Pattern.compile(regex2);

		Matcher matcher = pattern.matcher(type);
		Matcher matcher2 = pattern2.matcher(type);
		if (matcher.find()) {
			for (Session s : sessions) {
				if (s != session) {
					s.getBasicRemote().sendText("CLIENT" + nickname + ": " + content);
				} else {
					s.getBasicRemote().sendText(content);
				}
			}
		} else if (matcher2.find()) {
			for (Session s : sessions) {
				s.getBasicRemote().sendText("SERVER" + content);
			}
		}
	}

	@OnClose
	public void onClose(Session session) {
		String room = getQueryParamValue(session.getRequestURI().getQuery(), "room");
		Set<Session> sessions = roomSessions.getOrDefault(room, new HashSet<>());
		sessions.remove(session);
	}

	@OnError
	public void onError(Session session, Throwable error) {
		// 에러 처리
		error.printStackTrace();
	}

	private String getQueryParamValue(String query, String paramName) {
		if (query != null) {
			String[] params = query.split("&");
			for (String param : params) {
				String[] keyValue = param.split("=");
				if (keyValue.length == 2 && keyValue[0].equals(paramName)) {
					return keyValue[1];
				}
			}
		}
		return null;
	}
}
