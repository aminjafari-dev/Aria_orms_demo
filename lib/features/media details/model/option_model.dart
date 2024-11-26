import 'package:equatable/equatable.dart';

class OptionModel extends Equatable {
  final int? id;
  final String? title;

  const OptionModel({
    this.id,
    this.title,
  });

  @override
  List<Object?> get props => [
        id,
        title,
      ];
}
