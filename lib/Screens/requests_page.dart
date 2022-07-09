import 'package:blood_donation/Screens/all_requests.dart';
import 'package:blood_donation/Screens/new_requests.dart';
import 'package:blood_donation/constants/color_constants.dart';
import 'package:blood_donation/l10n/locale_keys.g.dart';
import 'package:blood_donation/viewModels/profile_form_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../Size Config/size_config.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  void initState() {
    super.initState();
    print('requests....');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.blockSizeVertical!;
    var w = SizeConfig.blockSizeHorizontal!;
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(h * 20),
          child: TabBar(
            labelColor: primaryDesign,
            unselectedLabelColor: primaryColor,
            labelStyle: const TextStyle(fontWeight: FontWeight.w700),
            labelPadding: EdgeInsets.only(top: h * 4, bottom: h * 1),
            indicatorWeight: 3,
            indicator: UnderlineTabIndicator(
                insets: EdgeInsets.symmetric(horizontal: w * 10),
                borderSide: BorderSide(width: 3, color: primaryDesign!)),
            tabs: [
              Text(
                LocaleKeys.newrequests.tr(),
              ),
              Text(LocaleKeys.allrequests.tr()),
            ],
          ),
        ),
        body: TabBarView(
          children: [NewRequestsPage(), AllRequests()],
        ),
      ),
    ));
  }
}
