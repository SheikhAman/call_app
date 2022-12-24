import 'package:call_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'dart:math' as math;

/// Note that the userID needs to be globally unique,
final String localUserID = math.Random().nextInt(10000).toString();

class VideoCalling extends StatefulWidget {
  const VideoCalling({super.key});

  @override
  State<VideoCalling> createState() => _VideoCallingState();
}

class _VideoCallingState extends State<VideoCalling> {
  final callingId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: callingId,
              decoration: InputDecoration(
                  hintText: 'Enter Call id', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CallPage(callingId: callingId.text.toString()),
                      ));
                },
                child: const Text('Join'))
          ],
        ),
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  final String callingId;
  const CallPage({super.key, required this.callingId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: Utils.appId,
        appSign: Utils.appSign,
        callID: callingId,
        userID: localUserID,
        userName: 'user_$localUserID',
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..onOnlySelfInRoom = (context) {
            Navigator.of(context).pop();
          },
      ),
    );
  }
}
