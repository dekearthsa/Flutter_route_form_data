import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title: 'Page1',
          description:
              "We are now in Page1 for learning Navigation - page transitions and routing"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: Text(
              'Page 1',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 25),
                width: 100,
                height: 40,
                child: ElevatedButton(
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Page2(
                                      title: "page2",
                                      description:
                                          "this is page2 now we say hello world")))
                        },
                    child: const Icon(Icons.arrow_forward_ios)),
              )
            ],
          )
        ]),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => Page2(title: "page2", description: "this is page2 now we say hello world")))
      //   },
      //   child: const Icon(Icons.arrow_forward_ios),
      // ),
    );
  }
}

class Page2 extends StatefulWidget {
  final String title;
  final String description;
  const Page2({required this.title, required this.description});

  @override
  MyPage2State createState() => MyPage2State();
}

class MyPage2State extends State<Page2> {
  final dio = Dio();
  bool isLoading = false;
  String dataOut = "";
  // List<dynamic> fetchData = [];

  @override
  void initState() {
    super.initState();
    fetchDataOut();
  }

  void fetchDataOut() async {
    setState(() {
      isLoading = true;
    });

    var gettingData = await dio
        .get("https://backend-hdt-haaracscade-zt27agut7a-as.a.run.app/debug");
    print('gettingData => $gettingData');

    setState(() {
      dataOut = gettingData.data;
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Page2",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(child: Text(widget.description)),
              Container(
                  child: isLoading
                      ? CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                        )
                      : Text('this from API DIO => $dataOut')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            height: 40,
                            margin: EdgeInsets.only(right: 10),
                            child: ElevatedButton(
                                onPressed: () => {Navigator.pop(context)},
                                child: const Icon(Icons.arrow_back_ios))),
                        Container(
                          width: 100,
                          height: 40,
                          margin: EdgeInsets.only(left: 10),
                          child: ElevatedButton(
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Page3(
                                            title: "page3",
                                            description:
                                                "this is page3 now we say hello flutter.",
                                          )))
                            },
                            child: const Icon(Icons.arrow_forward_ios),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class Page3 extends StatelessWidget {
  const Page3({required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Page3",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Text(description),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 25, right: 10),
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () => {Navigator.pop(context)},
                          child: Icon(Icons.arrow_back_ios))),
                  Container(
                    margin: EdgeInsets.only(top: 25, left: 10),
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      child: const Icon(Icons.arrow_forward_ios),
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormPage(
                                      title: "Form-page",
                                      description: "Form enter your infomation",
                                    )))
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class FormPage extends StatefulWidget {
  final String title;
  final String description;
  const FormPage({required this.title, required this.description});

  @override
  MyFormPage createState() => MyFormPage();
}

class MyFormPage extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  String onsaveData = "";
  String onChangedData = "";

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            //   child: TextField(decoration:
            //     InputDecoration(labelText: "OnChanged")
            //   ),
            // ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Form(
                  child: TextFormField(
                // เป็น input ที่จะรับเฉพาะ String
                decoration: InputDecoration(labelText: "OnChanged"),
                initialValue: "onChange", // ค่าเริ่มต้นของ input
                onChanged: ((value) => setState(() {
                      onChangedData = value!;
                    })), // เป็นการ save ข้อมูล auto ทุกครั้งที่มีการกด keyboard ค่าของ form จะเปลี่ยนไป
              )),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: "OnSaved"),
                        initialValue: '',
                        onSaved: ((value) => setState(() {
                              // ต้องมีปุ่ม save เมื่อกดถึงจะแสดงค่า ค่า value จะต้องไม่เป็น null เพราะงั้งต้องใส่ ! ไว้หลัง value
                              onsaveData =
                                  value!; // ใช้ setState สำหรับการอัพเดทค่าไป value ที่ได้จาก input ไปยัง ตัวแปล onsaveData ที่ประกาศไว้
                            })),
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       // print(_formKey.currentState);
                      //       if (_formKey.currentState!.validate()) {
                      //         _formKey.currentState!.save();
                      //         print(onsaveData);
                      //         print("save!");
                      //       }
                      //     },
                      //     child: Text("Save"))
                    ],
                  )),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100.0,
                  height: 40.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        // print(_formKey.currentState);
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print(onsaveData);
                          print("save!");
                        }
                      },
                      child: Text("Save")),
                ),
                Container(
                  width: 100.0,
                  height: 40.0,
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: ElevatedButton(
                    onPressed: () => {print('my save data =>  $onsaveData')},
                    child: Text("Debug"),
                  ),
                ),
                Container(
                  width: 100.0,
                  height: 40.0,
                  margin: EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(
                            title: 'Page1',
                            description: onsaveData,
                          ),
                        ),
                      ),
                    },
                    child: Text("Home"),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Text(
                        "Show onChanged data => ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Text(onChangedData),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  width: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 110,
                        margin: EdgeInsets.only(right: 10.0),
                        child: ElevatedButton(
                          onPressed: () => {Navigator.pop(context)},
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Container(
                        width: 110,
                        margin: EdgeInsets.only(left: 10.0),
                        child: ElevatedButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RadioPage(
                                  title: 'Radio Page',
                                  description: onsaveData,
                                ),
                              ),
                            ),
                          },
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadioPage extends StatefulWidget {
  final String title;
  final String description;
  const RadioPage({required this.title, required this.description});

  @override
  MyRadioPage createState() => MyRadioPage();
}

class MyRadioPage extends State<RadioPage> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String selectedGender = "";
  String isError = "";

  void _onChangeGender(String genderValue) {
    print(genderValue);
    setState(() {
      selectedGender = genderValue;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(labelText: "name"),
                  initialValue: '',
                  onSaved: (value) => {
                    setState(() {
                      name = value!;
                    })
                  },
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Male"),
                  Radio(
                      value: 'male',
                      groupValue: selectedGender,
                      onChanged: (value) => _onChangeGender(value!)),
                  Text("Female"),
                  Radio(
                      value: 'female',
                      groupValue: selectedGender,
                      onChanged: (value) => _onChangeGender(value!)),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text('Data on Form page => '),
                  ),
                  Container(
                    child: Text(widget.description),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              width: 100.0,
              height: 40.0,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print('name => $name, gender => $selectedGender');
                  }
                },
                child:
                    Text("Save", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                isError,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              width: 100,
              height: 40,
              child: ElevatedButton(
                child: Text(
                  "Next",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (name != "" && selectedGender != "") {
                    print("No error");
                    setState(() {
                      isError = "";
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowInfoPages(
                                  title: "Show infomation",
                                  description: "data from radio page",
                                  name: name,
                                  gender: selectedGender,
                                )));
                  } else {
                    print("Error!");
                    setState(
                      () {
                        isError = "all value must not be empty.";
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShowInfoPages extends StatelessWidget {
  const ShowInfoPages(
      {required this.title,
      required this.description,
      required this.name,
      required this.gender});

  final String title;
  final String description;
  final String name;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Text(description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("name: "),
                ),
                Container(
                  child: Text(name),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("gender: "),
                ),
                Container(
                  child: Text(gender),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
