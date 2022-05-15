import 'package:get/get.dart';
import '../models/serverchat_model.dart';
import 'package:http/http.dart' as http;
import 'package:htttp/models/message_model.dart';

enum Request {
  GET,
  POST,
}

class UniversalSessionsController extends GetxController {
  RxList<ServerChat> sessions = <ServerChat>[].obs;

  void addSession(String server) {
    sessions.add(ServerChat(
      url: server,
    ));
  }

  // model : ServerChat
  RxInt? currentSessionIndex;

  RxBool loading = false.obs;
  http.Response? response;

  void addMessage(Message msg) {
    if (currentSessionIndex == null) return;
    var serverchat = ServerChat(
        url: sessions[currentSessionIndex!.value].url,
        messages: [msg] + sessions[currentSessionIndex!.value].messages);
    sessions[currentSessionIndex!.value] = serverchat;
  }

  void performreq(Request req, String url) async {
    if (currentSessionIndex == null) return;

    loading.value = true;
    if (req == Request.GET) {
      addMessage(Message(msg: 'GET $url', sender: Sender.user));
      response = await http.get(Uri.parse(url));
      addMessage(Message(
          msg: 'RESPONSE-GET\n ${response?.body}', sender: Sender.server));
    }
    if (req == Request.POST) {
      addMessage(Message(msg: 'POST $url', sender: Sender.user));

      response = await http.post(Uri.parse(url));
      addMessage(Message(
          msg: 'RESPONSE-POST\n ${response?.body}', sender: Sender.server));
    }
    loading.value = false;
  }
}
