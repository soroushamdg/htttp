import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:htttp/const.dart';
import 'package:htttp/controllers/session_controller.dart';
import 'package:htttp/controllers/textfield_controller.dart';
import 'package:htttp/controllers/universal_controller.dart';
import 'package:htttp/models/serverchat_model.dart';
import 'package:htttp/pages/messaging.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      revealBackLayerAtStart: true,
      appBar: BackdropAppBar(
        actions: [
          Obx(() => (Get.find<UniversalSessionsController>().loading.value)
              ? Container()
              : IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Get.defaultDialog(
                        buttonColor: kMatrixGreenColor,
                        textCancel: 'Cancel',
                        onCancel: () {
                          Get.back();
                        },
                        textConfirm: 'Add',
                        onConfirm: () {
                          Get.find<UniversalSessionsController>().addSession(
                              Get.find<TextFieldController>()
                                  .addDialogFieldController
                                  .text);
                          Get.back();
                        },
                        title: 'Add server',
                        content: TextField(
                          controller: Get.find<TextFieldController>()
                              .addDialogFieldController,
                          style: TextStyle(color: kMatrixGreenColor),
                          cursorColor: kMatrixGreenColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.add_home_work),
                            focusColor: kMatrixGreenColor,
                            hintText: 'server address',
                            hintStyle: GoogleFonts.pressStart2p(
                                color: kMatrixGreenColor, fontSize: 12),
                          ),
                        ));
                  },
                )),
        ],
        backgroundColor: kAppbarBlack,
        title: Obx(
          () => (Get.find<UniversalSessionsController>().loading.value)
              ? Text('httttping...')
              : Text('htttp'),
        ),
        titleTextStyle: GoogleFonts.pressStart2p(color: kMatrixGreenColor),
      ),
      backLayerBackgroundColor: kBacklayerBlack,
      frontLayerBackgroundColor: kFrontlayerBlack,
      drawerScrimColor: kMatrixGreenColor,
      backLayer: Obx(() {
        return ListView.builder(
            itemCount: Get.find<UniversalSessionsController>().sessions.length,
            itemBuilder: (context, index) {
              return ListTile(
                hoverColor: Colors.white,
                textColor: kMatrixGreenColor,
                leading: Icon(
                  Icons.adjust,
                  color: kMatrixGreenColor,
                ),
                title: Text(Get.find<UniversalSessionsController>()
                    .sessions[index]
                    .url),
                onTap: () {
                  Get.find<UniversalSessionsController>().currentSessionIndex =
                      index.obs;
                  setState(() {});
                  Backdrop.of(context).concealBackLayer();
                },
                onLongPress: () {
                  Get.defaultDialog(
                    title: 'Delete server?',
                    buttonColor: Colors.red,
                    middleText: Get.find<UniversalSessionsController>()
                        .sessions[index]
                        .url,
                    onConfirm: () {
                      Get.find<UniversalSessionsController>()
                          .sessions
                          .removeAt(index);
                      Get.back();
                    },
                  );
                },
              );
            });
      }),
      frontLayer: Builder(builder: (c) {
        var session =
            Get.find<UniversalSessionsController>().currentSessionIndex;
        if ((session != null)) {
          return MessagingScreen();
        } else {
          return Center(
              child: Text(
            'Add server first!',
            style: GoogleFonts.pressStart2p(color: kMatrixGreenColor),
          ));
        }
      }),
      stickyFrontLayer: true,
    );
  }
}
