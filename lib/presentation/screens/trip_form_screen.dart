import 'package:app_mochila/presentation/widgets/buttons.dart';
import 'package:app_mochila/presentation/widgets/widgetTrips/category_selector.dart';
import 'package:app_mochila/presentation/widgets/widgetTrips/custom_input_description.dart';
import 'package:app_mochila/presentation/widgets/widgetTrips/custom_input_trip_tittle.dart';
//import 'package:app_mochila/presentation/widgets/custom_toggle.dart';
import 'package:app_mochila/presentation/widgets/widgetTrips/switch_with_title.dart';
import 'package:app_mochila/presentation/widgets/widgetTrips/date_selector.dart';
import 'package:app_mochila/presentation/widgets/widgetTrips/weather_selector.dart';
import 'package:app_mochila/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';

class TripFormScreen extends StatefulWidget {
  const TripFormScreen({super.key});

  @override
  State<TripFormScreen> createState() => _SetupBpTripScreenState();
}

class _SetupBpTripScreenState extends State<TripFormScreen> {
  final _keyTripForm = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  //String? selectedCategory;
  List<String> _selectedCategories = [];
  bool _visibilityOn = false;
  bool _suggestionsOn = true;
  String? _selectedWeather;

  Future<void> _submitTripForm() async{
    if(!_keyTripForm.currentState!.validate()) return;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: WhiteBaseContainer(
        child: SingleChildScrollView(
          padding: kmedium,
          child: Form(
              key: _keyTripForm,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomElevatedButton(
                            text: "Siguiente",
                            backgroundColor: AppColors.defaultButtonColor,
                            onPressed: () {}),
                      ],
                    ),
                    const Padding(
                      padding: kleftPadding,
                      child: Text(
                        "Título del viaje",
                        style: AppTextStyle.title,
                      ),
                    ),
                    kHalfSizedBox,

                    CustomInputTripTitle(
                      hintText: "Introduce un título...",
                      controller: _titleController,
                      keyboardType: TextInputType.text,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Por favor, introduce un título';
                      //   }
                      //   return null;
                      // },
                    ),
                    sizedBox,
                    kHalfSizedBox,
                    DateSelector(onDatesChanged: (start, end) {
                      setState(() {
                        startDate = start;
                        endDate = end;
                      });
                    }),
                    sizedBox,
                    //TOOGLE
                    Padding(
                      padding: kleftPadding,
                      child: Column(
                        children: [
                          SwitchWithTitle(
                            titulo: "Visibilidad",
                            activeText: "Pública",
                            inactiveText: "Privada",
                            isActive: _visibilityOn,
                            onChanged: (value) {
                              setState(() {
                                _visibilityOn = value;
                              });
                            },
                          ),
                          const SizedBox(height: 12),
                          SwitchWithTitle(
                            titulo: "Sugerencias",
                            activeText: "Activadas",
                            inactiveText: "Desactivadas",
                            isActive: _suggestionsOn,
                            onChanged: (value) {
                              setState(() {
                                _suggestionsOn = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    sizedBox,
                    const Padding(
                      padding: kleftPadding,
                      child: Text(
                        "Descripción",
                        style: AppTextStyle.title,
                      ),
                    ),
                    kHalfSizedBox,
                    CustomInputDescription(
                      hintText: "Añade una descripción...",
                      controller: _descriptionController,
                      maxLines: 2,
                    ),
                    sizedBox,
                    // const Padding(
                    //   padding: kleftPadding,
                    //   child: Text(
                    //     "¿Qué quieres hacer?",
                    //     style: AppTextStyle.title,
                    //   ),
                    // ),
                    // sizedBox,
                    const Padding(
                      padding: kleftPadding,
                      child: Text(
                        "¿Temperatura?",
                        style: AppTextStyle.title,
                      ),
                    ),
                    //  Center(
                     
                    //   child: Text(
                    //     "Selecciona el clima",
                    //     style: AppTextStyle.normalGreyTitle,
                    //   ),
                    // ),
                    kHalfSizedBox,
                    Center(child: WeatherSelector(
                      onWeatherChanged: (selectedWeather) {
                        setState(() {
                          _selectedWeather = selectedWeather;
                        });
                      },
                    )),
                    sizedBox,
                    sizedBox,
                     const Padding(
                      padding: kleftPadding,
                      child: Text(
                        "Categoria",
                        style: AppTextStyle.title,
                      ),
                    ),
                    kHalfSizedBox,
                    CategorySelector(
                      onCategoriesChanged: (categories) {
                        setState(() {
                          _selectedCategories = categories;
                        });
                      },
                    ),
                  ])),
        ),
      ),
    );
  }
}
