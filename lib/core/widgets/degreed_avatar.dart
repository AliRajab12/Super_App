import 'dart:math';
import 'dart:typed_data';

import 'package:somi/core/models/user.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/utils/extensions.dart';
import 'package:somi/core/widgets/dg_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../repos/auth_data_repo.dart';

class DegreedAvatar extends StatelessWidget {
  const DegreedAvatar({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.activeLearner,
    double? size,
    this.border,
    this.imageData,
  })  : size = size ?? 24,
        super(key: key);

  factory DegreedAvatar.user({
    Key? key,
    required User? user,
    double? size,
    BorderSide? border,
    bool? activeLearner,
    Uint8List? imageData,
  }) {
    return DegreedAvatar(
      name: user?.name,
      imageUrl: user?.picture,
      activeLearner: activeLearner ?? (user?.isEngaged == true),
      size: size,
      border: border,
      imageData: imageData,
    );
  }

  factory DegreedAvatar.self({
    Key? key,
    double? size,
    BorderSide? border,
    Uint8List? imageData,
  }) {
    return DegreedAvatar.user(
      key: key,
      user: locator<UserRepo>().user,
      size: size,
      border: border,
      imageData: imageData,
    );
  }

  final String? name;
  final String? imageUrl;
  final bool activeLearner;
  final double size;
  final BorderSide? border;
  final Uint8List? imageData;

  int nameHash(String? name) {
    // https://github.com/degreed/Degreed/blob/6690ead3ee3fe595fcbdd7d0913115ee94eb71d9/trunk/Degreed.Web/ngx-app/src/app/shared/components/profile-pic/profile-pic-fallback.service.ts#L91
    name ??= Random()
        .nextInt(1 << 32)
        .toRadixString('Degreed'.length)
        .substring(2, 6);
    int hash = 0;
    for (var ch in name.codeUnits) {
      hash = (hash << 5) - hash + ch;
      hash |= 0;
    }
    return hash.abs();
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    if (imageData != null) {
      imageProvider = MemoryImage(imageData!);
    } else {
      String url = imageUrl ?? '';

      // Prepend blob base url if necessary
      if (url.startsWith(RegExp(r'~?/'))) {
        url = locator<AuthDataRepo>().blobBaseUrl + url.replaceFirst('~/', '/');
      }

      imageProvider = _foregroundImageProvider(context, url);
    }

    return SizedBox(
      width: size,
      height: size,
      child: OverflowBox(
        minWidth: size + 8,
        maxWidth: size + 8,
        minHeight: size + 8,
        maxHeight: size + 8,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (border != null)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: border!.color,
                ),
                constraints: BoxConstraints(
                  minWidth: size + (border!.width * 2),
                  maxWidth: size + (border!.width * 2),
                  minHeight: size + (border!.width * 2),
                  maxHeight: size + (border!.width * 2),
                ),
              ),
            CircleAvatar(
              radius: size / 2,
              backgroundColor: AppColors.background,
              foregroundImage: imageProvider,
              backgroundImage:
                  Svg('images/placeholders/profile/${nameHash(name) % 36}.svg'),
            ),
            if (activeLearner)
              CustomPaint(
                size: Size(size + 6, size + 6),
                painter: ActiveLearnerBorderPainter(),
              )
          ],
        ),
      ),
    );
  }

  ImageProvider? _foregroundImageProvider(BuildContext context, String? url) {
    if (url == null || url.isBlank) return null;
    if (url.contains('.svg')) {
      return Svg(url, source: SvgSource.network);
    }
    return DGNetworkImageProvider(url);
  }
}

class ActiveLearnerBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(
        rect, pi / 4, pi / 4 * 3, false, _arcPaint(SomiColors.ocean));
    canvas.drawArc(rect, pi, pi / 4, false, _arcPaint(SomiColors.green));
    canvas.drawArc(rect, pi * 5 / 4, pi / 2, false, _arcPaint(SomiColors.red));
    canvas.drawArc(
        rect, pi * 7 / 4, pi / 2, false, _arcPaint(SomiColors.purple));
  }

  Paint _arcPaint(Color color) {
    return Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
