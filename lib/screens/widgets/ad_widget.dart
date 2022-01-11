import 'dart:async';
import 'dart:math';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/core/models/ad_model.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AdWidget extends StatefulWidget {
  @override
  _AdWidgetState createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  StreamSubscription listener;
  AdModel adModel;

  @override
  void initState() {
    listener = FirebaseFirestore.instance
        .collection('Ads')
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        List<AdModel> ads = [];
        Random rnd = Random(event.docs.length);
        event.docs.forEach((element) {
          ads.add(AdModel.fromJson(element.data()));
        });
        adModel = ads[rnd.nextInt(event.docs.length)];
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return adModel == null
        ? SizedBox()
        : InkWell(
            onTap: () => launch(adModel.url),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.h),
              child: CachedNetworkImage(
                imageUrl: adModel.image ?? 'm',
                height: 80.h,
                fit: BoxFit.fitWidth,
                placeholder: (_, __) => Image.asset(
                  'images/logo.png',
                  height: 70.h,
                  fit: BoxFit.fitWidth,
                  width: SizeConfig.screenWidth,
                ),
                errorWidget:
                    (BuildContext context, String url, dynamic error) =>
                        InkWell(
                  onTap: () {
                    String _messageTitle = Uri.encodeComponent("Message TriviaBlog");
                    String _messageBody = Uri.encodeComponent('I want to book an Ad...');
                    String _url =
                        "mailto:info@triviablog.ng?subject=$_messageTitle&body=$_messageBody";
                    launch(_url);
                  },
                  child: Container(
                    height: 80.h,
                    alignment: Alignment.center,
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.h),
                      color: AppColors.white,
                    ),
                    child: regularText(
                      'Ad Space Here',
                      fontSize: 18.sp,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
