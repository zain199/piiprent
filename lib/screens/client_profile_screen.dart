import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piiprent/models/client_contact_model.dart';
import 'package:piiprent/screens/change_password_screen.dart';
import 'package:piiprent/services/contact_service.dart';
import 'package:piiprent/services/login_service.dart';
import 'package:piiprent/widgets/client_app_bar.dart';
import 'package:piiprent/widgets/form_field.dart';
import 'package:piiprent/widgets/page_container.dart';
import 'package:piiprent/widgets/profile_group.dart';
import 'package:provider/provider.dart';

class ClientProfileScreen extends StatefulWidget {
  @override
  _ClientProfileScreenState createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  var newimage = "";

  onTapImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      newimage = image.path;
    });
  }

  Widget _buildContactDetails(ClientContact contact) {
    return ProfileGroup(
      title: translate('group.title.contact_details'),
      onEdit: () {},
      content: [
        Container(
          child: Field(
            label: translate('field.email'),
            initialValue: contact.email,
            readOnly: true,
          ),
        ),
        Container(
          child: Field(
            label: translate('field.phone'),
            initialValue: contact.phone,
            readOnly: true,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ContactService contactService = Provider.of<ContactService>(context);
    LoginService loginService = Provider.of<LoginService>(context);

    return Scaffold(
      appBar: getClientAppBar(translate('page.title.profile'), context),
      body: FutureBuilder(
        future: contactService.getCompanyContactDetails(loginService.user.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          ClientContact contact = snapshot.data as ClientContact;
          print(contact.fullName);

          return SingleChildScrollView(
            child: PageContainer(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () => onTapImage(),
                    child: Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                          image: contact.avatar != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: newimage != null && newimage.isNotEmpty
                                      ? FileImage(File(newimage))
                                      : NetworkImage(
                                          contact.avatar,
                                        ),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    contact.fullName,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18.0),
                  ),
                  Center(
                    child: Text(
                      contact.company,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      contact.jobTitle,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  _buildContactDetails(contact),
                  SizedBox(
                    height: 15.0,
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 10),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      translate('button.change_password'),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
