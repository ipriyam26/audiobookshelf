import 'package:audiobookshelf/Utils/button.dart';
import 'package:audiobookshelf/Utils/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            child: Card(
                color: Theme.of(context).colorScheme.shadow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r)),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: FaIcon(
                                FontAwesomeIcons.arrowLeft,
                                size: 16.h,
                                color: Theme.of(context).colorScheme.outline,
                              )),
                          Text(
                            "Server Address",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Container(
                            width: 16.h,
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16.h),
                        child: OutlineTextField(
                          hintText: "http://55.55.55.55:13378",
                          controller: TextEditingController(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextOutlineButton(text: "Submit", onPressed: () {})
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ));
  }
}
