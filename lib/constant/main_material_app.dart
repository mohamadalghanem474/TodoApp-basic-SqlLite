import 'package:flutter/material.dart';
import 'package:todo/shared/cubit/cubit.dart';

class KMainEelevatedButtom extends StatelessWidget {
  final String? textchild;
  final Function function;
  final double borderradius;
  final Color? textcolor;
  final double? fontsize;
  final double? width;
  final double? height;
  final Color? backgroundcolor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  const KMainEelevatedButtom(
      {super.key,
      required this.function,
      this.textchild,
      required this.borderradius,
      this.textcolor,
      this.backgroundcolor,
      this.margin,
      this.padding,
      this.fontsize,
      this.height,
      this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: function(),
          style: ElevatedButton.styleFrom(
              backgroundColor: backgroundcolor,
              padding: padding,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderradius))),
          child: Text(
            '$textchild',
            style: TextStyle(color: textcolor, fontSize: fontsize),
          )),
    );
  }
}

//====================================================================

class KMainTextFormFeld extends StatelessWidget {
  final Function functionontap;
  final TextEditingController? controller;
  final bool? filled;
  final Color? fillcolor;
  final double? hintfontSize;
  final FontWeight? hintfontweidth;
  final Color? hintcolor;
  final String? hintText;
  final Widget? label;
  final TextStyle? labelStyle;
  final String? Function(String? val)? validator;

  final TextInputType? keyboardType;

  final BorderRadius borderradiusoutlineinputeborder;
  final BorderRadius borderradiusoutlineenabledborder;
  final BorderRadius borderradiusoutlinefocusedborder;
  final BorderRadius borderradiusoutlineerrorborder;

  final Color coloroutlineinputborder;
  final Color coloroutlinefocusedborder;
  final Color coloroutlineerrorborder;
  final Color coloroutlineenableborder;
  final double widthoutlineinputborder;
  final double widthoutlinefocusedborder;
  final double widthoutlineerrorborder;
  final double widthoutlineenableborder;

  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const KMainTextFormFeld({
    super.key,
    this.fillcolor,
    this.filled,
    this.hintcolor,
    this.hintfontSize,
    this.hintfontweidth,
    required this.functionontap,
    this.controller,
    required this.coloroutlineinputborder,
    required this.coloroutlinefocusedborder,
    required this.coloroutlineerrorborder,
    required this.coloroutlineenableborder,
    required this.widthoutlineinputborder,
    required this.widthoutlinefocusedborder,
    required this.widthoutlineerrorborder,
    required this.widthoutlineenableborder,
    required this.borderradiusoutlineinputeborder,
    required this.borderradiusoutlineenabledborder,
    required this.borderradiusoutlinefocusedborder,
    required this.borderradiusoutlineerrorborder,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      onTap: () {
        functionontap();
      },
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,

        prefixIcon: prefixIcon,
        // contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        label: label,
        labelStyle: labelStyle,
        hintText: hintText,
        fillColor: fillcolor,
        filled: filled,
        errorStyle: const TextStyle(height: 0, color: Colors.transparent),
        hintStyle: TextStyle(
          fontSize: hintfontSize,
          color: hintcolor,
          fontWeight: hintfontweidth,
        ),
        // ignore: prefer_const_constructors
        border: OutlineInputBorder(
            borderRadius: borderradiusoutlineinputeborder,
            borderSide: BorderSide(
                color: coloroutlineinputborder,
                width: widthoutlineinputborder)),
        enabledBorder: OutlineInputBorder(
            borderRadius: borderradiusoutlineenabledborder,
            borderSide: BorderSide(
                color: coloroutlineenableborder,
                width: widthoutlineenableborder)),
        focusedBorder: OutlineInputBorder(
            borderRadius: borderradiusoutlinefocusedborder,
            borderSide: BorderSide(
                color: coloroutlinefocusedborder,
                width: widthoutlinefocusedborder)),
        errorBorder: OutlineInputBorder(
          borderRadius: borderradiusoutlineerrorborder,
          borderSide: BorderSide(
              color: coloroutlineerrorborder, width: widthoutlineerrorborder),
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF3C3C43),
      ),
    );
  }
}

//=================================================
//widget buildTasksItem

Widget buildTasksItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              child: Text('${model['time']}'),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['id']);
                },
                icon: const Icon(Icons.check_box)),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'archived', id: model['id']);
                },
                icon: const Icon(Icons.archive))
          ],
        ),
      ),
    );
