import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:vietnamcovidtracking/source/config/size_app.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/pages/vaccination/bloc/vaccination_bloc.dart';
import 'package:vietnamcovidtracking/source/widget/floating_animation.dart';

class VaccinationPage extends StatefulWidget {
  static const String routeName = "/vaccinationPage";
  const VaccinationPage({Key? key}) : super(key: key);

  @override
  _VaccinationPageState createState() => _VaccinationPageState();
}

class _VaccinationPageState extends State<VaccinationPage>
    with TickerProviderStateMixin {
  late GlobalKey _vaccinGlobalKey;
  late TextEditingController searchEditController;

  //Filter mytask, all task
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    _vaccinGlobalKey = GlobalKey();
    searchEditController = TextEditingController();

    searchEditController.addListener(() {
      BlocProvider.of<VaccinationBloc>(_vaccinGlobalKey.currentContext!)
          .add(SearchProvinceEvent(keySearch: searchEditController.text));
    });

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    CurvedAnimation curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }

  @override
  void dispose() {
    searchEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VaccinationBloc()..add(const LoadEvent()),
      child: BlocBuilder<VaccinationBloc, VaccinationState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<VaccinationBloc>(context);

          Widget _header() {
            return GestureDetector(
                onTap: () {
                  bloc.add(ChangeVaccinViewEvent(
                    isShowVaccin: !bloc.isShowVacination,
                  ));
                },
                child: Container(
                    color: ThemePrimary.primaryColor,
                    padding: const EdgeInsets.only(
                        left: SizeApp.normalPadding,
                        right: SizeApp.normalPadding,
                        bottom: SizeApp.normalPadding),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                                bloc.isShowVacination
                                    ? "Số liệu tiêm chủng"
                                    : "Số liệu ca nhiễm",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white)),
                          ),
                        ])));
          }
          // const Icon(Icons.filter_alt_outlined, color: Colors.white)

          Widget _body() {
            Text ____textItem(String txt, {Color? color}) => Text(txt,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color ?? ThemePrimary.textPrimaryColor));

            Widget __loadingWidget() {
              return Center(
                  child: SizedBox(
                      height: 25,
                      width: 25,
                      child: SpinKitFadingFour(
                          color: ThemePrimary.primaryColor, size: 24.0)));
            }

            Widget __searchWidget() {
              return SizedBox(
                height: 54,
                child: TextField(
                  controller: searchEditController,
                  style: Theme.of(context).textTheme.bodyText2!,
                  decoration: InputDecoration(
                      isDense: true,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: ThemePrimary.primaryColor),
                      hintText: "Tìm kiếm theo tỉnh thành",
                      prefixIcon: Icon(
                        Icons.search,
                        color: ThemePrimary.primaryColor,
                      ),
                      suffixIcon: searchEditController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchEditController.clear();
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.grey,
                              ),
                            )
                          : null,
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: ThemePrimary.primaryColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: ThemePrimary.primaryColor)),
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              width: 1, color: ThemePrimary.primaryColor))),
                ),
              );
            }

            Widget __titleListWidget() {
              Text ___textTitle(String txt) => Text(txt,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.w500));

              return Row(
                children: [
                  Expanded(flex: 1, child: ___textTitle("Tỉnh thành")),
                  const SizedBox(width: 8.0),
                  Expanded(
                      flex: 1,
                      child: ___textTitle(
                          bloc.isShowVacination ? "Tiêm mũi 1" : "Tổng số ca")),
                  const SizedBox(width: 8.0),
                  Expanded(
                      flex: 1,
                      child: ___textTitle(bloc.isShowVacination
                          ? "Tiêm đủ liều"
                          : "Số ca mới")),
                ],
              );
            }

            Widget __lstDataWidget() {
              Widget ___itemRatio({
                required int sumVaccine,
                required double percentVaccine,
              }) {
                int _percentVaccine = percentVaccine.toInt();
                int _restpercent = 100 - _percentVaccine;

                Widget ____ratioPercent() {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: Colors.grey[300]!,
                    )),
                    height: 28,
                    child: Row(
                      children: [
                        Expanded(
                          flex: _percentVaccine,
                          child: Container(
                            color: ThemePrimary.primaryColor,
                            child: Center(
                              child: Text(
                                (percentVaccine < 100
                                        ? percentVaccine.toStringAsFixed(2)
                                        : "100") +
                                    "%",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: _restpercent,
                          child: Container(
                            color: ThemePrimary.orange,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ____textItem(
                        NumberFormat.decimalPattern().format(sumVaccine)),
                    ____ratioPercent()
                  ],
                );
              }

              Widget ___newsCaseItem(int incconfirmed) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_upward,
                          color: incconfirmed > 0
                              ? ThemePrimary.red
                              : Colors.transparent,
                          size: 16),
                      ____textItem(
                          incconfirmed > 0
                              ? NumberFormat.decimalPattern()
                                  .format(incconfirmed)
                              : "-",
                          color: ThemePrimary.red),
                    ],
                  );

              return Expanded(
                child: bloc.lstSearchProvince.isEmpty
                    ? const Center(child: Text("Không có dữ liệu"))
                    : ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 20),
                        children: bloc.lstSearchProvince.map((e) {
                          return Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.black12))),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1, child: ____textItem(e.title!)),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                      flex: 1,
                                      child: bloc.isShowVacination
                                          ? ___itemRatio(
                                              sumVaccine: e.onevaccine ?? 0,
                                              percentVaccine:
                                                  e.onevaccinepercent ?? 0.0)
                                          : ____textItem(
                                              NumberFormat.decimalPattern()
                                                  .format(e.confirmed!),
                                            )),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                      flex: 1,
                                      child: bloc.isShowVacination
                                          ? ___itemRatio(
                                              sumVaccine: e.donevaccine ?? 0,
                                              percentVaccine:
                                                  e.donevaccinepercent ?? 0.0)
                                          : ___newsCaseItem(e.incconfirmed!)),
                                ],
                              ));
                        }).toList()),
              );
            }

            return Expanded(
              child: state is LoadingState
                  ? __loadingWidget()
                  : Container(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12, top: 16),
                      child: Column(
                        children: [
                          __searchWidget(),
                          const SizedBox(height: 8),
                          __titleListWidget(),
                          const SizedBox(height: 8),
                          __lstDataWidget(),
                        ],
                      ),
                    ),
            );
          }

          return Scaffold(
            key: _vaccinGlobalKey,
            // backgroundColor: ThemePrimary.primaryColor,
            body: RefreshIndicator(
              onRefresh: () async {
                bloc.add(const RefeshEvent());
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _header(),
                  _body(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionBubble(
              backGroundColor: ThemePrimary.primaryColor,
              iconData: bloc.isReverseAnimation
                  ? Icons.filter_alt_rounded
                  : Icons.close,
              items: <Bubble>[
                Bubble(
                  title: "Xem theo số liệu tiêm chủng",
                  iconColor: !bloc.isShowVacination
                      ? ThemePrimary.primaryColor
                      : Colors.white,
                  bubbleColor: !bloc.isShowVacination
                      ? Colors.white
                      : ThemePrimary.primaryColor,
                  icon: Icons.format_list_numbered_sharp,
                  titleStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: !bloc.isShowVacination
                          ? ThemePrimary.primaryColor
                          : Colors.white),
                  onPress: () {
                    animationController.reverse();
                    bloc.add(const ChangeVaccinViewEvent(isShowVaccin: true));
                  },
                ),
                Bubble(
                  title: "Xem theo số liệu ca nhiễm",
                  iconColor: bloc.isShowVacination
                      ? ThemePrimary.primaryColor
                      : Colors.white,
                  bubbleColor: bloc.isShowVacination
                      ? Colors.white
                      : ThemePrimary.primaryColor,
                  icon: Icons.format_list_numbered_sharp,
                  titleStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: bloc.isShowVacination
                          ? ThemePrimary.primaryColor
                          : Colors.white),
                  onPress: () {
                    animationController.reverse();

                    bloc.add(const ChangeVaccinViewEvent(isShowVaccin: false)); 
                  },
                ),
              ],
              animation: animation,
              onPress: () {
                if (animationController.status == AnimationStatus.dismissed) {
                  bloc.add(
                      const ReverseAnimationEvent(isReverseAnimation: false));
                  animationController.forward();
                } else {
                  bloc.add(
                      const ReverseAnimationEvent(isReverseAnimation: true));
                  animationController.reverse();
                }
              },
              iconColor: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
