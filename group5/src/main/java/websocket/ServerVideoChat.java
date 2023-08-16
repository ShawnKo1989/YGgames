package websocket;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/serverVideoChat")
public class ServerVideoChat {
    private static Map<String, Set<Session>> roomSessions = Collections.synchronizedMap(new HashMap<>());

    @OnOpen
    public void onOpen(Session session, EndpointConfig config) {
        String room = getQueryParamValue(session.getRequestURI().getQuery(), "reservationNo");
        Set<Session> sessions = roomSessions.getOrDefault(room, Collections.synchronizedSet(new HashSet<>()));
        sessions.add(session);
        roomSessions.put(room, sessions);
        System.out.println("connect: " + session.getId());
    }

    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
    	String room = getQueryParamValue(session.getRequestURI().getQuery(), "reservationNo");
    	Set<Session> sessions = roomSessions.getOrDefault(room, Collections.synchronizedSet(new HashSet<>()));

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
		if(matcher.find()) {
			for (Session s : sessions) {
				if (s != session) {
					s.getBasicRemote().sendText("CLIENT" + nickname + ": " + content);
				} else {
					s.getBasicRemote().sendText(content);
				}
			}
		} else if(matcher2.find()) {
			for(Session s : sessions) {
				s.getBasicRemote().sendText("SERVER" + content);
			}
		}
    }
    
    @OnMessage
    public void onMessage(byte[] data, Session session) throws IOException {
        String room = getQueryParamValue(session.getRequestURI().getQuery(), "reservationNo");
        Set<Session> sessions = roomSessions.getOrDefault(room, Collections.synchronizedSet(new HashSet<>()));

        // 다른 클라이언트로 스트림 데이터 전송
        sendStreamDataToOtherClients(session, sessions, data);
    }

    private void sendStreamDataToOtherClients(Session session, Set<Session> sessions, byte[] data) {
        for (Session s : sessions) {
            if (!s.equals(session)) {
                try {
                    s.getBasicRemote().sendBinary(ByteBuffer.wrap(data));
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        String room = getQueryParamValue(session.getRequestURI().getQuery(), "reservationNo");
        Set<Session> sessions = roomSessions.getOrDefault(room, Collections.synchronizedSet(new HashSet<>()));
        sessions.remove(session);
        System.out.println("disconnect: " + session.getId());
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
