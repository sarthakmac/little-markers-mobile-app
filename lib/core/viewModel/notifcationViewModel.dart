
import 'package:get_it/get_it.dart';
import 'package:turing_academy/core/enums/view_state.dart';
import 'package:turing_academy/core/model/SendApi/addkidCredential.dart';
import 'package:turing_academy/core/model/SendApi/order.dart';
import 'package:turing_academy/core/model/kidModel.dart';
import 'package:turing_academy/core/model/notification.dart';
import 'package:turing_academy/core/model/productModel.dart';
import 'package:turing_academy/core/model/responseMessage.dart';
import 'package:turing_academy/core/services/kidApi.dart';
import 'package:turing_academy/core/services/notificationApi.dart';
import 'package:turing_academy/core/services/orderApi.dart';
import 'package:turing_academy/core/services/productAPi.dart';
import 'package:turing_academy/core/viewModel/baseModel.dart';
import 'package:turing_academy/models/product.dart';

GetIt getIt = GetIt.instance;

class NotificationViewModel extends BaseModel {
  NotificationAPi _api = getIt<NotificationAPi>();
  int currentIndex=0;

  List<Notifications> _notifications = [];
  List<Notifications> get notifications => _notifications;


  void getNotificationList() async {
    setState(ViewState.BUSY);
    _notifications=await _api.getNotificationApi();
    setState(ViewState.IDLE);
  }
  Future<ResponseMessage> clearnotification() async {

    ResponseMessage responseMessage=await _api.clearNotificationApi();
    setState(ViewState.IDLE);
    return responseMessage;
  }
  Future<ResponseMessage> markallasReadnotification() async {
    ResponseMessage responseMessage =await _api.markAllNotificationApi();


    setState(ViewState.IDLE);
    return responseMessage;
  }



}
