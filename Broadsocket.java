package Socket;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
// 브라우저로부터 Socket 접속을 하면 생성이 되는 Session 객체
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

// WEB 소켓으로 접속 가능한 URL 정보를 명시하여 소켓 서버를 생성, 클라이언트가 접속할 때 사용될 URI
@ServerEndpoint("/broadcasting")
public class Broadsocket {
	// HashSet 컬렉션은 순서가 필요없고 중복을 허용하지 않는다. 클라이언트의 중복 접근이 불필요하므로 적합
    // HashSet 컬렉션 안에 Session 객체 형태의 clients 객체를 만듦(synchronizedSet을 이용하여 공유가 가능한 멀티 쓰레드에서 안정된 객체를 생성)                           
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	
	// WebSocket으로 메시지가 오면 요청되는 함수
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		// Client가 보낸 메시지 출력
		System.out.println(message);
		// synchronized 를 사용하여 멀티쓰레드로 동시 접근 되는 것을 막는다.
		// Client들이 서버로 전송하는 메시지를
		synchronized (clients) {
			// HashSet 객체인 clients 객체안에 있는 모든 클라이언트에게
			for (Session client : clients) {
				// HashSet안에 있는 세션과 메시지를 보낸 세션이 같지 않을 때만
				if (!client.equals(session)) {
					// 그 client에 메시지를 보낸다.
					client.getBasicRemote().sendText(message);
				}
			}
		}
	}

	// WebSocket으로 브라우저가 접속하면 요청되는 함수
	@OnOpen
	public void onOpen(Session session) {
		System.out.println(session);
		// 브라우저가 접속되면 hashset 형태의 clients 객체에 세션을 추가한다.
		clients.add(session);
	}
	// WebSocket과 브라우저가 접속이 끊기면 요청되는 함수
	@OnClose
	public void onClose(Session session) {
		// 브라우저가 꺼지면 hashset 형태의 clients 객체에 세션을 추가한다.
		clients.remove(session);
		System.out.println("클라이언트와의 연결이 종료되었습니다.");
	}

}