import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/config.dart';
import 'package:mms_app/core/storage/local_storage.dart';
import 'package:mms_app/screens/widgets/buttons.dart';
import 'package:mms_app/screens/widgets/custom_textfield.dart';
import 'package:mms_app/screens/widgets/snackbar.dart';
import 'package:mms_app/screens/widgets/text_widgets.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import 'package:mms_app/screens/widgets/utils.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();

  String imageUrl;

  @override
  void initState() {
    name.text = AppCache.getUser.name;
    email.text = AppCache.getUser.email;
    imageUrl = AppCache.getUser.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/authbg.png'), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              children: [
                regularText(
                  'Edit Profile',
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20.h),
                      child: InkWell(
                        onTap: () {
                          getImageGallery();
                        },
                        child: Container(
                          height: 160.h,
                          width: 160.h,
                          padding: EdgeInsets.all(25.h),
                          decoration: BoxDecoration(
                              color: Color(0xffC8C7CC),
                              borderRadius: BorderRadius.circular(10.h)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(55.h),
                            child: imageFile != null
                                ? Image.file(
                                    imageFile,
                                    height: 110.h,
                                    width: 110.h,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: imageUrl ?? 'm',
                                    height: 100.h,
                                    width: 100.h,
                                    fit: BoxFit.cover,
                                    placeholder: (_, __) => Image.asset(
                                      'images/placeholder.png',
                                      height: 100.h,
                                      width: 100.h,
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (BuildContext context,
                                            String url, dynamic error) =>
                                        Image.asset(
                                      'images/placeholder.png',
                                      height: 100.h,
                                      width: 100.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30.h),
                item('Name'),
                CustomTextField(
                  hintText: 'Enter password',
                  textInputType: TextInputType.text,
                  controller: name,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 16.h),
                item('Email Address'),
                CustomTextField(
                  hintText: 'Enter email',
                  validator: Utils.validateEmail,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: email,
                  readOnly: true,
                ),
                SizedBox(height: 30.h),
                buttonWithBorder(
                  'CONFIRM',
                  height: 65.h,
                  busy: isLoading,
                  onTap: () {
                    setState(() {});
                    if (name.text.isEmpty) {
                      showSnackBar(context, null, 'Enter your name');
                      return;
                    }
                    confirmProfile();
                  },
                ),
              ],
            ),
          )),
    );
  }

  void confirmProfile() async {
    setState(() {
      isLoading = true;
    });

    String url = AppCache.getUser.image;
    String uid = AppCache.getUser.uid;
    try {
      if (imageFile != null) {
        Reference reference =
            FirebaseStorage.instance.ref().child("images/$uid");

        UploadTask uploadTask = reference.putFile(imageFile);
        TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() => null));
        url = await downloadUrl.ref.getDownloadURL();
      }

      Map<String, dynamic> mData = AppCache.getUser.toJson();

      mData.update("name", (a) => name.text.trim());
      mData.update("email", (a) => email.text);
      mData.update("updated_at", (a) => DateTime.now().millisecondsSinceEpoch);
      mData.update("image", (a) => url);

      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      DocumentReference userRef = _firestore.collection("Users").doc(uid);

      WriteBatch writeBatch = _firestore.batch();

      writeBatch.update(userRef, mData);

      await writeBatch.commit();

      setState(() {
        isLoading = false;
      });

      showSnackBar(context, 'Success', 'Profile has been updated');
      AppCache.setUser(mData);
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'Error', e.message);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'Error', e.toString());
    }
  }

  bool isLoading = false;
  File imageFile;

  Future<void> getImageGallery() async {
    Utils.offKeyboard();
    final XFile result =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      imageFile = File(result.path);
    } else {
      return;
    }
    setState(() {});
  }

  Widget item(String a) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h, left: 10.h),
      child: regularText(
        a,
        fontSize: 12.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
