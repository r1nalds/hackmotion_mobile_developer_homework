//Events
import 'package:equatable/equatable.dart';
import 'package:hackmotion_mobile_developer_homework/models/swing.dart';

abstract class SwingListEvent extends Equatable{
  const SwingListEvent();

  @override
  List<Object> get props => [];
}

class FetchSwings extends SwingListEvent{}

class DeleteSwing extends SwingListEvent{
  final CapturedSwing swing;
  const DeleteSwing(this.swing);

  @override
  List<Object> get props => [swing];
}
