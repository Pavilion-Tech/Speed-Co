import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speed_co/modules/provider/menu_screens/cubit/provider_menu_states.dart';

class ProviderMenuCubit extends Cubit<ProviderMenuStates>{
  ProviderMenuCubit():super(InitState());
  static ProviderMenuCubit get (context)=>BlocProvider.of(context);

  XFile? profileImage;
  ImagePicker picker = ImagePicker();


  Future<XFile?> pick(ImageSource source)async{
    try{
      return await picker.pickImage(source: source,imageQuality: 20);
    } catch(e){
      print(e.toString());
      emit(ImageWrong());
    }
  }
  void justEmit(){
    emit(JustEmitState());
  }
}