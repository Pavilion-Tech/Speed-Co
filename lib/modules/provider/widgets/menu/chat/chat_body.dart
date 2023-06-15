import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:speed_co/modules/item_shared/image_net.dart';
import 'package:speed_co/modules/item_shared/image_zoom.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_cubit.dart';
import 'package:speed_co/shared/components/components.dart';
import '../../../../../models/chat_model.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../user/widgets/menu/chat/record_item.dart';

enum Type{text,image,record}

class PChatBody extends StatelessWidget {
  const PChatBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var messages = ProviderMenuCubit.get(context).chatModel!.data!.messages!;
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (c,i)=>ChatItem(
            type: messages[i].messageType == 1 ?Type.text:messages[i].messageType == 2?Type.image:Type.record,
            content: messages[i].message??'',
            createdAt:  messages[i].createdAt??'',
            isUser: messages[i].sender == 'user'?true:false,
          ),
          separatorBuilder: (c,i)=>const SizedBox(height: 15,),
          itemCount: messages.length
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  ChatItem({
    required this.isUser,
    required this.type,
    required this.content,
    required this.createdAt,
  });


  bool isUser;
  Type type;
  String content;
  String createdAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          end: isUser?0:30,start: isUser?30:0
      ),
      child: Column(
        crossAxisAlignment: isUser?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(
            createdAt,
            style: TextStyle(
                color: defaultColorFour,fontSize: 11
            ),
          ),
          Builder(builder: (BuildContext context) {
            switch(type){
              case Type.text:
                return
                  Container(
                      decoration: BoxDecoration(
                        color: isUser?defaultColor:HexColor('#EEEEEE'),
                        borderRadius: BorderRadiusDirectional.only(
                          topStart:Radius.circular(isUser?20:0),
                          topEnd: Radius.circular(isUser?0:20),
                          bottomEnd: const Radius.circular(20),
                          bottomStart:const  Radius.circular(20),
                        ),
                      ),
                      padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                      child:Text(
                        content,
                        textAlign: isUser?TextAlign.end:TextAlign.start,
                        style: TextStyle(
                            color: isUser?Colors.white:null,fontSize: 11
                        ),
                      )
                  );
              case Type.image:
                return InkWell(
                  onTap: ()=>navigateTo(context, ImageZoom(content)),
                  child: Container(
                      height: 129,width: size!.width*.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart:Radius.circular(isUser?20:0),
                          topEnd: Radius.circular(isUser?0:20),
                          bottomEnd:const Radius.circular(20),
                          bottomStart:const Radius.circular(20),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child:ImageNet(image: content,)
                  ),
                );
              case Type.record:
                return Container(
                    decoration: BoxDecoration(
                      color: isUser?defaultColor:HexColor('#EEEEEE'),
                      borderRadius: BorderRadiusDirectional.only(
                        topStart:Radius.circular(isUser?20:0),
                        topEnd: Radius.circular(isUser?0:20),
                        bottomEnd:const Radius.circular(20),
                        bottomStart:const Radius.circular(20),
                      ),
                    ),
                    padding:const EdgeInsets.symmetric(horizontal: 10),
                    child:RecordItem(url: content,timeColor:isUser? Colors.white:Colors.grey,)
                );
              default:
                return const SizedBox();
            }
          },

          ),
        ],
      ),
    );
  }
}



