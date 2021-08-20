import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  Future<bool> checkPermission() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    bool _res = prefs.getBool("permission") ?? false;
    return _res;
  }

  Future<bool> setPermission() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var _res = prefs.setBool("permission", true);
    return _res;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 40),
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width / 3,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width - 40,
            child: ElevatedButton(
              child: Text("Get Started"),
              onPressed: () async {
                final permission = await checkPermission();
                if (permission) {
                  Navigator.pushNamed(context, '/login');
                } else {
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: Colors.white,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text('Modal BottomSheet'),
                                ElevatedButton(
                                  child: const Text('Close BottomSheet'),
                                  onPressed: () async {
                                    final permissionUpdated =
                                        await setPermission();
                                    if (permissionUpdated)
                                      Navigator.pushNamed(context, "/login");
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
