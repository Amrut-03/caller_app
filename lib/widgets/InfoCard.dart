// ignore_for_file: use_build_context_synchronously

import 'package:caller_app/model/user.dart';
import 'package:caller_app/utils/constants.dart';
import 'package:caller_app/widgets/sliding_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:direct_dialer/direct_dialer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_activity_recognition/flutter_activity_recognition.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_pop_up/overlay_pop_up.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Infocard extends StatefulWidget {
  const Infocard({super.key});

  @override
  State<Infocard> createState() => _InfocardState();
}

class _InfocardState extends State<Infocard>
    with SingleTickerProviderStateMixin {
  String number = "+918788379225";
  int _currentIndex = 0;

  List<UserModel> userList = [
    UserModel(name: 'Amrut Anil Khochikar', time: '2:35 pm'),
    UserModel(name: 'John Doe', time: '3:45 pm'),
    UserModel(name: 'Jane Smith', time: '1:15 pm'),
  ];

  // final activityRecognition = FlutterActivityRecognition.instance;

  // Future<bool> isPermissionGranted() async {
  //   final activityRecognition = FlutterActivityRecognition.instance;

  //   // Check if the user has granted permission
  //   PermissionRequestResult reqResult =
  //       await activityRecognition.checkPermission();

  //   if (reqResult == PermissionRequestResult.PERMANENTLY_DENIED) {
  //     dev.log('Permission is permanently denied.');
  //     return false;
  //   } else if (reqResult == PermissionRequestResult.DENIED) {
  //     // Request permission if not granted
  //     reqResult = await activityRecognition.requestPermission();
  //     if (reqResult != PermissionRequestResult.GRANTED) {
  //       dev.log('Permission is denied.');
  //       return false;
  //     }
  //   }

  //   return true;
  // }

  // Future<void> dial(BuildContext context, String phone) async {
  //   PermissionStatus status = await Permission.phone.status;

  //   if (status.isDenied || status.isPermanentlyDenied) {
  //     status = await Permission.phone.request();
  //   }

  //   if (status.isGranted) {
  //     final Uri callUri = Uri(scheme: 'tel', path: phone);
  //     if (await canLaunchUrl(callUri)) {
  //       await launchUrl(callUri);
  //     } else {
  //       AppTemplate.messenger(context, 'Could not place the call.');
  //     }
  //   } else if (status.isDenied) {
  //     AppTemplate.messenger(
  //         context, 'Phone permission is required to make a call.');
  //   } else if (status.isPermanentlyDenied) {
  //     AppTemplate.messenger(context,
  //         'Phone permission is permanently denied. Please enable it in settings.');
  //     openAppSettings();
  //   }
  // }

  // void dial() async {
  //   final context = BuildContext; // Replace with correct context
  //   final dialer = await DirectDialer.instance;
  //   await Permission.phone.request().then((status) async {
  //     if (status.isGranted) {
  //       await dialer.dial('8788379225');
  //     } else {
  //       // Handle permission denial
  //     }
  //   });
  // }

  Future<void> dial() async {
    final dialer = await DirectDialer.instance;
    await dialer.dial('+918788379225');
  }

  _launch(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Not supported");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: null,
      child: Center(
        child: Container(
          color: Colors.transparent,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  width: 400,
                  height: 245,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF008A78),
                        Color(0xFF00241F),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, right: 30, left: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: CarouselSlider.builder(
                                itemCount: userList.length,
                                itemBuilder: (context, index, realIndex) {
                                  final user = userList[index];
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SlidingText(
                                        name: user.name,
                                        time: user.time,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Online Meeting",
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(
                                            0xFFFFFFFF,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Need to shedule a google meet link.",
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: const Color(
                                            0xFFFFFFFF,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                options: CarouselOptions(
                                  height: 120.0,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 0.9,
                                  enlargeCenterPage: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                  enableInfiniteScroll: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            userList.length,
                            (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: index == _currentIndex
                                    ? Container(
                                        height: 8,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFD9D9D9),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      )
                                    : const CircleAvatar(
                                        radius: 4,
                                        backgroundColor:
                                            Color.fromARGB(255, 170, 170, 170),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      const Divider(
                        color: Color(0xFF008A78),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 35, left: 35, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "View More information on Lead",
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(
                                    0xFFFFD700,
                                  )),
                            ),
                            SvgPicture.asset('assets/icons/forward.svg')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: 400,
                      height: 71,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF008A78),
                            Color(0xFF00241F),
                          ],
                        ),
                      ),
                      child: SizedBox(
                        width: 329,
                        height: 43,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: SizedBox(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () => dial(),
                                        child: SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: SvgPicture.asset(
                                              'assets/icons/call.svg'),
                                        ),
                                      ),
                                      // GestureDetector(
                                      //   onTap: () =>
                                      //       dial(context, "+918788379225"),
                                      //   child: SizedBox(
                                      //     height: 18,
                                      //     width: 18,
                                      //     child: SvgPicture.asset(
                                      //         'assets/icons/call.svg'),
                                      //   ),
                                      // ),
                                      Text(
                                        'Call Now',
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                color: Color(0xFF1E796D),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  // AppTemplate.openWhatsapp(
                                  //   context: context,
                                  //   text: 'Hi Aditya',
                                  //   number: '+918788379225',
                                  // );
                                  _launch(
                                      'whatsapp://send?text=sample text&phone=918788379225');
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: SvgPicture.asset(
                                              'assets/icons/whatsapp.svg'),
                                        ),
                                        Text(
                                          'Whatsapp',
                                          style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                color: Color(0xFF1E796D),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: SizedBox(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: SvgPicture.asset(
                                                'assets/icons/close.svg'),
                                          ),
                                        ),
                                        Text(
                                          'Close',
                                          style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        right: 0,
                        child: GestureDetector(
                          onTap: () async => await OverlayPopUp.closeOverlay(),
                          child: Container(
                            height: 70,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
