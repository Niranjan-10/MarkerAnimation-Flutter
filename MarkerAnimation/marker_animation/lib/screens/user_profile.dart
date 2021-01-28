import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              left: 30.0,
              top: 100.0,
              right: 30.0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                padding: EdgeInsets.only(top: 50.0),
                // width: double.infinity,
                height: 500.0,
                width: 300.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2.0,
                          spreadRadius: 1.5,
                          color: Colors.grey)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Mcs Tracking PVT"),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Tracking system"),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        height: 2.0,
                        thickness: 3.0,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(child: Text("Over Speed: ")),
                                  SizedBox(
                                    width: 50.0,
                                  ),
                                  Container(
                                    color: Colors.black45,
                                    height: 20,
                                    width: 2,
                                  ),
                                  SizedBox(
                                    width: 50.0,
                                  ),
                                  Expanded(child: Text("15 km/h"))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.cancel,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(child: Text("Over Speed: ")),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Container(
                                  color: Colors.black45,
                                  height: 20,
                                  width: 2,
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Expanded(child: Text("15 km/h"))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cancel,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(child: Text("Over Speed: ")),
                                    SizedBox(
                                      width: 50.0,
                                    ),
                                    Container(
                                      color: Colors.black45,
                                      height: 20,
                                      width: 2,
                                    ),
                                    SizedBox(
                                      width: 50.0,
                                    ),
                                    Expanded(child: Text("15 km/h"))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cancel,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(child: Text("Over Speed: ")),
                                    SizedBox(
                                      width: 50.0,
                                    ),
                                    Container(
                                      color: Colors.black45,
                                      height: 20,
                                      width: 2,
                                    ),
                                    SizedBox(
                                      width: 50.0,
                                    ),
                                    Expanded(child: Text("15 km/h"))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cancel,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(child: Text("Over Speed: ")),
                                    SizedBox(
                                      width: 50.0,
                                    ),
                                    Container(
                                      color: Colors.black45,
                                      height: 20,
                                      width: 2,
                                    ),
                                    SizedBox(
                                      width: 50.0,
                                    ),
                                    Expanded(child: Text("15 km/h"))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cancel,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(child: Text("Over Speed: ")),
                                    SizedBox(
                                      width: 50.0,
                                    ),
                                    Container(
                                      color: Colors.black45,
                                      height: 20,
                                      width: 2,
                                    ),
                                    SizedBox(
                                      width: 50.0,
                                    ),
                                    Expanded(child: Text("15 km/h"))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cancel,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(child: Text("Over Speed: ")),
                                    SizedBox(
                                      width: 50.0,
                                    ),
                                    Container(
                                      color: Colors.black45,
                                      height: 20,
                                      width: 2,
                                    ),
                                    SizedBox(
                                      width: 50.0,
                                    ),
                                    Expanded(child: Text("15 km/h"))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 60.0,
              left: 160.0,
              right: 160.0,
              child: Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                      color: Colors.redAccent, shape: BoxShape.circle),
                  child: Image.asset("assets/user.png")),
            ),
          ],
        ),
      ),
    );
  }
}
