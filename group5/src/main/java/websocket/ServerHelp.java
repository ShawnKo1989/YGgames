package websocket;

import java.util.Arrays;

import javax.websocket.OnMessage;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import dao.RsvDao;

@ServerEndpoint("/serverHelp")
public class ServerHelp {
	@OnMessage
	public String onMessage(String message, Session session) {
		String schedule = message.split(":")[1];
		schedule = schedule.substring(schedule.indexOf("\"") + 1, schedule.lastIndexOf("\""));

		RsvDao cntRsvDao = RsvDao.getInstance();
		int[] spts = cntRsvDao.cntRsv(schedule);

		return Arrays.toString(spts);
	}
}
