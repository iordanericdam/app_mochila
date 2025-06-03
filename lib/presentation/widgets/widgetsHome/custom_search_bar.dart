import 'package:flutter/material.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/styles/constants.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;
  final Function(String) onFilterChanged;

  const CustomSearchBar({
    super.key,
    required this.onSearchChanged,
    required this.onFilterChanged,
  });

  @override
  State<CustomSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<CustomSearchBar> {
  String selectedFilter = 'Todos';
  final List<String> filterOptions = ['Todos','Planificados','Completados'];
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backGroundInputColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [insideDefaultBoxShadow()],
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            const Icon(Icons.search, color: AppColors.iconColor),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: widget.onSearchChanged,
                style: AppTextStyle.normal,
                decoration: const InputDecoration(
                  hintText: 'Buscar...',
                  hintStyle: AppTextStyle.normalGrey,
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                color: AppColors.defaultButtonColor,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedFilter,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  dropdownColor: AppColors.defaultButtonColor,
                  borderRadius: BorderRadius.circular(16), 
                  items: filterOptions.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: AppTextStyle.normalBoldWhite),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      FocusScope.of(context).unfocus();
                      setState(() => selectedFilter = newValue);
                      widget.onFilterChanged(newValue);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}