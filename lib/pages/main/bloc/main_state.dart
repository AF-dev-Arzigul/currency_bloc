part of 'main_bloc.dart';

@immutable
class MainState {
  final Status status;
  final List<CurrencyModel> currencies;
  final String message;

  const MainState({
    this.status = Status.initial,
    this.currencies = const [],
    this.message = "",
  });

  MainState copyWith({
    Status? status,
    List<CurrencyModel>? currencies,
    String? message,
  }) {
    return MainState(
      status: status ?? this.status,
      currencies: currencies ?? this.currencies,
      message: message ?? this.message,
    );
  }
}

enum Status { initial, fail, loading, success }
