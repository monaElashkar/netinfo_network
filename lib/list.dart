import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netinfo_network/cubit/networkcubit.dart';
import 'package:netinfo_network/cubit/networkstates.dart';
import 'package:netinfo_network/listView.dart';

class list extends StatefulWidget {
  const list({Key? key}) : super(key: key);

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NetworkCubit>();
    return Scaffold(
      body: BlocConsumer<NetworkCubit,NetworkState>(
        listener: (context,state){
         if(state is NotConnectedState){
           ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content:Text(state.message),
                 backgroundColor: Colors.red,
               )
           );
           //cubit.first=false;
         }
         if(state is ConnectedState){
           ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content:Text(state.message),
                 backgroundColor: Colors.green,
               )
           );
         }
        },
        builder: (context,state) {
          if (state is ConnectedState) {
              return const listView();
          } else if (state is NotConnectedState) {
            return _buildTextWidget(state.message);
          }
          return const SizedBox();
        }
      ),
    );
  }
  Widget _buildTextWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/wifi-connected-no-internet.jpg"),
          Text(
            message,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

}
