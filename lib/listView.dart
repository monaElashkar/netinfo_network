import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/networkcubit.dart';
import 'cubit/networkstates.dart';

class listView extends StatefulWidget {
  const listView({Key? key}) : super(key: key);

  @override
  State<listView> createState() => _listViewState();
}

class _listViewState extends State<listView> {
  bool first=true;
  @override
  void initState() {
    context.read<NetworkCubit>().checkConnectivity();
    context.read<NetworkCubit>().checkConnectivityname;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NetworkCubit>();
    return BlocConsumer<NetworkCubit,NetworkState>(
        listener: (context,state){
          if(state is NotConnectedState){
            first=false;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content:Text(state.message),
                  backgroundColor: Colors.red,
                )
            );
            //cubit.first=false;
          }
          if(state is ConnectedState  &&first==false){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content:Text(state.message),
                  backgroundColor: Colors.green,
                )
            );
          }
        },
        builder:(context,state){
          if(cubit.checkConnectivityname=="connected" ||state is ConnectedState){
            if (cubit.loading==true) {
              return const Center(child: CircularProgressIndicator(color: Colors.orange,),);
            }
            else
            {
              return  ListView.separated(
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                      child: InkWell(
                        child: Row(
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.height*0.17,
                                width: MediaQuery.of(context).size.width*0.3,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: FadeInImage.assetNetwork(
                                  placeholder:"assets/images/placeholper_image.jpg",
                                  fit: BoxFit.cover,
                                  image: "${cubit.listViewdata[index]["urlToImage"]}",
                                  imageErrorBuilder: (a,b,c){
                                    return Image.asset("assets/images/placeholper_image.jpg");
                                  },
                                )
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${cubit.listViewdata[index]["title"]}",overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),maxLines: 3,),
                                  Text("${cubit.listViewdata[index]["publishedAt"]}",
                                    style: const TextStyle(fontSize: 15,color: Colors.grey),)
                                ],),
                            )
                          ],
                        ),
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder:
                          //     (context)=>
                          // ));
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index){
                    return const Divider(color:Colors.black38
                    );
                  }, itemCount:cubit.listViewdata.length);
            }
          }else{
            return _buildTextWidget("not connected");

          }


        } ,
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
