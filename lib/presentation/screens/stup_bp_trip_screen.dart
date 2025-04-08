import 'package:app_mochila/presentation/widgets/custom_input.dart';
import 'package:app_mochila/presentation/widgets/custom_input_trip_tittle.dart';
import 'package:app_mochila/presentation/widgets/date_selector.dart';
import 'package:app_mochila/presentation/widgets/date_slector.dart';
import 'package:flutter/material.dart';
import 'package:app_mochila/styles/base_scaffold.dart';
import 'package:app_mochila/styles/constants.dart';
import 'package:app_mochila/styles/app_text_style.dart';
import 'package:app_mochila/presentation/widgets/white_base_container.dart';

class SetupBpTripScreen extends StatefulWidget {
  const SetupBpTripScreen({super.key});

  @override
  State<SetupBpTripScreen> createState() => _SetupBpTripScreenState();
}

class _SetupBpTripScreenState extends State<SetupBpTripScreen> {
  final _setupBpTripKeyForm = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  DateTime? fechaInicio;
  DateTime? fechaFin;



@override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: WhiteBaseContainer(
        child: SingleChildScrollView(
          padding: kmedium,
          child: Form(
            key: _setupBpTripKeyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                sizedBox,
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
                  controller: _tituloController,
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
                const DateSelector(), 
                sizedBox,
              ]
            )
          ),
        ),
      ),
      
        
      
    );
    }
  }
