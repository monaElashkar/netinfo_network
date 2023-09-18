import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netinfo_network/listView.dart';

import 'cubit/networkcubit.dart';
import 'list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context)=>NetworkCubit()..checkConnection())) ,
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(body: listView(),)// list(),
      ),
    );
  }
}


