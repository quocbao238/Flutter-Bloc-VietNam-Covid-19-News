import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vietnamcovidtracking/source/config/size_app.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/homePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget _header() {
      Widget _btnCallSms(
          {required String title,
          required IconData icon,
          required Function onTap,
          required Color backgroundcolor}) {
        return TextButton(
          onPressed: () => onTap(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.white),
              SizedBox(width: 8.0),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12)),
            backgroundColor:
                MaterialStateProperty.all(backgroundcolor), //Background Color
            elevation: MaterialStateProperty.all(3), //Defines Elevation
            shadowColor: MaterialStateProperty.all(Colors.grey), //Define
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
                // side: BorderSide(color: Colors.red),
              ),
            ),
          ),
        );
      }

      return Container(
        padding: EdgeInsets.only(
            left: SizeApp.normalPadding,
            right: SizeApp.normalPadding,
            bottom: SizeApp.normalPadding),
        decoration: BoxDecoration(
            color: ThemePrimary.primaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Viet Nam Covid Tracking",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.white),
            ),
            SizedBox(height: SizeApp.normalPadding * 2),
            Text(
              "Bạn có cảm thấy như bị bệnh không?",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.white),
            ),
            SizedBox(height: SizeApp.normalPadding),
            Text(
              "Nếu bạn cảm thấy bị bệnh với bất kỳ triệu chứng Covid-19 nào, vui lòng gọi hoặc nhắn tin SMS cho chúng tôi ngay lập tức để được giúp đỡ",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.white),
            ),
            SizedBox(height: SizeApp.normalPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _btnCallSms(
                    title: "Gọi ngay",
                    icon: Icons.phone,
                    backgroundcolor: ThemePrimary.green,
                    onTap: () {}),
                SizedBox(width: 16.0),
                _btnCallSms(
                    title: "Gửi tin nhắn",
                    backgroundcolor: ThemePrimary.orange,
                    icon: LineIcons.sms,
                    onTap: () {})
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      );
    }

    Widget _center() {
      Widget __preventionItem({required String title, required String svgUrl}) {
        return Expanded(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                      child: SvgPicture.asset(svgUrl, fit: BoxFit.fill))),
              SizedBox(height: SizeApp.paddingTxt),
              Text(title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }

      return Expanded(
        child: Container(
          padding: EdgeInsets.all(SizeApp.normalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Phòng ngừa", style: Theme.of(context).textTheme.headline2!),
              SizedBox(height: SizeApp.normalPadding + 8),
              Container(
                // height: MediaQuery.of(context).size.width / 3,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.width / 2.8),
                // color: Colors.red,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    __preventionItem(
                      title: "Tránh tiếp xúc gần",
                      svgUrl: "assets/svg/avoidclosecontact.svg",
                    ),
                    __preventionItem(
                      title: "Làm sạch tay thường xuyên",
                      svgUrl: "assets/svg/cleanhands.svg",
                    ),
                    __preventionItem(
                      title: "Luôn mang khẩu trang",
                      svgUrl: "assets/svg/facemask.svg",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget _bottom() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        padding: EdgeInsets.all(SizeApp.normalPadding),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 24.0),
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.18,
                  right: SizeApp.normalPadding,
                  top: SizeApp.paddingTxt,
                  bottom: SizeApp.paddingTxt),
              decoration: BoxDecoration(
                  // color: ThemePrimary.primaryColor,
                  gradient: LinearGradient(colors: [
                    ThemePrimary.primaryColor,
                    ThemePrimary.primaryColor.withOpacity(0.4)
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bạn đã sẵn sàng?",
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.white),
                    ),
                    SizedBox(height: SizeApp.paddingTxt),
                    Text(
                      "Chung sức vì cộng đồng vượt qua đại dịch",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 0,
                bottom: 0,
                left: 15,
                child: SvgPicture.asset(
                  "assets/svg/owntest.svg",
                  height: MediaQuery.of(context).size.height * 0.15,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ))
          ],
        ),
      );
    }

    return Scaffold(
      // appBar: AppBar(elevation: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_header(), _center(), _bottom()],
      ),
    );
  }
}
