import 'package:flutter/material.dart'
    show BlendMode, BoxFit, ColorFilter, SizedBox, StatelessWidget, Widget;
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:reminder/cores/colors/color.dart' show AppColorBase;

class RemUISvg extends StatelessWidget {
  const RemUISvg({
    this.asset,
    this.network,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
    super.key,
  });

  final String? asset;
  final String? network;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AppColorBase? color;

  @override
  Widget build(_) {
    if (asset != null && asset!.isNotEmpty) {
      return SvgPicture.asset(
        asset!,
        width: width,
        height: height,
        fit: fit,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color!.value, BlendMode.srcIn),
      );
    }

    if (network != null && network!.isNotEmpty) {
      return SvgPicture.network(
        network!,
        width: width,
        height: height,
        fit: fit,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color!.value, BlendMode.srcIn),
      );
    }

    return const SizedBox.shrink();
  }
}
