import 'dart:io';
import 'dart:async';
import 'package:async/async.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnifyflutter/widgets/Custom_waiting_dialog.dart';
import 'package:learnifyflutter/widgets/custom_dialog_basic.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

import 'package:learnifyflutter/widgets/pdf_viewer_page.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footer/footer.dart';

import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:learnifyflutter/Models/CoursesModel.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';
import 'package:learnifyflutter/widgets/chewie_list_item.dart';
import 'package:learnifyflutter/utilities/content_model.dart';
import 'package:learnifyflutter/utilities/customimage.dart';
import 'package:learnifyflutter/utilities/data.dart';
import 'package:learnifyflutter/utilities/utils.dart';

import 'package:path/path.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/rendering.dart'; // In order to use RepaintBoundary, RenderRepaintBoundary

import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:native_screenshot/native_screenshot.dart';

import 'package:camera/camera.dart';

//take a picture with camera
Future<String?> takePic() async {
  await Future.delayed(Duration(seconds: 20), () {
    debugPrint("waiting for 10 seconds");
  });
  final camera = (await availableCameras()).last;
  final controller = CameraController(camera, ResolutionPreset.medium);
  try {
    await controller.initialize();
    await controller.setFlashMode(FlashMode.off);
    final image = await controller.takePicture();
    controller.dispose();
    print("image path: ${image.path}");
    return image.path;
  } catch (e) {
    print("some error occured :");
    print(e);
    controller.dispose();
    return null;
  }
}

class Screen2 extends StatefulWidget {
  var myObject;
  Screen2({this.myObject});
  @override
  _Screen2State createState() => _Screen2State();
}

final GlobalKey _key = GlobalKey();

class _Screen2State extends State<Screen2> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late Future<bool> fetchedLessons;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController roomcontroller = TextEditingController();
  bool isVideoMuted = false;
  bool isAudioMuted = true;
  String username = '';
  bool click = false;

  void screenshot() async {
    final String? path = await takePic();

    await sendscreen(path.toString());

    await Future.delayed(Duration(seconds: 40), () {
      screenshot();
    });
  }

  Future<void> sendscreen(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("_id")!;
    var request =
        http.MultipartRequest('POST', Uri.parse(BaseURL + "faceapi/" + userid));
    request.files.add(await http.MultipartFile.fromPath('file', path));
    try {
      var response = await request.send();
      debugPrint(response.statusCode.toString());
    } catch (e) {
      print(e);
    }
  }

  //take a screenshot of the system
  void takeScreenshot() async {
    final RenderRepaintBoundary boundary =
        _key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    final bs64 = base64Encode(pngBytes);
    print(bs64);
    //save image to cache
    final directory = (await getTemporaryDirectory()).path;
    final file = File('$directory/screenshot.png');
    await file.writeAsBytes(pngBytes);
    print("image path: " + file.path);
  }

  Future<void> _onStartCardEntryFlow() async {
    await InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: _onCardEntryCardNonceRequestSuccess,
        onCardEntryCancel: _onCancelCardEntryFlow);
  }

  void _onCancelCardEntryFlow() {}

  void _onCardEntryCardNonceRequestSuccess(CardDetails result) async {
    try {
      chargeCard(result);
      InAppPayments.completeCardEntry(
          onCardEntryComplete: _onCardEntryComplete);
    } on Exception catch (ex) {
      // payment failed to complete due to error
      // notify card entry to show processing error
      InAppPayments.showCardNonceProcessingError(ex.toString());
    }
  }

  void _onCardEntryComplete() {
    // Update UI to notify user that the payment flow is finished successfully
  }
  late Future<bool> fetchedCourses;

  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    InAppPayments.setSquareApplicationId(
        'sandbox-sq0idb-l8M5v3_UGiQiyvmoNPwTAQ');

    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) async {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
    screenshot();
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
    dispose();
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  String funcV(path) {
    final profilePicpath = path;
    if (profilePicpath.startsWith('public')) {
      final profilePic = profilePicpath.substring(23, profilePicpath.length);
      final imagePath = BaseURL + 'uploads/lessons/' + profilePic;
      return imagePath;
    }
    return '';
  }

  String func() {
    final profilePicpath = widget.myObject.image;
    if (profilePicpath.startsWith('public')) {
      final profilePic = profilePicpath.substring(22, profilePicpath.length);
      final imagePath = BaseURL + 'uploads/lessons/' + profilePic;
      return imagePath;
    }
    return '';
  }

  Future<File> loadNetwork(String url, index) async {
    var uri = Uri.parse(url);
    final response = await http.get(uri);
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  joinmeeting(index) async {
    try {
      Map<FeatureFlagEnum, bool> feautueflags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false
      };
      if (Platform.isAndroid) {
        feautueflags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        feautueflags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = JitsiMeetingOptions(
          room: widget.myObject.lessons[index]["meetCode"].toString())
        ..userDisplayName =
            namecontroller.text == '' ? username : namecontroller.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(feautueflags);

      await JitsiMeet.joinMeeting(options);

      // await Future.delayed(Duration(seconds: 20), () {
      //   screenshot();
      // });
    } catch (e) {
      print("ERRor: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return RepaintBoundary(
      key: _key,
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.teal, Colors.indigo],
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()));
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Detail',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Nisebuschgardens',
                            ),
                          ),
                          Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 30),
                        child: Column(
                          children: [
                            CustomImage(
                              func(),
                              radius: 10,
                              width: double.infinity,
                              height: 200,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(height: 50),
                                      Text(
                                        widget.myObject.title.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(click
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined),
                                        color:
                                            (click ? Colors.red : Colors.white),
                                        onPressed: () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          final userid =
                                              prefs.getString("_id")!;
                                          Map<String, String> headers = {
                                            "Content-Type":
                                                "application/json; charset=utf-8"
                                          };
                                          Map<String, dynamic> body = {
                                            "courseid": widget.myObject.id,
                                          };
                                          http.post(
                                              Uri.parse(BaseURL +
                                                  "users/wish/" +
                                                  userid),
                                              headers: headers,
                                              body: json.encode(body));

                                          final snackBar = SnackBar(
                                            backgroundColor: Colors.redAccent
                                                .withOpacity(0.8),
                                            content: Text(
                                                '${widget.myObject.title} has been added to your favorites ❤️️'),
                                            action: SnackBarAction(
                                              label: 'Undo',
                                              textColor: Colors.white,
                                              onPressed: () async {
                                                setState(() {
                                                  click = false;
                                                });
                                                // Some code to undo the change.
                                                Map<String, dynamic> body = {
                                                  "courseid": widget.myObject.id
                                                      .toString(),
                                                };
                                                http.post(
                                                    Uri.parse(BaseURL +
                                                        "users/wishremove/" +
                                                        userid),
                                                    headers: headers,
                                                    body: json.encode(body));
                                              },
                                            ),
                                          );

                                          // Find the ScaffoldMessenger in the widget tree
                                          // and use it to show a SnackBar.
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          setState(() {
                                            click = !click;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        widget.myObject.nbrSeance.toString(),
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.schedule_outlined,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        widget.myObject.nbrSeance.toString(),
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        widget.myObject.tag.toString(),
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "About Course ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 200,
                                          )
                                        ],
                                      ),
                                      ReadMoreText(
                                        widget.myObject.description.toString(),
                                        trimLines: 2,
                                        trimMode: TrimMode.Line,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: TabBar(
                                      controller: tabController,
                                      tabs: [
                                        Tab(
                                          child: Text("Lessons"),
                                        ),
                                        Tab(
                                          child: Text("Excerices"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              child: TabBarView(
                                  controller: tabController,
                                  children: [
                                    getlesson(),
                                    Center(
                                        child: Text(
                                      "Coming Soon...",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    )),
                                  ]),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Price",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        widget.myObject.price.toString(),
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CustomAlertDialog3(
                                              title: "Processiong",
                                              description: "",
                                            );
                                          });
                                      final bool check = await checksub();
                                      if (check == false) {
                                        _onStartCardEntryFlow();
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CustomAlertDialog2(
                                                title:
                                                    "You have already subscribed",
                                                description:
                                                    "You are already subscribed to this course",
                                              );
                                            });
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, top: 20),
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      alignment: Alignment.center,
                                      height: 55,
                                      width: 240,
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "buy",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getlesson() {
    return ListView.builder(
      itemCount: widget.myObject.lessons.length,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.white70.withOpacity(.07),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1),
              )
            ]),
        child: InkWell(
          onTap: () async {
            print(funcV(widget.myObject.lessons[index]["support"].toString()));
            if (widget.myObject.lessons[index]["support"] == null) {
              joinmeeting(index);
              return;
            } else if (widget.myObject.lessons[index]["support"]
                .toString()
                .contains("pdf")) {
              final file = await loadNetwork(
                  funcV(widget.myObject.lessons[index]["support"].toString()),
                  index);
              openPDF(context, file);
              return;
            } else {
              print(
                  funcV(widget.myObject.lessons[index]["support"].toString()));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => Chewielistitem(
                    videoPlayerController: VideoPlayerController.network(funcV(
                        widget.myObject.lessons[index]["support"].toString())),
                    looping: false,
                    object: widget.myObject,
                  ),
                ),
              );
            }
          },
          child: Row(
            children: [
              CustomImage(
                func(),
                radius: 10,
                width: 70,
                height: 70,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.myObject.lessons[index]["title"]),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );

  Future<String> chargeCard(CardDetails result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString("_id")!;
    final url = Uri.parse(BaseURL + "users/courses/" + userid);
    Map<String, dynamic> body = {
      "courseid": widget.myObject.id.toString(),
      "nonce": result.nonce,
    };
    final response = await http.post(url, body: body);

    //print(response.body.toString());
    // get response status
    final String statusCode = response.statusCode.toString();
    return statusCode;
  }

  Future<bool> checksub() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString("_id")!;
    final url = Uri.parse(BaseURL + "users/checksub/" + userid);
    Map<String, dynamic> body = {
      "courseid": widget.myObject.id.toString(),
    };
    final response = await http.post(url, body: body);

    print(response.body.toString());
    if (response.body.toString() == "true") {
      return true;
    } else {
      return false;
    }
  }
}
