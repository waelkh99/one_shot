import "package:flutter/material.dart";
import "package:provider/provider.dart";

typedef OnChange = void Function(String value);

class BoolModel extends ChangeNotifier {
  static final BoolModel _boolModel = BoolModel._internal();

  factory BoolModel() {
    return _boolModel;
  }
  BoolModel._internal();

  bool isPressed = false;
  bool isChange = false;
  bool isSecure = false;

  void isChangeSecure() {
    isSecure = !isSecure;
    notifyListeners();
  }

  void isChangeTry() {
    isChange = !isChange;
    notifyListeners();
  }

  void changeLeading() {
    isPressed = !isPressed;
    notifyListeners();
  }
}

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({
    Key? key,
    this.suffixIconColor = Colors.red,
    this.prefixIconColor = Colors.grey,
    this.leadingIconBtnColor = Colors.green,
    this.fillColor = Colors.purple,
    this.hintTextStyle = const TextStyle(
      fontSize: 17,
      color: Colors.white,
    ),
    this.hintText = 'Search',
    this.inputBorder = InputBorder.none,
    this.textFieldHeight = 36,
    this.suffixIcon = Icons.close,
    this.prefixIcon = Icons.search,
    this.contentPadding = const EdgeInsets.all(0),
    required this.controller,
    required this.callBack,
  }) : super(key: key);

  final OnChange callBack;
  final TextEditingController controller;
  final EdgeInsets contentPadding;

  final IconData suffixIcon;
  final IconData prefixIcon;

  final double textFieldHeight;
  final InputBorder inputBorder;

  final TextStyle hintTextStyle;
  final String hintText;

  final Color suffixIconColor;
  final Color prefixIconColor;
  final Color leadingIconBtnColor;
  final Color fillColor;

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BoolModel>(
      create: (context) => BoolModel(),
      builder: (context, child) {
        return AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 12,
          leading: Provider.of<BoolModel>(context, listen: false).isPressed
              ? IconButton(
            onPressed: () {
              Provider.of<BoolModel>(context, listen: false)
                  .changeLeading();
              FocusManager.instance.primaryFocus?.unfocus();
              Provider.of<BoolModel>(context, listen: false)
                  .isChangeSecure();
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: leadingIconBtnColor,
            ),
          )
              : null,
          title: SizedBox(
            height: textFieldHeight > 56 ? 56 : textFieldHeight,
            child: TextField(
              controller: controller,
              obscureText:
              Provider.of<BoolModel>(context, listen: true).isSecure,
              obscuringCharacter: ' ',
              onTap: () {
                if (!Provider.of<BoolModel>(context, listen: false).isPressed) {
                  Provider.of<BoolModel>(context, listen: false)
                      .changeLeading();
                }
                if (Provider.of<BoolModel>(context, listen: false).isSecure) {
                  Provider.of<BoolModel>(context, listen: false)
                      .isChangeSecure();
                }
              },
              onChanged: controller.text.isEmpty
                  ? (value) {
                Provider.of<BoolModel>(context, listen: false)
                    .isChangeTry();
              }
                  : callBack,
              decoration: InputDecoration(
                contentPadding: contentPadding,
                filled: true,
                fillColor: fillColor,
                border: inputBorder,
                hintText: hintText,
                hintStyle: hintTextStyle,
                prefixIcon: Icon(prefixIcon, color: prefixIconColor),
                suffixIcon:
                Provider.of<BoolModel>(context, listen: false).isPressed
                    ? InkWell(
                  onTap: () {
                    controller.text = '';
                    if (Provider.of<BoolModel>(context, listen: false)
                        .isChange) {
                      Provider.of<BoolModel>(context, listen: false)
                          .isChangeTry();
                    }
                  },
                  child: Icon(
                    suffixIcon,
                    color: suffixIconColor,
                  ),
                )
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

class DefaultBody extends StatelessWidget {
  DefaultBody({
    Key? key,
    required this.defaultBody,
    this.defaultSearchBody,
    this.normalSearchBody,
  }) : super(key: key);

  Widget? defaultSearchBody;
  Widget? normalSearchBody;
  final Widget defaultBody;

  void _nullCheck() {
    if (defaultSearchBody == null) {
      if (normalSearchBody == null) {
        defaultSearchBody = defaultBody;
      } else {
        defaultSearchBody = normalSearchBody;
      }
    }
    normalSearchBody ?? defaultSearchBody;
  }

  @override
  Widget build(BuildContext context) {
    _nullCheck();
    return ChangeNotifierProvider<BoolModel>(
      create: (context) => BoolModel(),
      builder: (context, child) {
        return (Provider.of<BoolModel>(context, listen: true).isPressed
            ? (Provider.of<BoolModel>(context, listen: false).isChange
            ? normalSearchBody
            : defaultSearchBody)
            : defaultBody) ??
            defaultBody;
      },
    );
  }
}