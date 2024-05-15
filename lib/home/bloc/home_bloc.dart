import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:march09/home/data/contact_log.dart';

import '../model/contact_model.dart';
import '../utils/sorting_enum.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final List<List<ContactModel>> contactTabList = [];
  static int totalTabs = 5;
  List<Sorting> selectedLabel = List.filled(totalTabs, Sorting.NONE);
  int currentTab = 0;

  HomeBloc() : super(HomeInitial()) {
    on<InitialDataLoadingEvent>(initialDataLoadingEvent);
    on<FloatingSortButtonClickedEvent>(floatingSortButtonClickedEvent);
    on<SortAscOrDEscButtonClickEvent>(sortAscOrDEscButtonClickEvent);
    on<ContactTabClickedEvent>(contactTabClickedEvent);
  }

  void splitContactList(int index){
    final totalLength = ContactLog.contactLogList.length;
    final eachTabItemCount = totalLength ~/totalTabs;
    final start = eachTabItemCount*index;
    int end = start + eachTabItemCount;
    if(index == totalTabs-1){
      end = ContactLog.contactLogList.length;
    }
    contactTabList.add(ContactLog.contactLogList.sublist(start,end));
  }

  FutureOr<void> initialDataLoadingEvent(InitialDataLoadingEvent event, Emitter<HomeState> emit) {
     emit(HomeLoading());
     Future.delayed(const Duration(seconds: 1));
     final List<ContactModel> contactList = ContactLog.contactLog.map((m) => ContactModel(url: m['url']??'',
         id: m['id']??'',
         name: m['name']??'',
         contact: m['Contacts']??''
     )).toList();
     ContactLog.contactLogList.addAll(contactList);
     for(int i =0;i<totalTabs;i++){
       splitContactList(i);
     }
     emit(HomeLoadingSuccess(contactList: contactTabList[0]));
  }

  void sortingByLabel(){
    switch(selectedLabel[currentTab]){
      case Sorting.ASCBYNAME:
        contactTabList[currentTab].sort((item1,item2) => sortByName(item1.name,item2.name));
        break;
      case Sorting.DESCBYNAME:
        contactTabList[currentTab].sort((item1,item2) => sortByName(item2.name,item1.name));
        break;
      case Sorting.ASCBYCONTACT:
        contactTabList[currentTab].sort((item1,item2) => sortByName(item1.contact,item2.contact));
        break;
      case Sorting.DESCBYCONTACT:
        contactTabList[currentTab].sort((item1,item2) => sortByName(item2.contact,item1.contact));
      default :

    }
  }

  int sortByName(String name1,String name2){
      // Function to extract the numeric part from a string
      int extractNumber(String name) {
        // Regular expression to find the numeric part
        final regex = RegExp(r'\d+');
        final match = regex.firstMatch(name);
        if (match != null) {
          return int.parse(match.group(0)!);
        } else {
          return 0; // Default to 0 if no number is found
        }
      }
      int numA = extractNumber(name1);
      int numB = extractNumber(name2);

      return numA.compareTo(numB);
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
