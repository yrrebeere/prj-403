import 'package:flutter/material.dart';
import 'editprofile.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  String name = "John Doe"; // Initial values for demonstration
  String companyName = "ABC Company";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6FB457),
        title: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Text('WASAIL'),
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
              child: Text('Edit Profile'),
            ),

            // Add more profile information widgets here
          ],
        ),
      ),
    );
  }
}
