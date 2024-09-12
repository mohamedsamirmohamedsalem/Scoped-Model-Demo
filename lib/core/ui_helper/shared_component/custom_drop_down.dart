import 'package:scoped_model_demo/core/logic_helper/import_all.dart';

class CustomDropdown extends StatelessWidget {
  final String? labelText;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final List<DropdownMenuItem<String>> items;
  final Color backgroundColor;
  final bool showBorder;
  final Color borderColor;

  const CustomDropdown({
    super.key,
    this.labelText,
    this.value,
    this.onChanged,
    required this.items,
    this.backgroundColor = const Color(0xFFF2F4F7),
    this.showBorder = false,
    this.borderColor = AppColors.borderGrayColor, // Default border color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: showBorder
            ? Border.all(color: borderColor, width: 0.5)
            : null, // Optional border
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        icon: const Icon(Icons.keyboard_arrow_down),
        decoration: InputDecoration(
          hintText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: borderColor), // Consistent border color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: borderColor), // Consistent border color when enabled
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: borderColor), // Consistent border color when focused
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 12), // Adjust this value
        ),
        value: value,
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}
