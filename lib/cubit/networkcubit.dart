import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'networkstates.dart';

class NetworkCubit extends Cubit<NetworkState>{
  StreamSubscription? _subscription;
  NetworkCubit():super(NetworkInitial());
  void connected() {
    emit(ConnectedState(message: "Connected"));
  }

  void notConnected() {
    emit(NotConnectedState(message: "Not Connected"));
  }
  String? checkConnectivityname;
  void checkConnectivity()async {
    var result =await Connectivity().checkConnectivity();
    if(result.name=="none"){
      notConnected();
      print(result.name);
      checkConnectivityname= "not connected";
      print(checkConnectivityname);
    }else{
        getlist();
      emit(firstConnectedState(message: "connected"));
      print(result.name);
      checkConnectivityname="connected";
      print(checkConnectivityname);
    }

  }
  void checkConnection() {
    print("start");
    _subscription= Connectivity().onConnectivityChanged.
    listen((ConnectivityResult result)
    {
     if(result==ConnectivityResult.wifi||
         result==ConnectivityResult.mobile){
         print("connect");
           getlist();
           connected();
     }else if(result==ConnectivityResult.none){
         notConnected() ;
         print("not connect");
     }
    });
  }
  bool loading = true;
  List listViewdata=[];
  getlist() async {
    print("startgetlist");
    loading = true;
    listViewdata = [];
    emit(StartLoading_For_getlist_state());
    http.Response res = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=eg&category=science&apiKey=bcab4ccbe2314cb48eef06d945ee8a31"));
    if (res.statusCode == 200) {
      listViewdata = jsonDecode(res.body)["articles"];
      print(listViewdata);
      print(listViewdata.length);
      emit(GetDataListFromApi());
    }else{
      print(json.decode(res.body));
      print('no data');
    }

    loading = false;
    emit(EndLoading_For_getlist_state());
  }


  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }

}