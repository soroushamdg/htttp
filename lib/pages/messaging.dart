import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:htttp/controllers/universal_controller.dart';
import 'package:htttp/models/message_model.dart';
import '../const.dart';
import '../controllers/textfield_controller.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MessagesSection(),
      InputSection(),
    ]);
  }
}

class MessagesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentindex =
        Get.find<UniversalSessionsController>().currentSessionIndex!.value;
    return Obx(() => (Get.find<UniversalSessionsController>()
            .sessions[currentindex]
            .messages
            .isNotEmpty)
        ? Expanded(
            child: ListView.builder(
              itemCount: Get.find<UniversalSessionsController>()
                  .sessions[currentindex]
                  .messages
                  .length,
              itemBuilder: (context, index) {
                return (Get.find<UniversalSessionsController>()
                            .sessions[currentindex]
                            .messages[index]
                            .sender ==
                        Sender.server)
                    ? MessageBubbleServer(
                        body: Get.find<UniversalSessionsController>()
                            .sessions[currentindex]
                            .messages[index]
                            .msg,
                      )
                    : MessageBubbleUser(
                        body: Get.find<UniversalSessionsController>()
                            .sessions[currentindex]
                            .messages[index]
                            .msg,
                      );
              },
              reverse: true,
            ),
          )
        : Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ));
  }
}

class MessageBubbleServer extends StatelessWidget {
  MessageBubbleServer({Key? key, required this.body}) : super(key: key);
  final String body;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: 0.5,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        decoration: BoxDecoration(
          color: kBacklayerBlack,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
        child: Text(
          'RESPONSE : $body',
          style: TextStyle(
            color: kMatrixGreenColor,
          ),
        ),
      ),
    );
  }
}

class MessageBubbleUser extends StatelessWidget {
  MessageBubbleUser({Key? key, required this.body}) : super(key: key);
  final String body;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerRight,
      widthFactor: 0.5,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        decoration: BoxDecoration(
          color: kMatrixGreenColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
          ),
        ),
        child: Text(body),
      ),
    );
  }
}

class InputSection extends StatelessWidget {
  const InputSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: kMatrixGreenColor,
          ),
          child: Obx(
            () => DropdownButton(
                value: Get.find<TextFieldController>()
                    .DropDownValueController
                    .value,
                items: ['GET', 'POST'].map((String e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  Get.find<TextFieldController>()
                      .DropDownValueController
                      .value = value.toString();
                },
                elevation: 0,
                style: TextStyle(color: Colors.white),
                dropdownColor: kMatrixGreenColor,
                underline: SizedBox()),
          ),
        ),
        Expanded(
          child: TextField(
            enabled: (Get.find<UniversalSessionsController>().loading.value)
                ? false
                : true,
            controller: Get.find<TextFieldController>().cmdFieldController,
            onChanged: (value) {},
            onSubmitted: (String t) {
              var req = (Get.find<TextFieldController>()
                          .DropDownValueController
                          .value ==
                      'GET')
                  ? Request.GET
                  : Request.POST;
              Get.find<UniversalSessionsController>().performreq(req, t);
            },
            autofocus: true,
            cursorColor: kMatrixGreenColor,
            style: GoogleFonts.pressStart2p(
                color: kMatrixGreenColor, fontSize: 12),
            decoration: InputDecoration(
              fillColor: kMatrixGreenColor,
              hintText: 'url',
              hintStyle: GoogleFonts.pressStart2p(
                  color: kMatrixGreenColor, fontSize: 12),
              prefixIcon: Icon(
                Icons.network_ping,
                color: kMatrixGreenColor,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                  color: kMatrixGreenColor,
                ),
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
