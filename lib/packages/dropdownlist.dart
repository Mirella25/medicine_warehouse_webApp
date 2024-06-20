import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String prefixText;
  final String labelText;
  final bool isItemSelected;
  final List<SelectedListItem>? dataList;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  const AppTextField({
    required this.textEditingController,
    required this.isItemSelected,
    this.dataList,
    Key? key,
    this.prefixIcon,
    required this.prefixText,
    required this.labelText,
    this.validator,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle: const Text(
          " Categories",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.dataList ?? [],
        selectedItems: (List<dynamic> selectedList) {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
              widget.textEditingController.text = item.name;
            }
          }
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          validator: widget.validator,
          readOnly: true,
          controller: widget.textEditingController,
          cursorColor: Colors.black,
          onTap: widget.isItemSelected
              ? () {
                  FocusScope.of(context).unfocus();
                  onTextFieldTap();
                }
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            labelText: widget.labelText,
            prefixText: widget.prefixText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: widget.prefixIcon,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
            ),
          ),
        ),
      ],
    );
  }
}
