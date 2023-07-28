import 'package:draggable_customized_btn_navy_bar/draggable_customized_btn_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:one_shot/Models/FriendRequestModel.dart';
import 'package:one_shot/Shared/Constants.dart';
import '../../Components/SearchAppBar.dart';
import '../../Models/MessageModel.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/Home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _itemSelected = 'Msg';
  @override
  Widget build(BuildContext context) {
    TextEditingController searchBarController = TextEditingController();
    return Scaffold(
      appBar: _itemSelected == "Requests"?buildAppBar(searchBarController, 'Search For Friends'):buildAppBar(searchBarController, 'Search'),
      body: Stack(
        children: <Widget>[
          buildListView(_itemSelected),
          DraggableCustomizedBtnNavyBar(
            navigatorBackground: Colors.blue,
            keyItemSelected: _itemSelected,
            items: <DraggableCustomizedDotBarItem>[
              DraggableCustomizedDotBarItem('Msg', icon: Icons.message_rounded, name: 'Messages', onTap: (itemSelected) {setState(() {
                _itemSelected = 'Msg';
              });}),
              DraggableCustomizedDotBarItem('Friends', icon: Icons.people_rounded, name: 'Friend List', onTap: (itemSelected) { setState(() {
                _itemSelected = 'Friends';
              }); }),
              DraggableCustomizedDotBarItem('Requests', icon: Icons.person_add_alt_1_rounded, name: 'Friend Requests', onTap: (itemSelected) { setState(() {
                _itemSelected = 'Requests';
              }); }),
            ], hiddenItems: const [],
          ),
        ],
      ),
    );
  }

  Widget buildListView (String itemSelected) {
    List<MessageModel> messages = [];
    List<FriendRequestModel> friendRequests = [];
    if (_itemSelected == "Msg"){
      messages = List.generate(
        50,
            (index) => MessageModel("Test Message","21:19"),
      );
      return Scaffold(
        body: ListView.separated(
          itemBuilder: (context, index) {
            var item = messages[index];
            return Card(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text(item.encryptedContent),
                subtitle: Text(item.sendingTime),
                onTap: () {
                },
                onLongPress: () {
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.blueGrey,
              thickness: 2,
              indent: 50,
              endIndent: 50,
            );
          },
          itemCount: messages.length,
        ),
      );
    }
   else{
      friendRequests = List.generate(
        50,
            (index) => FriendRequestModel("Wael","21:19"),
      );
      return Scaffold(
        body: ListView.separated(
          itemBuilder: (context, index) {
            var item = friendRequests[index];
            return Card(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text(item.from),
                subtitle: Text(item.date),
                onTap: () {
                },
                onLongPress: () {
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.blueGrey,
              thickness: 2,
              indent: 50,
              endIndent: 50,
            );
          },
          itemCount: friendRequests.length,
        ),
      );
    }
  }
  PreferredSizeWidget buildAppBar(TextEditingController controller, String hintText){
    return  SearchAppBar(
      controller: controller,
      callBack: (value)=> {
      },
      suffixIconColor: kPrimaryColor,
      textFieldHeight: 40,
      contentPadding: const EdgeInsets.all(8),
      leadingIconBtnColor: kPrimaryColor,
      prefixIconColor: kPrimaryColor,
      fillColor: Colors.white,
      hintText: hintText,
      prefixIcon: Icons.search,
      suffixIcon: Icons.search,
      inputBorder: const OutlineInputBorder(),
      hintTextStyle: const TextStyle(),
    );
  }
}


