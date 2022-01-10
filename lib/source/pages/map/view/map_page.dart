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

  @override
  void initState() {
    _mapGlobalKey = GlobalKey();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapBloc()..add(const LoadEvent()),
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<MapBloc>(context);

          Widget _title() {
            return InkWell(
              onTap: () {
                bloc.add(WarningMapEvent(context));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: ThemePrimary.primaryColor,
                padding: const EdgeInsets.only(
                    left: SizeApp.normalPadding,
                    right: SizeApp.normalPadding,
                    bottom: SizeApp.normalPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bản đồ vùng dịch",
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white)),
                    const Icon(
                      Icons.warning,
                      color: Colors.red,
                    )
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

          return Scaffold(
            key: _mapGlobalKey,
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
                                padding: const EdgeInsets.only(top: 8),
                                // color: Colors.green,
                                child: _viewMap()),
                          ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
