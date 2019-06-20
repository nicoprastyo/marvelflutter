import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    List responseList;
    bool loading;
    String textdata;


    Future getDataMarvels() async{
      setState(() {

        loading=true;
      });
      var url= 'http://elearningppm.com/webservice/rest/server.php?wstoken=bd13a3e34973313147c2b345062cee0f&moodlewsrestformat=json&wsfunction=core_course_get_courses&options[ids][0]=3';
      var res = await http.get(url);

      http.Response response=await http.get(url);
      List json = jsonDecode(res.body);


      int code = response.statusCode;
      if(code==200){
          setState(() {
            responseList = json;
            loading=false;
            Toast.show("Ada Data, Mohon Tunggu...", context,duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
            textdata=responseList.toString();
            print('Text data'+textdata);
          });
      }else{
          Toast.show("Ada masalah, coba lagi...", context,duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      }
    }
@override
  void initState() {
    // TODO: implement initState
    getDataMarvels();
    super.initState();
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Marvel App'),
          ),
          body: Text(textdata),
      );
    }
}