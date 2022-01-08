// ignore_for_
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vietnamcovidtracking/source/config/size_app.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/pages/map/bloc/map_bloc.dart';
import 'package:vietnamcovidtracking/source/widget/loading_widget.dart';

class MapPage extends StatefulWidget {
  static const String routeName = "/mapPage";
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GlobalKey _mapGlobalKey;
  late TextEditingController searchEditController;

  @override
  void initState() {
    _mapGlobalKey = GlobalKey();
    searchEditController = TextEditingController();

    searchEditController.addListener(() {
      BlocProvider.of<MapBloc>(_mapGlobalKey.currentContext!)
          .add(SearchProvinceEvent(keySearch: searchEditController.text));
    });
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
        create: (context) => MapBloc()..add(const LoadEvent()),
        child: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
          final bloc = BlocProvider.of<MapBloc>(context);

          Widget _title() {
            return GestureDetector(
              onTap: () {
                searchEditController.clear();
                bloc.add(ChangeMapListEvent(!bloc.isViewMap));
              },
              child: Container(
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
                          bloc.isViewMap
                              ? "Bản đồ vùng dịch"
                              : "Ca nhiễm ở các tỉnh thành",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white)),
                    ),
                    Icon(bloc.isViewMap ? Icons.menu_sharp : Icons.map,
                        color: Colors.white)
                  ],
                ),
              ),
            );
          }

          Widget _viewMap() {
            return SfMaps(layers: [
              MapShapeLayer(
                loadingBuilder: (BuildContext context) {
                  return SizedBox(
                      height: 25,
                      width: 25,
                      child: SpinKitFadingFour(
                          color: ThemePrimary.primaryColor, size: 24.0));
                },
                source: bloc.mapSource,
                legend: MapLegend(
                  MapElement.shape,
                  position: MapLegendPosition.left,
                  offset: const Offset(-10, 0),
                  iconType: MapIconType.rectangle,
                  enableToggleInteraction: true,
                  iconSize: const Size(14, 14),
                  textStyle: Theme.of(context).textTheme.bodyText1,
                ),
                tooltipSettings: MapTooltipSettings(
                    color: ThemePrimary.primaryColor,
                    strokeColor: Colors.white,
                    strokeWidth: 2),
                strokeColor: Colors.white,
                strokeWidth: 1,
                shapeTooltipBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${bloc.listMapModel[index].title}\n${NumberFormat.decimalPattern().format(bloc.listMapModel[index].total)} ca nhiễm",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white)),
                  );
                },
              ),
            ]);
          }

          Widget _viewLst() {
            Text _textTitle(String txt) => Text(txt,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.w500));

            Text _textItem(String txt, {Color? color}) => Text(txt,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color ?? ThemePrimary.textPrimaryColor));

            return state is LoadingListData
                ? Center(
                    child: SizedBox(
                        height: 25,
                        width: 25,
                        child: SpinKitFadingFour(
                            color: ThemePrimary.primaryColor, size: 24.0)))
                : Container(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 54,
                          // padding: const EdgeInsets.only(left: 14, right: 14),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: ThemePrimary.primaryColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: ThemePrimary.primaryColor)),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: ThemePrimary.primaryColor))),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(flex: 2, child: _textTitle("Tỉnh thành")),
                            const SizedBox(width: 8.0),
                            Expanded(flex: 1, child: _textTitle("Tổng số ca")),
                            const SizedBox(width: 8.0),
                            Expanded(flex: 1, child: _textTitle("Số ca mới")),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: bloc.lstSearchProvince.isEmpty
                              ? Center(
                                  child: Text("Không có dữ liệu"),
                                )
                              : ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.only(bottom: 20),
                                  children: bloc.lstSearchProvince.map((e) {
                                    return Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: _textItem(e.title!)),
                                            const SizedBox(width: 8.0),
                                            Expanded(
                                                flex: 1,
                                                child: _textItem(
                                                  NumberFormat.decimalPattern()
                                                      .format(e.confirmed!),
                                                )),
                                            const SizedBox(width: 8.0),
                                            Expanded(
                                                flex: 1,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.arrow_upward,
                                                        color: e.incconfirmed! >
                                                                0
                                                            ? ThemePrimary.red
                                                            : Colors
                                                                .transparent,
                                                        size: 16),
                                                    _textItem(
                                                        e.incconfirmed! > 0
                                                            ? NumberFormat
                                                                    .decimalPattern()
                                                                .format(e
                                                                    .incconfirmed)
                                                            : "-",
                                                        color:
                                                            ThemePrimary.red),
                                                  ],
                                                )),
                                          ],
                                        ));
                                  }).toList()),
                        ),
                      ],
                    ),
                  );
          }

          return Scaffold(
              key: _mapGlobalKey,
              backgroundColor: ThemePrimary.primaryColor,
              body: state is LoadingState
                  ? const LoadingWidget()
                  : RefreshIndicator(
                      onRefresh: () async {
                        bloc.add(const RefeshEvent());
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _title(),
                          if (state is LoadingSucessState)
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: ThemePrimary.scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          bloc.isViewMap ? 50 : 0),
                                      topRight: Radius.circular(
                                          bloc.isViewMap ? 50 : 0),
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 16, bottom: 16),
                                  child:
                                      bloc.isViewMap ? _viewMap() : _viewLst()),
                            ),
                        ],
                      ),
                    ));
        }));
  }
}
