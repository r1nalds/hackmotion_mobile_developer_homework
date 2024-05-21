import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackmotion_mobile_developer_homework/ui/swing_list_page/bloc/events/swing_list_bloc_events.dart';
import 'package:hackmotion_mobile_developer_homework/ui/swing_list_page/bloc/swing_list_bloc.dart';
import 'package:hackmotion_mobile_developer_homework/ui/swing_list_page/view/swing_list_view.dart';

class SwingPage extends StatelessWidget {
  const SwingPage({super.key});

  //Blocprovider for swinglistscreen and swingdetailview
  @override
  Widget build(BuildContext context){
    return BlocProvider(
      create: (_) => SwingListBloc()..add(FetchSwings()),
      child: const SwingListScreen(),
    );
    
}
}

