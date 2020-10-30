
import 'package:get_it/get_it.dart';
import 'package:turing_academy/core/pref.dart';
import 'package:turing_academy/core/services/kidApi.dart';
import 'package:turing_academy/core/services/notificationApi.dart';
import 'package:turing_academy/core/services/orderApi.dart';
import 'package:turing_academy/core/services/productAPi.dart';
import 'package:turing_academy/core/services/resultApi.dart';
import 'package:turing_academy/core/services/subsriptionApi.dart';
import 'package:turing_academy/core/services/userAPi.dart';
import 'package:turing_academy/core/viewModel/add_address_viewmodel.dart';
import 'package:turing_academy/core/viewModel/homeViewModel.dart';
import 'package:turing_academy/core/viewModel/kidViewModel.dart';
import 'package:turing_academy/core/viewModel/myprofile_viewmodel.dart';
import 'package:turing_academy/core/viewModel/notifcationViewModel.dart';
import 'package:turing_academy/core/viewModel/orderViewModel.dart';
import 'package:turing_academy/core/viewModel/productViewModel.dart';
import 'package:turing_academy/core/viewModel/resultViewModel.dart';
import 'package:turing_academy/core/viewModel/subscriptionViewModel.dart';
import 'package:turing_academy/core/viewModel/userViewModel.dart';


GetIt getIt = GetIt.instance;

void setupGetIt() {

  getIt.registerFactory(() => ProductApi());
  getIt.registerFactory(() => ProductViewModel());
  getIt.registerFactory(() => Prefs());
  getIt.registerFactory(() => KidViewModel());
  getIt.registerFactory(() => KidApi());
  getIt.registerFactory(() => UserViewModel());
  getIt.registerFactory(() => UserApi());
  getIt.registerFactory(() => OrderApi());
  getIt.registerFactory(() => OrderViewModel());
  getIt.registerFactory(() => ResultApi());
  getIt.registerFactory(() => ResultViewModel());
  getIt.registerFactory(() => SubScriptionViewModel());
  getIt.registerFactory(() => SubscriptionApi());
  getIt.registerFactory(() => NotificationViewModel());
  getIt.registerFactory(() => NotificationAPi());
  getIt.registerFactory(() => AddShippingAddressViewModel());
  getIt.registerFactory(() => MyProfileViewModel());







}
