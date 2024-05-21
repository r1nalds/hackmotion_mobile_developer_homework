import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackmotion_mobile_developer_homework/ui/swing_detail_page/view/components/swing_pageview.dart';
import 'package:hackmotion_mobile_developer_homework/ui/swing_list_page/bloc/events/swing_list_bloc_events.dart';
import 'package:hackmotion_mobile_developer_homework/ui/swing_list_page/bloc/state/swing_list_bloc_state.dart';
import 'package:hackmotion_mobile_developer_homework/ui/swing_list_page/bloc/swing_list_bloc.dart';

class SwingListView extends StatelessWidget {
  const SwingListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFefefef),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)),
        backgroundColor: const Color(0xFFefefef),
      ),
      body: Center(
        child: BlocBuilder<SwingListBloc, SwingListState>(
          builder: (context, state) {
            if (state is SwingListLoadInProgress) {
              return const CircularProgressIndicator();
            } else if(state is SwingListLoadFailure){
              return Text('Failed to load swings: ${state.error}');
            }else if (state is SwingListEmpty){
              return  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('No swings loaded.'),
                  TextButton(
                    onPressed: () => context.read<SwingListBloc>().add(FetchSwings()),
                    child: const Text('Reload Swings'),
                  )
                ],
              );
            }else if (state is SwingListLoadSuccess) {
              
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color:  Colors.white,
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              clipBehavior: Clip.antiAlias,
                              itemCount: state.swings.length,
                              itemBuilder: (context, index) {
                                final swing = state.swings[index];
                                return GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (contextDetailScreen) {
                                        return BlocProvider.value(
                                            value: context.read<SwingListBloc>(),
                                            child: SwingDetailsPageView(
                                              swings: state.swings,
                                              swingId: index,
                                            ));
                                      }));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Swing ${swing.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                          const Align(child: Icon(Icons.chevron_right, size:20, color: Color(0xFF5874ff)))  
                                        
                                      ],
                                      )));
                              },
                              separatorBuilder: (context, index) {
                                return Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                    height: 1,
                                    color: const Color(0xFFE7E7E7));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
              
            } else{
              return const Text('Unexpected State.');
            }
          },
        ),
      ),
    );
  }
}

class SwingListScreen extends StatelessWidget {
  const SwingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SwingListView();
  }
}
