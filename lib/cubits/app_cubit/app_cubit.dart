import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:prayer_app/cubits/app_cubit/app_states.dart';
import 'package:prayer_app/model/prayer_times_model.dart';
import 'package:prayer_app/networks/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppStates());
  static AppCubit get(context) => BlocProvider.of(context);

  DateTime selected;
  PrayerTimesModel prayerTimesModel;
  Future<LocationData> getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    var locationData = await location.getLocation();
    return locationData;
  }

  void onDaySelected({DateTime value}) async {
    LocationData location = await getLocation();
    selected = value;
    getPrayerTimeAccordingToLocation(
        month: value.month,
        year: value.year,
        lat: location.latitude,
        lang: location.longitude);
    emit(OnDaySelectedSuccessState());
  }

  Future<PrayerTimesModel> getPrayerTimeAccordingToLocation(
      {int month, int year, double lat, double lang}) async {
    try {
      emit(GetPrayerTimeAccordingToLocationLoadingState());
      var response = await DioHelper.getData(url: "calendar", query: {
        "latitude": lat,
        "longitude": lang,
        "method": 5,
        "month": month,
        "year": year,
        "timezonestring": "Africa/Cairo",
      });
      prayerTimesModel = PrayerTimesModel.fromJson(response.data);
      emit(GetPrayerTimeAccordingToLocationSuccessState());
    } catch (error) {
      print("error is $error");
      emit(GetPrayerTimeAccordingToLocationErrorState());
    }
    return prayerTimesModel;
  }
}
