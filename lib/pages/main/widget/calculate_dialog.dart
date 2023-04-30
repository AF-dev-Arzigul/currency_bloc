import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

import '../../../core/models/currency_model.dart';

class CalculateDialog extends StatefulWidget {
  final CurrencyModel model;

  const CalculateDialog._(this.model, {Key? key}) : super(key: key);

  static Future<void> showCalculateDialog(
    BuildContext context, {
    required CurrencyModel model,
  }) async {
    await showModalBottomSheet(
      context: context,
      // backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CalculateDialog._(model),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
    );
  }

  @override
  State<CalculateDialog> createState() => _CalculateDialogState();
}

class _CalculateDialogState extends State<CalculateDialog> {
  late final rate = double.parse(widget.model.rate);
  final firstEditTextController = TextEditingController(text: "1");
  late final secondEditTextController = TextEditingController(text: "${MoneyFormatter(amount: second).output.nonSymbol} so'm",);
  bool isUz = false;
  double first = 1;
  late double second = rate;

  @override
  void initState() {
    firstEditTextController.addListener(() {
      if (firstEditTextController.text.isNotEmpty) {
        if (isUz) {
          first = double.parse(
            firstEditTextController.text.replaceAll(",", "").replaceAll(" so'm", ""),
          );
          second = first / rate;
          secondEditTextController.text =
              MoneyFormatter(amount: second).output.nonSymbol;
        } else {
          first = double.parse(
            firstEditTextController.text.replaceAll(",", "").replaceAll(" so'm", ""),
          );
          second = first * rate;
          secondEditTextController.text =
              "${MoneyFormatter(amount: second).output.nonSymbol} so'm";
        }
      } else {
        first = 0;
        second = 0;
        secondEditTextController.text = isUz ? "0" : "0 so'm";
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 230,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: firstEditTextController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: const OutlineInputBorder(),
                label: Text(isUz ? "UZS" : widget.model.ccy),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: secondEditTextController,
              readOnly: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: const OutlineInputBorder(),
                label: Text(isUz ? widget.model.ccy : "UZS"),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                        isUz = !isUz;
                      setState(() {
                        if (isUz) {
                          firstEditTextController.text = widget.model.rate;
                          secondEditTextController.text = "1";
                        } else {
                          firstEditTextController.text = "1";
                          secondEditTextController.text = widget.model.rate;
                        }
                      });
                      print("changed $isUz");
                    },
                    child: Icon(CupertinoIcons.arrow_up_arrow_down, color: Colors.white)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
