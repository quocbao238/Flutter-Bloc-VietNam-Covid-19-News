// ignore_for_
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    _mapGlobalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MapBloc()..add(const LoadEvent()),
        child: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
          final bloc = BlocProvider.of<MapBloc>(context);
          return Scaffold(
              key: _mapGlobalKey,
              backgroundColor: ThemePrimary.primaryColor,
              body: state is LoadingState
                  ? const LoadingWidget()
                  : RefreshIndicator(
                      onRefresh: () async => bloc.add(const RefeshEvent()),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: SizeApp.normalPadding,
                                right: SizeApp.normalPadding,
                                bottom: SizeApp.normalPadding),
                            child: Text("Bản đồ vùng dịch",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white)),
                          ),
                          if (state is LoadingSucessState)
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: ThemePrimary.scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 16, bottom: 16),
                                  child: SfMaps(layers: [
                                    // MapShapeLayer(
                                    //   source: MapShapeSource.asset(
                                    //       'assets/paracelIslands.json'),
                                    // ),
                                    // MapShapeLayer(
                                    //   source: MapShapeSource.asset(
                                    //       'assets/spralyIslands.json'),
                                    // ),

                                    MapShapeLayer(
                                      source: bloc.mapSource,
                                      legend: MapLegend(
                                        MapElement.shape,
                                        position: MapLegendPosition.left,
                                        offset: const Offset(-10, 0),
                                        iconType: MapIconType.rectangle,
                                        enableToggleInteraction: true,
                                        iconSize: const Size(14, 14),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      tooltipSettings: MapTooltipSettings(
                                          color: ThemePrimary.primaryColor,
                                          strokeColor: Colors.white,
                                          strokeWidth: 2),
                                      strokeColor: Colors.white,
                                      strokeWidth: 1,
                                      shapeTooltipBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              "${bloc.listMapModel[index].title}\n${NumberFormat.decimalPattern().format(bloc.listMapModel[index].total)} ca nhiễm",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.white)),
                                        );
                                      },
                                    ),

                                    // MapShapeLayer(
                                    //   source: MapShapeSource.asset(
                                    //       'assets/spralyIslands.json'),
                                    // )
                                  ])),
                            ),
                        ],
                      ),
                    ));
        }));
  }
}
