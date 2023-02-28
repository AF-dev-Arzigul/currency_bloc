import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/main_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MainBloc>();
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.setLocale(const Locale("ru", "RU")),
          ),
          appBar: AppBar(
            title: Text("name".tr()),
            centerTitle: false,
            actions: [
              GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    bloc.add(MainGetDateEvent(date));
                  }
                },
                child: const Icon(Icons.calendar_month),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (state.status == Status.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.separated(
                itemCount: state.currencies.length,
                separatorBuilder: (_, i) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  final model = state.currencies[i].tr(context.locale);
                  return Text(
                    "${model.ccyNm}=${model.rate}",
                    style: const TextStyle(fontSize: 32),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
