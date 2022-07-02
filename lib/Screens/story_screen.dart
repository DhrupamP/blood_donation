import 'package:blood_donation/Models/story_model.dart';
import 'package:blood_donation/Widgets/continue_button.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/viewModels/story_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:blood_donation/Providers/storyscreen_provider.dart';
import '../Size Config/size_config.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  TextEditingController storycontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Your Story',
          style: TextStyle(color: primaryText),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<StoryProvider>(context, listen: false).storyimg =
                  null;
            },
            icon: Icon(
              FontAwesomeIcons.leftLong,
              color: secondaryText,
            )),
      ),
      body: Consumer<StoryProvider>(
        builder: (context, value, child) {
          return Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await StoryViewModel.instance.addStoryImage(context);
                  },
                  child: Container(
                      width: w * 86.11,
                      height: h * 19.6,
                      decoration: BoxDecoration(
                          color: secondaryText,
                          borderRadius: BorderRadius.circular(10)),
                      child: value.storyimg == null
                          ? Stack(
                              children: [
                                Align(
                                  child: Container(
                                    height: h * 7.1,
                                    width: w * 15.56,
                                    decoration: BoxDecoration(
                                        color: background,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Icon(
                                      Icons.upload_rounded,
                                      color: secondaryText,
                                      size: h * 4,
                                    ),
                                  ),
                                  alignment: Alignment(0, -0.4),
                                ),
                                Align(
                                  child: Text(
                                    'Upload your Story',
                                    style: TextStyle(
                                      fontSize: h * 1.53,
                                      color: white,
                                    ),
                                  ),
                                  alignment: Alignment(0, 0.4),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                value.storyimg!,
                                fit: BoxFit.fill,
                              ),
                            )),
                ),
                SizedBox(
                  height: h * 1.79,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: SizeConfig.blockSizeVertical! * 42.8,
                    width: SizeConfig.blockSizeHorizontal! * 86.11,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: TextFormField(
                      controller: storycontroller,
                      maxLines: 16,
                      style: TextStyle(
                        color: primaryText,
                      ),
                      // controller: widget.controller,
                      cursorColor: primaryText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        hintText: 'Write your story',
                        hintStyle: TextStyle(
                            color: secondaryText,
                            fontSize: SizeConfig.blockSizeVertical! * 2.05),
                        errorStyle: const TextStyle(
                            textBaseline: TextBaseline.alphabetic),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryText!)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: primaryText!, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 1.79,
                ),
                ContinueButton(
                  txt: 'Done',
                  bgcolor: primaryDesign,
                  txtColor: white,
                  onpressed: () {
                    Navigator.pop(context);
                    Provider.of<StoryProvider>(context, listen: false)
                        .storyimg = null;
                    StoryModel story = StoryModel(
                        title: 'Title',
                        description: storycontroller.text,
                        postCreationDate: DateTime.now().toString());
                    StoryViewModel.instance.addStory(context, story);
                  },
                )
              ],
            ),
          );
        },
      ),
    ));
  }
}
