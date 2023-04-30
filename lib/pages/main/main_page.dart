import 'package:dars_currency/pages/main/widget/calculate_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/main_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MainBloc>();
    String _chooseLang = localLanguage(context);

    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () => print(context.locale),
          // ),
          appBar: AppBar(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))),
            title: Text("name".tr()),
            centerTitle: false,
            actions: [
              GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2015),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    bloc.add(MainGetDateEvent(date));
                  }
                },
                child: const Icon(Icons.calendar_month),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () async {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
                    // isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      // print("bottom sheet: ${_chooseLang}");
                      return Container(
                        padding: EdgeInsets.all(20),
                        height: 350,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text("language".tr(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                            Spacer(),
                            ListTile(
                              title: Text("O'zbekcha"),
                              leading: Radio(
                                  value: "O'zbekcha",
                                  groupValue: _chooseLang,
                                  onChanged: (value) {
                                    context.setLocale(const Locale("uz", "UZ"));
                                    _chooseLang = value!;
                                    // setState(() {});
                                  }),
                            ),
                            ListTile(
                              title: Text("Крилча"),
                              leading: Radio(
                                  autofocus: true,
                                  value: "Крилча",
                                  groupValue: _chooseLang,
                                  onChanged: (value) {
                                    context.setLocale(const Locale("uz", "UZC"));
                                    _chooseLang = value!;
                                    // setState(() {});
                                  }),
                            ),
                            ListTile(
                              title: Text("Русский"),
                              leading: Radio(
                                  value: "Русский",
                                  groupValue: _chooseLang,
                                  onChanged: (value) {
                                    context.setLocale(const Locale("ru", "RU"));
                                    _chooseLang = value!;
                                    // setState(() {});
                                  }),
                            ),
                            ListTile(
                              title: Text("English"),
                              leading: Radio(
                                  value: "English",
                                  groupValue: _chooseLang,
                                  onChanged: (value) {
                                    context.setLocale(const Locale("en", "EN"));
                                    _chooseLang = value!;
                                    // setState(() {});
                                  }),
                            ),
                            Spacer()
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.language_outlined),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (state.status == Status.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                // scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: state.currencies.length,
                itemBuilder: (_, i) {
                  final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
                  final model = state.currencies[i].tr(context.locale);
                  return Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      child: Theme(
                        data: theme,
                        child: ExpansionTile(
                          title: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: "${model.ccyNm}\t\t",
                                            style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 17),
                                            children: [
                                              TextSpan(
                                                  text: model.diff.startsWith("-") ? model.diff : " +${model.diff}",
                                                  style: TextStyle(
                                                      color: model.diff.startsWith("-") ? Colors.redAccent : Colors.greenAccent, fontSize: 14)),
                                            ])),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text("1 ${model.ccy} => ${model.rate} UZS | ", style: const TextStyle(fontSize: 14)),
                                    Image.asset("assets/images/calendar_icon.png", width: 15, height: 15),
                                    Text(" ${model.date}", style: const TextStyle(fontSize: 14))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          children: [
                            Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(bottom: 10, right: 15),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                      onPressed: () {
                                        CalculateDialog.showCalculateDialog(context, model: model);
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(Icons.calculate_rounded, size: 16),
                                          SizedBox(width: 8),
                                          Text("Hisoblash", style: TextStyle(fontSize: 12))
                                        ],
                                      )),
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  String localLanguage(BuildContext context) {
    String _lang = context.locale.toString();
    String langText = "";
    switch (_lang) {
      case 'uz_UZ':
        langText = "O'zbekcha";
        break;
      case 'uz_UZC':
        langText = "Крилча";
        break;
      case 'ru_RU':
        langText = "Русский";
        break;
      case 'en_EN':
        langText = "English";
        break;
    }
    return langText;
  }
}
