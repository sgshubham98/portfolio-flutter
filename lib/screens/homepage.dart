import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sgshubham98/provider/dark_theme_provider.dart';
import 'package:sgshubham98/utils/responsive.dart';
import 'package:sgshubham98/utils/styles.dart';
import 'package:sgshubham98/widgets/switcher.dart';
import 'package:url_launcher/url_launcher.dart';

const String githubUrl = 'https://github.com/sgshubham98';
const String linkedinUrl = 'https://linkedin.com/in/sgshubham98';
const String twitterUrl = 'https://twitter.com/sgshubham98';
const String email = 'mailto:sgshubham98@gmail.com';
const String phone = 'tel:+918868003003';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: themeChange.darkTheme
                ? NetworkImage(
                    'https://www.transparenttextures.com/patterns/binding-dark.png',
                  )
                : NetworkImage(
                    'https://www.transparenttextures.com/patterns/billie-holiday.png',
                  ),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final horizontal = isMobile(context) ? 24.0 : 200.0;
    final vertical = isMobile(context) ? 24.0 : 120.0;
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello!",
                      style: GoogleFonts.lato(
                        fontSize: isMobile(context) ? 32.0 : 64.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: CustomSwitch(
                        value: themeChange.darkTheme,
                        onChanged: (bool newValue) {
                          themeChange.darkTheme = newValue;
                        },
                      ),
                    ),
                  ],
                ),
                isMobile(context)
                    ? SizedBox(
                        height: 15.0,
                      )
                    : SizedBox(
                        height: 30.0,
                      ),
                Text(
                  "I'm Shubham Goswami, Flutter Dev and loves to contribute towards tech communities, passionate about building things.",
                  style: GoogleFonts.openSans(
                    fontSize: isMobile(context) ? 28.0 : 44.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 32.0,
                ),
                isMobile(context)
                    ? Column(
                        children: [
                          ResumeButton(themeChange: themeChange),
                          SizedBox(height: 24.0),
                          buildIconRow(context),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ResumeButton(themeChange: themeChange),
                          SizedBox(height: 24.0),
                          buildIconRow(context),
                        ],
                      ),
                SizedBox(
                  height: 32.0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Want to get in touch? Write me at ',
                        style: GoogleFonts.lato(
                          fontSize: 20.0,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      TextSpan(
                        semanticsLabel: 'email',
                        text: 'sgshubham98@gmail.com',
                        style: GoogleFonts.lato(
                          fontSize: 20.0,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          textStyle: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Clipboard.setData(
                              ClipboardData(text: 'sgshubham98@gmail.com'),
                            );
                            showSnackBar(context, horizontal);
                          },
                      ),
                      TextSpan(
                        text: ' or give a call @ ',
                        style: GoogleFonts.lato(
                          fontSize: 20.0,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      TextSpan(
                        text: '+91 8868003003',
                        semanticsLabel: 'phone number',
                        style: GoogleFonts.lato(
                          fontSize: 20.0,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          textStyle: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Clipboard.setData(
                              ClipboardData(text: '+918868003003'),
                            );
                            showSnackBar(context, horizontal);
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, double horizontal) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.symmetric(
          horizontal: horizontal,
        ),
        duration: Duration(
          seconds: 2,
        ),
        behavior: SnackBarBehavior.floating,
        content: Text('Copied'),
      ),
    );
  }

  Row buildIconRow(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isMobile(context) ? MainAxisAlignment.center : MainAxisAlignment.end,
      children: <Widget>[
        SocialMedia(
          icon: FontAwesomeIcons.github,
          onPressed: () {
            _launchURL(githubUrl);
          },
          label: 'Github',
        ),
        SocialMedia(
          icon: FontAwesomeIcons.linkedin,
          label: 'Linkedin',
          onPressed: () {
            _launchURL(linkedinUrl);
          },
        ),
        SocialMedia(
          icon: FontAwesomeIcons.twitter,
          label: 'Twitter',
          onPressed: () {
            _launchURL(twitterUrl);
          },
        ),
        SocialMedia(
          icon: FontAwesomeIcons.envelopeOpen,
          label: 'Email',
          onPressed: () {
            _launchURL(email);
          },
        ),
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class SocialMedia extends StatelessWidget {
  const SocialMedia({
    Key key,
    @required this.icon,
    @required this.onPressed,
    this.label = '',
  }) : super(key: key);

  final IconData icon;
  final Function onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      hoverColor: Colors.transparent,
      tooltip: label,
      icon: Icon(
        icon,
        size: isMobile(context) ? 24.0 : 32.0,
      ),
    );
  }
}

class ResumeButton extends StatelessWidget {
  const ResumeButton({
    Key key,
    @required this.themeChange,
  }) : super(key: key);

  final DarkThemeProvider themeChange;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print('resume');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          getForegroundColor,
        ),
        // shape: MaterialStateProperty.resolveAs(value, states)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Resume.pdf',
          style: GoogleFonts.lato(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Color getForegroundColor(Set<MaterialState> states) {
    const interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
    };

    if (states.any(interactiveStates.contains)) {
      return themeChange.darkTheme ? Colors.teal : kDarkColor;
    }
    return themeChange.darkTheme ? Colors.teal : kDarkColor;
  }
}
