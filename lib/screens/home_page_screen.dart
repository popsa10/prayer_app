import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_app/cubits/app_cubit/app_cubit.dart';
import 'package:prayer_app/cubits/app_cubit/app_states.dart';
import 'package:prayer_app/screens/components/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  CalendarController calenderController;
  @override
  void initState() {
    // TODO: implement initState
    calenderController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is GetPrayerTimeAccordingToLocationErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please,TryAgain Later")));
            }
          },
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Column(
              children: [
                buildCustomTableCalender(
                    cubit: cubit, controller: calenderController),
                cubit.prayerTimesModel != null
                    ? Expanded(
                        child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(children: [
                            buildPrayerWithTimeItem(
                                text: "Fajr",
                                date: cubit.prayerTimesModel
                                    .data[cubit.selected.day - 1].timings.fajr),
                            buildPrayerWithTimeItem(
                                text: "Durh",
                                date: cubit
                                    .prayerTimesModel
                                    .data[cubit.selected.day - 1]
                                    .timings
                                    .dhuhr),
                            buildPrayerWithTimeItem(
                                text: "Asr",
                                date: cubit.prayerTimesModel
                                    .data[cubit.selected.day - 1].timings.asr),
                            buildPrayerWithTimeItem(
                                text: "Maghreb",
                                date: cubit
                                    .prayerTimesModel
                                    .data[cubit.selected.day - 1]
                                    .timings
                                    .maghrib),
                            buildPrayerWithTimeItem(
                                text: "Esha",
                                date: cubit.prayerTimesModel
                                    .data[cubit.selected.day - 1].timings.isha),
                          ]),
                        ),
                      ))
                    : const Center(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(),
                        ),
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}
