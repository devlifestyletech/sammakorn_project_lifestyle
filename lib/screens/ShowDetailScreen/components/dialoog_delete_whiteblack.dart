import 'package:flutter/material.dart';
import 'package:registerapp_flutter/screens/Home/service/service.dart';
import 'package:registerapp_flutter/service/socket.dart';
import '../../../constance.dart';

class DialogSendDeleteWhiteBlack extends StatelessWidget {
  final String type;
  final String id;

  const DialogSendDeleteWhiteBlack({
    Key key,
    @required this.type,
    @required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Services services = Services();
    final reasonController = TextEditingController();

    return AlertDialog(
      backgroundColor: bgDialog,
      content: Stack(
        // overflow: Overflow.visible,
        children: [
          // Positioned(
          //   right: -40.0,
          //   top: -40.0,
          //   child: InkResponse(
          //     onTap: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: CircleAvatar(
          //       child: Icon(Icons.close),
          //       backgroundColor: Colors.red,
          //     ),
          //   ),
          // ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Send request to juristic",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: reasonController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Reason *',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'กรุณากรอกเหตุผล' : null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 300, height: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: goldenSecondary, shape: StadiumBorder()),
                      child: Text(
                        "Send",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          services.send_admin_delete_blackwhite(
                              type, id, reasonController.text);
                          Navigator.pushNamed(context, '/home');

                          var socket = SocketManager();
                          socket.send_message(
                              'RESIDENT_REQUEST_WHITELIST', 'web');
                          socket.send_message(
                              'RESIDENT_REQUEST_BLACKLIST', 'web');

                          socket.send_message(
                              'RESIDENT_REQUEST_WHITEBLACK', 'app');
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 300, height: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: bgDialog,
                        shape: StadiumBorder(),
                        side: BorderSide(
                          width: 0.5,
                          color: goldenSecondary,
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 16,
                          color: goldenSecondary,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
