import 'package:bloc/bloc.dart';
import 'package:lesson_for_fintech/boxes.dart';
import 'package:lesson_for_fintech/model/hive_user.dart';
import 'package:lesson_for_fintech/service/get_user.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial()) {
    fetchUsers();
  }
  var box = Boxes.hiveBox;
  List<HiveUser> response = [];
  //THIS FUNCTION FETCH API FROM SERVICE
  fetchUsers() async {
    response = await GetUsers().getAllUsers();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      emit(UserLoading());
      box.clear();
      for (var element in response) {
        addUserToHive(
            address: element.address,
            company: element.company,
            email: element.email,
            id: element.id,
            name: element.name,
            phone: element.phone,
            username: element.username,
            website: element.website);
      }
      emit(UserInitial());
      return response;
    } else {
      emit(UserNotConnection());
    }
  }
  //THIS FUNCTION FOR ADD HIVE FROM API
  void addUserToHive({
    int? id,
    String? name,
    String? username,
    String? email,
    var address,
    String? phone,
    String? website,
    var company,
  }) {
    final user = HiveUser(
        address: address,
        company: company,
        email: email,
        id: id,
        name: name,
        phone: phone,
        username: username,
        website: website);
    box.add(user);
  }
}
