//States
import 'package:equatable/equatable.dart';
import 'package:hackmotion_mobile_developer_homework/models/swing.dart';

abstract class SwingListState extends Equatable {
  const SwingListState();

  @override
  List<Object> get props => [];
}

class SwingListInitial extends SwingListState{}

class SwingListLoadInProgress extends SwingListState{}

class SwingListLoadSuccess extends SwingListState{
  final List<CapturedSwing> swings;
  const SwingListLoadSuccess(this.swings);

  @override
  List<Object> get props => [swings];
}

class SwingListLoadFailure extends SwingListState{
  final String error;

  const SwingListLoadFailure(this.error);

  @override
  List<Object> get props => [error];

}

class SwingListEmpty extends SwingListState{}