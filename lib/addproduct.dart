import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: WizardForm(),
    );
  }
}

class WizardFormBloc extends FormBloc<String, String> {
  static File image;
  static File image2;
  static File image3;
  static File image4;
  // ignore: close_sinks
  final username = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  // ignore: close_sinks
  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );
  // ignore: close_sinks

  // ignore: close_sinks
  final number = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  // ignore: close_sinks
  final firstname = TextFieldBloc();

  final lastName = TextFieldBloc();

  // ignore: close_sinks
  final gender = SelectFieldBloc(
    items: ['Chemise', 'Pantalon', 'Habit'],
  );

  final birthDate = InputFieldBloc<DateTime, Object>(
    validators: [FieldBlocValidators.required],
  );

  final github = TextFieldBloc();

  final twitter = TextFieldBloc();

  final facebook = TextFieldBloc();

  WizardFormBloc() {
    addFieldBlocs(
      step: 0,
      fieldBlocs: [username, email, number, firstname],
    );
    addFieldBlocs(
      step: 1,
      fieldBlocs: [gender],
    );
    addFieldBlocs(
      step: 2,
      fieldBlocs: [github, twitter, facebook],
    );
  }

  bool _showEmailTakenError = true;

  get tel => null;
  @override
  @override
  void onSubmitting() async {
    var nameP = username.value;
    var price = number.value;
    var emailass = email.value;
    // var description = description.value;
    var genders = gender.value;
    var firstName = firstname.value;

    if (state.currentStep == 0) {
      await Future.delayed(Duration(milliseconds: 500));
      emitSuccess();
      _submitting1(nameP, price, emailass, firstName);
    } else if (state.currentStep == 1) {
      emitSuccess();
      _submitting2(genders, emailass);
    } else if (state.currentStep == 2) {
      await Future.delayed(Duration(milliseconds: 500));

      emitSuccess();
      uploadImage(emailass);
    }
  }

  // uploading image
  Future uploadImage(String email) async {
    //File image;
    final uri = Uri.parse("http://mestps.tech/photosCategories.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields['email'] = email;
    var pic = await http.MultipartFile.fromPath("image", image.path);
    var pic2 = await http.MultipartFile.fromPath("image2", image2.path);
    var pic3 = await http.MultipartFile.fromPath("image3", image3.path);
    var pic4 = await http.MultipartFile.fromPath("image4", image4.path);
    request.files.add(pic);
    request.files.add(pic2);
    request.files.add(pic3);
    request.files.add(pic4);

    var response = await request.send();
    if (response.statusCode == 200) {
      print("succes");
    } else {
      print('died');
    }
  }

  //categories
  Future _submitting2(String holder, String email) async {
    final uri = Uri.parse("http://mestps.tech/addPrdoduc2.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields['categories'] = holder;
    request.fields['email'] = email;
    var response = await request.send();
    if (response.statusCode == 200) {
      print("success");
    } else {
      print("died");
    }
  }
}

Future _submitting1(
    String nameP, String price, String email, String firstname) async {
  final uri = Uri.parse("http://mestps.tech/addProduct.php");
  var request = http.MultipartRequest("POST", uri);
  request.fields['name'] = nameP;
  request.fields['prix'] = price;
  request.fields['email'] = email;
  request.fields['description'] = firstname;
  var response = await request.send();
  if (response.statusCode == 200) {
    print("success");
  } else {
    print("died");
  }
}

class WizardForm extends StatefulWidget {
  final String email;
  WizardForm({Key key, @required this.email}) : super(key: key);
  @override
  _WizardFormState createState() => _WizardFormState(this.email);
}

class _WizardFormState extends State<WizardForm> {
  var _type = StepperType.horizontal;
  String email;
  _WizardFormState(this.email);
  //File image;
  final picker = ImagePicker();
  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      WizardFormBloc.image = File(pickedImage.path);
    });
  }

  Future choiceImage2() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      WizardFormBloc.image2 = File(pickedImage.path);
    });
  }

  Future choiceImage3() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      WizardFormBloc.image3 = File(pickedImage.path);
    });
  }

  Future choiceImage4() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      WizardFormBloc.image4 = File(pickedImage.path);
    });
  }

  void _toggleType() {
    setState(() {
      if (_type == StepperType.horizontal) {
        _type = StepperType.vertical;
      } else {
        _type = StepperType.horizontal;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WizardFormBloc(),
      child: Builder(
        builder: (context) {
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text('Ajouter un produit'),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(_type == StepperType.horizontal
                          ? Icons.swap_vert
                          : Icons.swap_horiz),
                      onPressed: _toggleType)
                ],
              ),
              body: SafeArea(
                child: FormBlocListener<WizardFormBloc, String, String>(
                  onSubmitting: (context, state) => LoadingDialog.show(context),
                  onSuccess: (context, state) {
                    LoadingDialog.hide(context);

                    if (state.stepCompleted == state.lastStep) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => SuccessScreen()));
                    }
                  },
                  onFailure: (context, state) {
                    LoadingDialog.hide(context);
                  },
                  child: StepperFormBlocBuilder<WizardFormBloc>(
                    type: _type,
                    physics: ClampingScrollPhysics(),
                    stepsBuilder: (formBloc) {
                      return [
                        _accountStep(formBloc),
                        _personalStep(formBloc),
                        _socialStep(formBloc),
                      ];
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  FormBlocStep _accountStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: Text('Info produit'),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.username,
            keyboardType: TextInputType.emailAddress,
            enableOnlyWhenFormBlocCanSubmit: true,
            decoration: InputDecoration(
              labelText: 'Nom produit',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.number,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Prix',
              prefixIcon: Icon(Icons.attach_money),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.email,
            keyboardType: TextInputType.emailAddress,
            //suffixButton: SuffixButton.obscureText,
            decoration: InputDecoration(
              labelText: 'Confirmez votre email actuel',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          TextFieldBlocBuilder(
            maxLines: 5,
            textFieldBloc: wizardFormBloc.firstname,
            //keyboardType: TextInputType.text,
            //suffixButton: SuffixButton.obscureText,
            decoration: InputDecoration(
              labelText: 'Entrer une description du produit',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          // FlatButton(onPressed: null, child: Text("Continer"))
        ],
      ),
    );
  }

  FormBlocStep _personalStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: Text('Categories'),
      content: Column(
        children: <Widget>[
          RadioButtonGroupFieldBlocBuilder<String>(
            selectFieldBloc: wizardFormBloc.gender,
            itemBuilder: (context, value) => value,
            decoration: InputDecoration(
              labelText: 'Categories',
              prefixIcon: SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  FormBlocStep _socialStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: Text('Image'),
      content: Column(
        children: <Widget>[
          FlatButton(
              onPressed: () {
                choiceImage();
              },
              child: Icon(
                Icons.add_a_photo,
                size: 70.0,
              )),
          Text('Ajouter image Princicial'),
          FlatButton(
              onPressed: () {
                choiceImage2();
              },
              child: Icon(
                Icons.add_a_photo,
                size: 70.0,
              )),
          Text('Ajouter image 1'),
          FlatButton(
              onPressed: () {
                choiceImage3();
              },
              child: Icon(
                Icons.add_a_photo,
                size: 70.0,
              )),
          Text('Ajouter image 2'),
          FlatButton(
              onPressed: () {
                choiceImage4();
              },
              child: Icon(
                Icons.add_a_photo,
                size: 70.0,
              )),
          Text('Ajouter image 3'),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            shrinkWrap: true,
            children: List.generate(
              2,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      child: WizardFormBloc.image == null
                          ? Text(
                              "pas d'image selectionéé ",
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            )
                          : Image.file(WizardFormBloc.image)),
                );
              },
            ),
          ),
          //TextFieldBlocBuilder(
          // textFieldBloc: wizardFormBloc.facebook,
          // keyboardType: TextInputType.emailAddress,
          //decoration: InputDecoration(
          // labelText: 'Facebook',
          //prefixIcon: Icon(Icons.sentiment_satisfied),
          //),
          // ),
        ],
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Bravo',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => WizardForm(
                            key: key,
                            email: email,
                          ))),
              icon: Icon(Icons.replay),
              label: Text('Encore ?'),
            ),
          ],
        ),
      ),
    );
  }
}
