import 'package:equatable/equatable.dart';

class ChartDataModel extends Equatable {
  const ChartDataModel(this.x, this.y);
  
  final int x; // Change x to DateTime
  final double y; // Change y to double
  
  @override
  List<Object?> get props => [x, y];
}
