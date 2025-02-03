import 'dart:convert';
import 'dart:io';

import 'package:dually/provider/register/register_bloc.dart';
import 'package:dually/provider/register/register_bloc.dart';
import 'package:dually/route/pageroute.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../component/myTextForm.dart';
import '../../config/share_pref.dart';
import '../../utils/utils.dart';

class ProfileRegisterScreen extends StatefulWidget {
  @override
  _ProfileRegisterScreenState createState() => _ProfileRegisterScreenState();
}

class _ProfileRegisterScreenState extends State<ProfileRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  String? _selectedGender;
  var isLoading = false;
  File? _image;
  final imagePicker = ImagePicker();
  String? userImage = '';
  var isRemarkEnabled = true;
  var selfiImgBase64 = '';
  var selfiImg = '';
  bool _isLoading = false;
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTocken();
  }
  Future<void> getTocken() async {
     token = await getAccessToken();
    print("token  $token"); // Use the token for authentication or API calls
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            setState(() => _isLoading = true); // Show loading
          } else {
            setState(() => _isLoading = false); // Hide loading
          }

          if (state is RegisterFailure) {
            Utils.snackbarToast(state.error); // Display error message
          } else if (state is RegisterSuccess) {
            Navigator.pushReplacementNamed(context, RoutePath.homePage);
          }
        },

        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Let's setup your profile",
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 20.h),

                  _buildProfileImage(),
                  SizedBox(height: 30.h),
                  _buildNameField(),
                  SizedBox(height: 15.h),
                  _buildGenderDropdown(),
                  SizedBox(height: 15.h),
                  _buildAgeField(),
                  SizedBox(height: 15.h),
                  _buildBioField(),
                  SizedBox(height: 20.h),
                  _buildRegisterButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return _image == null
        ? GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: CircleAvatar(
        radius: 80.r,
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.camera_alt, size: 40.sp, color: Colors.black54),
      ),
    )
        : GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: CircleAvatar(
          radius: 80.r,
          backgroundColor: Colors.grey,
          backgroundImage: FileImage(
            _image!,
          )),
    );
  }


  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: InputDecoration(
          labelText: 'Gender', filled: true, fillColor: Colors.grey[200]),
      items: ['Male', 'Female', 'Other'].map((gender) {
        return DropdownMenuItem(value: gender, child: Text(gender));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
    );
  }

  Widget _buildNameField() {
    return MyTextForm(
      label: "Name",
      controller: _nameController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      keyboardType: TextInputType.emailAddress,
      validator: true,
      validatorFunc: Utils.validateUserName(),
      // prefix: const Icon(Icons.email_outlined,
      //   //color: Colors.black87
      // ), // Dark icon
      onChanged: (String) {},
    );
  }

  Widget _buildAgeField() {
    return MyTextForm(
      label: "Age",
      controller: _ageController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      keyboardType: TextInputType.number,
      validator: true,

      onChanged: (String) {},
    );
  }

  Widget _buildBioField() {
    return MyTextForm(
      label: "Bio",
      controller: _bioController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      keyboardType: TextInputType.text,
      validator: true,
      maxline: 3,
      // prefix: const Icon(Icons.email_outlined,
      //   //color: Colors.black87
      // ), // Dark icon
      onChanged: (String) {},
    );
  }

  Widget _buildRegisterButton() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              BlocProvider.of<RegisterBloc>(context).add(
                RegisterUser(
                   fullName: _nameController.text.toString(), gender: "", age: _ageController.text.toString(), bio: _bioController.text.toString(), token: token.toString(),
                ),
              );
              Navigator.pushNamed(context, RoutePath.login);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: Size(double.infinity, 50.h),
          ),
          child:  _isLoading
              ? CircularProgressIndicator()
              : Text('REGISTER', style: TextStyle(fontSize: 16.sp)),
        );
      },
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        // backgroundColor: Colors.black38,
        context: context,
        builder: (BuildContext) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Wrap(children: [
                Text('Upload Image',
                    textAlign: TextAlign.start),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        width: 60,
                        child: Wrap(
                          children: [
                            SizedBox(
                                width: 50,
                                child: Icon(Icons.camera_alt_outlined)),
                            const Text('Camera')
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                      child: VerticalDivider(
                        thickness: 2,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        width: 70,
                        child: Wrap(
                          children: [
                            SizedBox(
                                width: 50,
                                child:
                                Icon(Icons.image_outlined)),
                            const Text('Gallery')
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ]),
            ),
          );
        });
  }

  _imgFromCamera() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);

        final bytes = _image?.readAsBytesSync();
        selfiImgBase64 = base64Encode(bytes!);
      });
    }
  }

  _imgFromGallery() async {
    PickedFile? image = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }
}
