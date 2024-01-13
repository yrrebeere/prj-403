import 'package:flutter/material.dart';
import 'editprofile.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../SelectLanguage/languageprovider.dart';
import 'package:provider/provider.dart';

class ViewProfile extends StatefulWidget {
  final Map<String, dynamic>? userData;

  ViewProfile({required this.userData});

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  late String name;
  late String companyName;

  @override
  void initState() {
    super.initState();
    name = widget.userData?['name'] ?? '';
    companyName = widget.userData?['companyName'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6FB457),
        title: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Text(
            AppLocalizations.of(context)!.app_name,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Color(0xFF6FB457),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(name, style: TextStyle(fontSize: 20)),
            Text(companyName, style: TextStyle(fontSize: 17, color: Colors.grey)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Add logic to navigate to the edit profile screen and receive updated data
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
                  ),
                );

                // Check if result is not null and update the profile information
                if (result != null) {
                  setState(() {
                    // Update profile information using the received data
                    String updatedName = result['name'];
                    String updatedCompanyName = result['companyName'];
                    // Update the profile information as needed

                    // Add the following lines to pass the updated data to Menu
                    Navigator.pop(context, {'name': updatedName, 'companyName': updatedCompanyName});
                  });
                }
              },
              child: Text(AppLocalizations.of(context)!.edit),
            ),

            // Add more profile information widgets here
          ],
        ),
      ),
    );
  }
}
