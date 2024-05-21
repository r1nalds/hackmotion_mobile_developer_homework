import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:hackmotion_mobile_developer_homework/models/swing.dart';
import 'package:hackmotion_mobile_developer_homework/ui/swing_list_page/bloc/events/swing_list_bloc_events.dart';
import 'package:hackmotion_mobile_developer_homework/ui/swing_list_page/bloc/state/swing_list_bloc_state.dart';

class SwingListBloc extends Bloc<SwingListEvent, SwingListState> {
  SwingListBloc() : super(SwingListInitial()) {
    on<FetchSwings>(_onFetchSwings);
    on<DeleteSwing>(_onDeleteSwing);
  }
  Future<void> _onFetchSwings(
      FetchSwings event, Emitter<SwingListState> emit) async {
    emit(SwingListLoadInProgress());
    try {
      List<String> fileNames = [
        '1.json',
        '2.json',
        '3.json',
        '4.json',
        '5.json'
      ];
      List<CapturedSwing> loadedSwings = [];

      for (String fileName in fileNames) {
        String jsonString =
            await rootBundle.loadString('assets/captures/$fileName');
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        String name = fileName.substring(0, fileName.length - 5);
        CapturedSwing capturedSwing = CapturedSwing.fromJson(name, jsonMap);
        loadedSwings.add(capturedSwing);
      }
      emit(SwingListLoadSuccess(loadedSwings));
    } catch (error) {
      emit(SwingListLoadFailure(error.toString()));
    }
  }

  void _onDeleteSwing(DeleteSwing event, Emitter<SwingListState> emit) {
    if (state is SwingListLoadSuccess) {
      final updatedSwings =
          List<CapturedSwing>.from((state as SwingListLoadSuccess).swings)
            ..remove(event.swing);
      if (updatedSwings.isEmpty) {
        emit(SwingListEmpty());
      } else {
        emit(SwingListLoadSuccess(updatedSwings));
      }
    }
  }
}
