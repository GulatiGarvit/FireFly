import 'package:firebase_database/firebase_database.dart';
import 'package:firefly/pages/dashboard/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:firefly/apis/user.dart';
// import 'package:firefly/pages/dashboard/main.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:firefly/colors/dark_mode.dart';
import 'package:firefly/colors/light_mode.dart';
import 'package:firefly/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firefly/styles/text_styles.dart';
import 'package:firefly/utils/loading_dialog.dart';
import 'package:firefly/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  User? user;

  @override
  State<LoginPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<LoginPage> {
  bool isExpanded = false;
  bool isFirst = true;
  bool isSecond = false;
  bool isThird = false;
  bool isFourth = false;
  bool isPhone = true;
  String phone = "";
  String name = "";
  String gender = "";
  String age = "";
  String verificationId = "";
  String? nameError;
  String? genderError;
  String? medRecordError;
  String medRecord = "";
  String? ageError;
  String otp = "";
  String? error;
  FirebaseAuth mAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  final fadeDuration = const Duration(milliseconds: 200);
  final slideUpDuration = const Duration(milliseconds: 400);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: DarkModeColors.colorPrimary,
          appBar: AppBar(
            backgroundColor: DarkModeColors.colorPrimary,
            title: const Text(
              "firefly",
              style: textMediumPrimaryBold,
            ),
          ),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2.25,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(colors: [
                      DarkModeColors.colorPrimaryLight,
                      DarkModeColors.colorPrimary,
                    ], center: Alignment.center),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/fire.png",
                            width: MediaQuery.of(context).size.width / 1.1,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/ff.webp",
                            width: MediaQuery.of(context).size.width / 1.5,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: AnimatedSize(
            duration: slideUpDuration,
            child: Container(
              width: double.infinity,
              height: isExpanded
                  ? MediaQuery.of(context).size.height - 26
                  : MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
              ),
              child: !isExpanded
                  ? AnimatedOpacity(
                      opacity: isFirst ? 1 : 0,
                      duration: fadeDuration,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Spacer(),
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: "Making Lives",
                                    style: textLargePrimary),
                                TextSpan(
                                    text: " Safer\n",
                                    style: textLargePrimaryTheme),
                                TextSpan(
                                    text: "One building at a time",
                                    style: textLargePrimary),
                                TextSpan(text: "", style: textLargePrimary),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            "Your personal fire companion",
                            style: textMediumPrimary,
                          ),
                          const Spacer(),
                          SimpleShadow(
                            color: LightModeColors.colorPrimary,
                            offset: Offset.zero,
                            sigma: 10,
                            child: ElevatedButton(
                              onPressed: () async {
                                await Future.delayed(
                                    const Duration(milliseconds: 100));
                                setState(() {
                                  isFirst = !isFirst;
                                });
                                await Future.delayed(
                                    const Duration(milliseconds: 200));
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                                await Future.delayed(
                                    const Duration(milliseconds: 100));
                                setState(() {
                                  isSecond = !isSecond;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 36),
                                  splashFactory: InkRipple.splashFactory,
                                  backgroundColor:
                                      LightModeColors.colorPrimary),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Get Started",
                                    style: textMediumLightBold,
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    )
                  : isSecond
                      ? AnimatedOpacity(
                          opacity: isFirst ? 0 : 1,
                          duration: fadeDuration,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      weight: 10,
                                      size: 24,
                                    ),
                                    onPressed: () async {
                                      await Future.delayed(
                                          const Duration(milliseconds: 100));
                                      setState(() {
                                        isExpanded = !isExpanded;
                                      });
                                      await Future.delayed(
                                          const Duration(milliseconds: 200));
                                      setState(() {
                                        isFirst = !isFirst;
                                      });
                                      await Future.delayed(
                                          const Duration(milliseconds: 100));
                                      setState(() {
                                        isSecond = !isSecond;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(26),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 26,
                                    ),
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "Register",
                                              style: textLargePrimaryTheme),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      "Let's verify if you're a human first!",
                                      style: textMediumPrimary,
                                    ),
                                    const SizedBox(
                                      height: 26,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Phone Number",
                                          style: textMediumPrimarySemiBold,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        MyInputField(
                                          label: "Tring tring...",
                                          onChanged: (value) {
                                            phone = value;
                                          },
                                          type: 'phone',
                                          prefill: phone,
                                          error: error,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 32,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: SimpleShadow(
                                        color: LightModeColors.colorPrimary,
                                        offset: Offset.zero,
                                        sigma: 10,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (phone.trim().isEmpty) {
                                              setState(() {
                                                error =
                                                    "Please enter your phone number";
                                              });
                                              return;
                                            } else if (phone.trim().length !=
                                                10) {
                                              setState(() {
                                                error =
                                                    "Please enter a valid 10-digit phone number";
                                              });
                                              return;
                                            }
                                            LoadingDialog(context)
                                                .showLoader(false);
                                            await FirebaseAuth.instance
                                                .verifyPhoneNumber(
                                              phoneNumber: "+91$phone",
                                              verificationCompleted:
                                                  (PhoneAuthCredential
                                                      credential) {},
                                              verificationFailed:
                                                  (FirebaseAuthException e) {
                                                LoadingDialog(context)
                                                    .cancelLoader();
                                              },
                                              codeSent: (String verificationId,
                                                  int? resendToken) async {
                                                this.verificationId =
                                                    verificationId;
                                                LoadingDialog(context)
                                                    .cancelLoader();
                                                setState(() {
                                                  isSecond = !isSecond;
                                                });
                                                await Future.delayed(
                                                  const Duration(
                                                      milliseconds: 100),
                                                );
                                                setState(() {
                                                  isThird = !isThird;
                                                });
                                              },
                                              codeAutoRetrievalTimeout:
                                                  (String verificationId) {},
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18,
                                                      horizontal: 36),
                                              splashFactory:
                                                  InkRipple.splashFactory,
                                              backgroundColor:
                                                  LightModeColors.colorPrimary),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Generate OTP",
                                                style: textMediumLightBold,
                                              ),
                                              Icon(
                                                Icons.chevron_right_rounded,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 2,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        const Text(
                                          "OR LOGIN WITH",
                                          style: textSmallPrimarySemiBold,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 2,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 32,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: Colors.white),
                                              padding: EdgeInsets.all(16),
                                              child: SvgPicture.asset(
                                                "assets/images/google_logo.svg",
                                                width: 32,
                                                height: 32,
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Material(
                                                color: Colors.transparent,
                                                clipBehavior: Clip.antiAlias,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: InkWell(
                                                  onTap: () {},
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 26,
                                        ),
                                        Stack(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: Colors.white),
                                              padding: EdgeInsets.all(16),
                                              child: SvgPicture.asset(
                                                "assets/images/apple_logo.svg",
                                                width: 32,
                                                height: 32,
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Material(
                                                color: Colors.transparent,
                                                clipBehavior: Clip.antiAlias,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: InkWell(
                                                  onTap: () {},
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 26,
                                        ),
                                        Stack(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: Colors.white),
                                              padding: EdgeInsets.all(16),
                                              child: Icon(
                                                Icons.email,
                                                size: 32,
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Material(
                                                color: Colors.transparent,
                                                clipBehavior: Clip.antiAlias,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: InkWell(
                                                  onTap: () {},
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : isThird
                          ? AnimatedOpacity(
                              opacity: isFirst ? 0 : 1,
                              duration: fadeDuration,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          weight: 10,
                                          size: 24,
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            isSecond = !isSecond;
                                          });
                                          await Future.delayed(
                                            const Duration(milliseconds: 100),
                                          );
                                          setState(() {
                                            isThird = !isThird;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(26),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 26,
                                        ),
                                        RichText(
                                          text: const TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: "Register",
                                                  style: textLargePrimaryTheme),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "Enter the OTP sent to ",
                                                      style: textMediumPrimary),
                                                  TextSpan(
                                                    text: phone,
                                                    style:
                                                        textMediumPrimarySemiBold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  isSecond = !isSecond;
                                                });
                                                await Future.delayed(
                                                  const Duration(
                                                      milliseconds: 100),
                                                );
                                                setState(() {
                                                  isThird = !isThird;
                                                });
                                              },
                                              child: Icon(
                                                Icons.edit,
                                                size: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 26,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "OTP",
                                              style: textMediumPrimarySemiBold,
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            OTPTextField(
                                              length: 6,
                                              style: textMediumPrimarySemiBold,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.25,
                                              onCompleted: (value) async {
                                                otp = value;
                                                LoadingDialog(context)
                                                    .showLoader(false);
                                                PhoneAuthCredential credential =
                                                    PhoneAuthProvider
                                                        .credential(
                                                            verificationId:
                                                                verificationId,
                                                            smsCode: otp);
                                                try {
                                                  await mAuth
                                                      .signInWithCredential(
                                                          credential);
                                                  if (mAuth.currentUser!
                                                          .displayName !=
                                                      null) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Welcome ${mAuth.currentUser!.displayName}");
                                                    LoadingDialog(context)
                                                        .cancelLoader();
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Dashboard(),
                                                      ),
                                                      (route) => false,
                                                    );
                                                    return;
                                                  }
                                                  LoadingDialog(context)
                                                      .cancelLoader();
                                                  setState(() {
                                                    isThird = !isThird;
                                                  });
                                                  await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 100),
                                                  );
                                                  setState(() {
                                                    isFourth = !isFourth;
                                                  });
                                                } catch (error) {
                                                  LoadingDialog(context)
                                                      .cancelLoader();
                                                  Fluttertoast.showToast(
                                                      msg: "Invalid OTP");
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 64,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () async {},
                                            style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 18,
                                                        horizontal: 36),
                                                splashFactory:
                                                    InkRipple.splashFactory,
                                                backgroundColor: LightModeColors
                                                    .colorPrimary),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Verify",
                                                  style: textMediumLightBold,
                                                ),
                                                Icon(
                                                  Icons.chevron_right_rounded,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : isFourth
                              ? AnimatedOpacity(
                                  opacity: isFirst ? 0 : 1,
                                  duration: fadeDuration,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.close,
                                              weight: 10,
                                              size: 24,
                                            ),
                                            onPressed: () async {},
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(26),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 26,
                                            ),
                                            RichText(
                                              text: const TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: "Register",
                                                      style:
                                                          textLargePrimaryTheme),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "Let's get to know about each other",
                                              style: textMediumPrimary,
                                            ),
                                            const SizedBox(
                                              height: 26,
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Full Name",
                                                  style:
                                                      textMediumPrimarySemiBold,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                MyInputField(
                                                  onChanged: (value) {
                                                    setState(() {
                                                      nameError = null;
                                                      name = value;
                                                    });
                                                  },
                                                  label:
                                                      "What should we call you?",
                                                  error: nameError,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Age",
                                                          style:
                                                              textMediumPrimarySemiBold,
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        MyInputField(
                                                          onChanged: (value) {
                                                            setState(() {
                                                              ageError = null;
                                                              age = value;
                                                            });
                                                          },
                                                          label:
                                                              "How old are you?",
                                                          error: ageError,
                                                        )
                                                      ]),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Gender",
                                                          style:
                                                              textMediumPrimarySemiBold,
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        MyInputField(
                                                          onChanged: (value) {
                                                            setState(() {
                                                              genderError =
                                                                  null;
                                                              gender = value;
                                                            });
                                                          },
                                                          label: "M/F/O",
                                                          error: genderError,
                                                        )
                                                      ]),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Medical Record",
                                                  style:
                                                      textMediumPrimarySemiBold,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                MyInputField(
                                                  onChanged: (value) {
                                                    medRecordError = null;
                                                    medRecord = value;
                                                  },
                                                  label:
                                                      "Do you have any medical conditions?",
                                                  error: null,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 64,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  if (name.isEmpty) {
                                                    setState(() {
                                                      nameError =
                                                          "Please enter your name";
                                                    });
                                                    return;
                                                  } else if (int.parse(age) <
                                                      18) {
                                                    setState(() {
                                                      ageError =
                                                          "You must be 18 years or older";
                                                    });
                                                    return;
                                                  } else if (gender.isEmpty) {
                                                    setState(() {
                                                      genderError =
                                                          "Please enter your gender";
                                                      return;
                                                    });
                                                  }
                                                  LoadingDialog(context)
                                                      .showLoader(false);
                                                  await mAuth.currentUser!
                                                      .updateDisplayName(name);
                                                  await registerUserOnMongo(
                                                      name,
                                                      int.parse(age),
                                                      gender,
                                                      medRecord,
                                                      "",
                                                      "Patiala",
                                                      phone,
                                                      mAuth.currentUser!.uid);
                                                  LoadingDialog(context)
                                                      .cancelLoader();
                                                  Fluttertoast.showToast(
                                                      msg: "Welcome $name!");
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          Dashboard(),
                                                    ),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 18,
                                                        horizontal: 36),
                                                    splashFactory:
                                                        InkRipple.splashFactory,
                                                    backgroundColor:
                                                        LightModeColors
                                                            .colorPrimary),
                                                child: const Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Let's go",
                                                      style:
                                                          textMediumLightBold,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .chevron_right_rounded,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
            ),
          ),
        ),
        onWillPop: () async {
          if (isFirst || isFourth) {
            return true;
          } else if (isThird) {
            setState(() {
              isSecond = !isSecond;
            });
            await Future.delayed(
              const Duration(milliseconds: 100),
            );
            setState(() {
              isThird = !isThird;
            });
            return false;
          } else {
            setState(() {
              isSecond = !isSecond;
            });
            await Future.delayed(
              const Duration(milliseconds: 100),
            );
            setState(() {
              isExpanded = !isExpanded;
            });
            await Future.delayed(const Duration(milliseconds: 100));
            setState(() {
              isFirst = !isFirst;
            });
            return false;
          }
        });
  }
}
