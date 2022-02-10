import 'package:flutter/material.dart';

import 'constants.dart';
import 'drop_down_list.dart';

void main() {
  runApp(
    const MaterialApp(
      title: kTitle,
      home: DropDownListExample(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class DropDownListExample extends StatefulWidget {
  const DropDownListExample({
    Key? key,
  }) : super(key: key);

  @override
  _DropDownListExampleState createState() => _DropDownListExampleState();
}

class _DropDownListExampleState extends State<DropDownListExample> {
  /// Это список городов, которые перейдут в раскрывающийся список.
  final List<SelectedListItem> _listOfCities = [
    SelectedListItem(false, kTokyo),
    SelectedListItem(false, kNewYork),
    SelectedListItem(false, kLondon),
    SelectedListItem(false, kParis),
    SelectedListItem(false, kMadrid),
    SelectedListItem(false, kDubai),
    SelectedListItem(false, kRome),
    SelectedListItem(false, kBarcelona),
    SelectedListItem(false, kCologne),
    SelectedListItem(false, kMonteCarlo),
    SelectedListItem(false, kPuebla),
    SelectedListItem(false, kFlorence),
  ];

  /// Регистристрация контроллеров текстовых полей.
  final TextEditingController _fullNameTextEditingController =
  TextEditingController();
  final TextEditingController _emailTextEditingController =
  TextEditingController();
  final TextEditingController _phoneNumberTextEditingController =
  TextEditingController();
  final TextEditingController _cityTextEditingController =
  TextEditingController();
  final TextEditingController _passwordTextEditingController =
  TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _fullNameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _phoneNumberTextEditingController.dispose();
    _cityTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: _mainBody(),
      ),
    );
  }

  /// Это Main (основной) виджет.
  Widget _mainBody() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            kRegister,
            style: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          AppTextField(
            textEditingController: _fullNameTextEditingController,
            title: kFullName,
            hint: kEnterYourName,
            isCitySelected: false,
          ),
          AppTextField(
            textEditingController: _emailTextEditingController,
            title: kEmail,
            hint: kEnterYourEmail,
            isCitySelected: false,
          ),
          AppTextField(
            textEditingController: _phoneNumberTextEditingController,
            title: kPhoneNumber,
            hint: kEnterYourPhoneNumber,
            isCitySelected: false,
          ),
          AppTextField(
            textEditingController: _cityTextEditingController,
            title: kCity,
            hint: kChooseYourCity,
            isCitySelected: true,
            cities: _listOfCities,
          ),
          AppTextField(
            textEditingController: _passwordTextEditingController,
            title: kPassword,
            hint: kAddYourPassword,
            isCitySelected: false,
          ),
          const SizedBox(
            height: 15.0,
          ),
          _AppElevatedButton(),
        ],
      ),
    );
  }
}

/// Класс текстового поля Common App.
class AppTextField extends StatefulWidget {
  TextEditingController textEditingController = TextEditingController();
  final String title;
  final String hint;
  final bool isCitySelected;
  final List<SelectedListItem>? cities;
  AppTextField({
    required this.textEditingController,
    required this.title,
    required this.hint,
    required this.isCitySelected,
    this.cities,
    Key? key,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final TextEditingController _searchTextEditingController =
  TextEditingController();

  /// Это метод изменения текста, который будет отображаться в текстовом
  /// поле города при изменении.
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        submitButtonText: kDone,
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText: kSearch,
        bottomSheetTitle: kCities,
        searchBackgroundColor: Colors.black12,
        dataList: widget.cities ?? [],
        selectedItems: (List<dynamic> selectedList) {
          showSnackBar(selectedList.toString());
        },
        selectedItem: (String selected) {
          showSnackBar(selected);
          widget.textEditingController.text = selected;
        },
        enableMultipleSelection: false,
        searchController: _searchTextEditingController,
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(
          height: 5.0,
        ),
        TextFormField(
          controller: widget.textEditingController,
          cursorColor: Colors.black,
          onTap: widget.isCitySelected
              ? () {
            FocusScope.of(context).unfocus();
            onTextFieldTap();
          }
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            contentPadding:
            const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
            hintText: widget.hint,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}

/// This is common class for 'REGISTER' elevated button.
/// Это общий класс для кнопки «РЕГИСТРАЦИЯ»
class _AppElevatedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text(
          kREGISTER,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
        style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(70, 76, 222, 1),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
