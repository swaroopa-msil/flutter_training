import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:march09/home/repository/home_repository.dart';
import 'package:march09/home/utils/app_constants.dart';
import '../model/contact_model.dart';
import '../utils/sorting_enum.dart';
import '../utils/sorting_utils.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> with SortingList {

  final List<List<ContactModel>> contactTabList = [];
  static int totalTabs = 5;
  List<Sorting> selectedLabel = List.filled(totalTabs, Sorting.NONE);
  int currentTab = 0;
  final List<ContactModel> contactLogList = [];
  final _homeRepo = HomeRepository();

  HomeBloc() : super(HomeInitial()) {
    on<InitialDataLoadingEvent>(initialDataLoadingEvent);
    on<FloatingSortButtonClickedEvent>(floatingSortButtonClickedEvent);
    on<SortAscOrDEscButtonClickEvent>(sortAscOrDEscButtonClickEvent);
    on<ContactTabClickedEvent>(contactTabClickedEvent);
  }



  void splitContactList(int index){
    final totalLength = contactLogList.length;
    final eachTabItemCount = totalLength ~/totalTabs;
    final start = eachTabItemCount*index;
    int end = start + eachTabItemCount;
    if(index == totalTabs-1){
      end = contactLogList.length;
    }
    contactTabList.add(contactLogList.sublist(start,end));
  }

  FutureOr<void> initialDataLoadingEvent(InitialDataLoadingEvent event, Emitter<HomeState> emit) async {
     emit(HomeLoading());
     Future.delayed(const Duration(seconds: 1));
     final List<ContactModel>? list = await _homeRepo.getContactDataFromServer();
     if(list != null){
       contactLogList.addAll(list);
       for(int i =0;i<totalTabs;i++){
         splitContactList(i);
       }
       emit(HomeLoadingSuccess(contactList: contactTabList[0]));
     }else{
       emit(HomeLoadingError(errorMessage: AppConstant.API_FAILED_ERROR_MESSAGE));
     }

  }

  void sortingByLabel(){
    switch(selectedLabel[currentTab]){
      case Sorting.ASCBYNAME:
        contactTabList[currentTab].sort((item1,item2) => sortStringWithNumeric(item1.name,item2.name));
        break;
      case Sorting.DESCBYNAME:
        contactTabList[currentTab].sort((item1,item2) => sortStringWithNumeric(item2.name,item1.name));
        break;
      case Sorting.ASCBYCONTACT:
        contactTabList[currentTab].sort((item1,item2) => sortStringWithNumeric(normalizePhoneNumber(item1.contact),normalizePhoneNumber(item2.contact)));
        break;
      case Sorting.DESCBYCONTACT:
        contactTabList[currentTab].sort((item1,item2) => sortStringWithNumeric(normalizePhoneNumber(item2.contact),normalizePhoneNumber(item1.contact)));
      default :

    }
  }

  FutureOr<void> floatingSortButtonClickedEvent(FloatingSortButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(SortDialogLoadingSuccess(selectedLabel: selectedLabel[currentTab]));
  }

  FutureOr<void> sortAscOrDEscButtonClickEvent(SortAscOrDEscButtonClickEvent event, Emitter<HomeState> emit) {
    selectedLabel[currentTab] = event.sortingLabel;
    sortingByLabel();
    emit(HomeLoadingSuccess(contactList: contactTabList[currentTab]));
  }

  FutureOr<void> contactTabClickedEvent(ContactTabClickedEvent event, Emitter<HomeState> emit) {
    currentTab = event.tabIndex;
    emit(HomeLoadingSuccess(contactList: contactTabList[currentTab]));
  }
}
