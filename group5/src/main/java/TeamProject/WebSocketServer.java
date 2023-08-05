package TeamProject;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/websocket")
public class WebSocketServer {
    private static Set<Session> sessions = Collections.synchronizedSet(new HashSet<Session>());

    @OnOpen		//클라이언트 접속 시 실행
    public void onOpen(Session session) {
        System.out.println("WebSocket 연결 ");
        sessions.add(session);
    }

    @OnMessage	//Message를 받을 때 실행
    public void onMessage(Session session, String message) {
        // 받은 메시지와 닉네임 정보를 문자열 형태로 묶어서 클라이언트에게 전송
        String composedMessage =  message;

        broadcast(composedMessage);
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("WebSocket 종료");
        sessions.remove(session);
    }

    private void broadcast(String message) {
        for (Session session : sessions) {
            try {
                session.getBasicRemote().sendText(message);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    
    @OnError
    public void onError(Throwable e) {
    	System.out.println("에러 발생");
    	e.printStackTrace();
    }
    
}
