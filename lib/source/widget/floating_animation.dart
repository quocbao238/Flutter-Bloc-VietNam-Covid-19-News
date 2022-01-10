// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Bubble {
  const Bubble(
      {required this.title,
      required this.titleStyle,
      required this.iconColor,
      required this.bubbleColor,
      required this.icon,
      required this.onPress});

  final IconData icon;
  final Color iconColor;
  final Color bubbleColor;
  final Function onPress;
  final String title;
  final TextStyle titleStyle;
}

class BubbleMenu extends StatelessWidget {
  const BubbleMenu(this.item);

  final Bubble item;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const StadiumBorder(),
      padding: const EdgeInsets.only(top: 11, bottom: 13, left: 16, right: 16),
      color: item.bubbleColor,
      splashColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.grey.withOpacity(0.1),
      elevation: 2,
      highlightElevation: 2,
      disabledColor: item.bubbleColor,
      onPressed: () {
        item.onPress();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Text(item.title,
                overflow: TextOverflow.ellipsis, style: item.titleStyle),
          ),
          const SizedBox(width: 10.0),
          Icon(item.icon, color: item.iconColor)
        ],
      ),
    );
  }
}

class _DefaultHeroTag {
  const _DefaultHeroTag();
  @override
  String toString() => '<default FloatingActionBubble tag>';
}

class FloatingActionBubble extends AnimatedWidget {
  const FloatingActionBubble({
    required this.items,
    required this.onPress,
    required this.iconColor,
    required this.backGroundColor,
    required Animation animation,
    this.herotag,
    this.iconData,
    this.animatedIconData,
  })  : assert((iconData == null && animatedIconData != null) ||
            (iconData != null && animatedIconData == null)),
        super(listenable: animation);

  final List<Bubble> items;
  final Function onPress;
  final AnimatedIconData? animatedIconData;
  final Object? herotag;
  final IconData? iconData;
  final Color iconColor;
  final Color backGroundColor;

  get _animation => listenable;

  Widget buildItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    TextDirection textDirection = Directionality.of(context);

    double animationDirection = textDirection == TextDirection.ltr ? -1 : 1;

    final transform = Matrix4.translationValues(
      animationDirection *
          (screenWidth - _animation.value * screenWidth) *
          ((items.length - index) / 4),
      0.0,
      0.0,
    );

    return Align(
      alignment: textDirection == TextDirection.ltr
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Transform(
        transform: transform,
        child: Opacity(
          opacity: _animation.value,
          child: BubbleMenu(items[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IgnorePointer(
          ignoring: _animation.value == 0,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 12.0),
            padding: const EdgeInsets.only(top: 12, bottom: 12, left: 32),
            itemCount: items.length,
            itemBuilder: buildItem,
          ),
        ),
        FloatingActionButton(
          heroTag: herotag ?? const _DefaultHeroTag(),
          backgroundColor: backGroundColor,
          // iconData is mutually exclusive with animatedIconData
          // only 1 can be null at the time
          child: iconData == null
              ? AnimatedIcon(
                  icon: animatedIconData ?? AnimatedIcons.menu_arrow,
                  progress: _animation,
                )
              : Icon(
                  iconData,
                  color: iconColor,
                ),
          onPressed: () => onPress(),
        ),
      ],
    );
  }
}
