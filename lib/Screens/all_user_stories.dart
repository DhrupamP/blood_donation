import 'package:blood_donation/Providers/profile_provider.dart';
import 'package:blood_donation/Screens/home_page.dart';
import 'package:blood_donation/Size%20Config/size_config.dart';
import 'package:blood_donation/Widgets/story_widget.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/viewModels/story_viewmodel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AllUserStories extends StatefulWidget {
  const AllUserStories({Key? key}) : super(key: key);

  @override
  _AllUserStoriesState createState() => _AllUserStoriesState();
}

class _AllUserStoriesState extends State<AllUserStories> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              elevation: 0,
              leading: BackButton(color: secondaryText),
              backgroundColor: white,
            ),
            body: Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 2),
              child: ListView.builder(
                itemCount: userstories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.blockSizeVertical! * 1.5),
                    child: Story(
                      url: userstories[index].photoURL,
                      date: userstories[index].postCreationDate,
                      description: userstories[index].description,
                    ),
                  );
                },
              ),
            )));
  }
}
