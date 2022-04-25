
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import '../activity_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../activity_screen.dart';

class addVideo extends StatefulWidget{

  _addVideoState createState() => _addVideoState();
}

class _addVideoState extends State<addVideo> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController controlvideotitle = new TextEditingController();
  TextEditingController controlvideodesc = new TextEditingController();

  File? studioVideo;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    child: Form(key: _formKey,

                      child: paddingg(12, 12, 5, Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            padding(10, 12, Container(
                                alignment: Alignment.topRight, child: Text(
                              ' اضافة فيديو جديد', style: TextStyle(
                                fontSize: 18.sp,
                                color: textBlack,
                                fontFamily: 'Cairo'),)),),

                            SizedBox(height: 20.h,),

                            paddingg(15, 15, 12, textFieldNoIcon(
                                context,
                                'عنوان الفيديو',
                                14,
                                false,
                                controlvideotitle, (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                                false),),
                            paddingg(15, 15, 12, textFieldDesc(
                                context, 'وصف الفيديو', 14, false,
                                controlvideodesc, (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            }),),


                            SizedBox(height: 20.h),
                            paddingg(15, 15, 12, uploadImg(200, 54,
                                text(context, 'قم برفع فيديو ', 12, black), () {
                                  getVideo(context);
                                }),),

                            SizedBox(height: 20.h),
                            padding(15, 15, gradientContainerNoborder(getSize(
                                context).width,
                                buttoms(context, 'اضافة ', 15, white, () {
                                  addvideo();
                                  goTopageReplacement(context, ActivityScreen()) ;
                                })),),
                            const SizedBox(height: 30,),
                          ]),
                      ),

                    ))
            )
        ),
      ),
    );
  }

  addvideo() async {
    String token2 =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWNjMTA1MjcxODRhN2QzYTIwNDJkYTdmNTMyNTA4ZTdjMDE4NWQwOWI3MzRkY2VhMGEzZjYxY2U3MjRmYmM4M2M5ZTcwNGYyYmNjYmIwNjAiLCJpYXQiOjE2NTA3MzU4NjEuMDQ2MzQwOTQyMzgyODEyNSwibmJmIjoxNjUwNzM1ODYxLjA0NjM0NTk0OTE3Mjk3MzYzMjgxMjUsImV4cCI6MTY4MjI3MTg2MS4wNDEzODQ5MzUzNzkwMjgzMjAzMTI1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Dp0SkGykv6S4A3maaSmgkWMfKCXbumkxg8cmCJcgoBmFOjxwiKht2vywEnOXtPyFSV7BY48IpvrO6xlrfCE9Oy5wSp86caE-uYEo-uHgzsuRqf-hHpL9DcNsrfuZBQi4h3GiiCfyYV0362FkVl_hclamppj8VL-S7C02_Ddg7Ygnlce3-k8Hm8NRutBREsk4or75C-1mL70ArOCWuLazaUbAJexN2MuLMjqQF9h-pgcaQhEY3rhBEarcEcfdREJgGy_5zARbAdSi_mwclQCqNr9KatmRhkDL_My0GqmGvkt8RUSb_Uo93NXv9lvdw41gMcrStKvVbGg4RMRSxPRD_P9I8-26Ipasx5wMlFdZU10-mSrGKDLu3d4vxVcLFcQIwQqK19m5urFdgMVznRBqEnqceQUb_UjUh8i7VOa8rRUFFbLy7ALZaAk23DtVz25AHRIaYbV_jmgXbx_9IuJc3-dslYVvfGbtgRniKgLEDHKgWgVfiljUU9aUZmIh7i1uYgDZm1LBDWY_wPRQdPoQedfSiLs0Qy1ZmfahRBRWgNKFZDMoKvhtbuuP3rJLcIiQ'
        '6nLbyu1i4ma8ly74po4bYZcQDKTFx1oSi2fkUkDF_ZtqLFnx7xvzfXY-Za8krfB-AThg7Phi8-KVCdlTza_KwqkQciGzG4MD3-eY62JXIIU';


    var stream = new http.ByteStream(
        DelegatingStream.typed(studioVideo!.openRead()));
    // get file length
    var length = await studioVideo!.length();

    // string to uri
    var uri =
    Uri.parse("https://mobile.celebrityads.net/api/celebrity/studio/add");

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token2"
    };
    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(studioVideo!.path));

    // add file to multipart
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    request.fields["title"] = controlvideotitle.text;
    request.fields["description"] = controlvideodesc.text;
    request.fields["type"] = "vedio";
    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future<File?> getVideo(context) async {
    PickedFile? pickedFile =
    await ImagePicker.platform.pickVideo(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    }
    final File file = File(pickedFile.path);
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final String fileName = Path.basename(pickedFile.path);
   final String fileExtension = Path.extension(fileName);
    File newVideo = await file.copy('$path/$fileName');
    setState(() {
      if(fileExtension == ".mp4"){
        studioVideo = newVideo;
      }else{ ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text(
            "يجب ان يكون امتداد الفديو .mp4",style: TextStyle(color: Colors.red)),
      ));}

    });
  }
}
