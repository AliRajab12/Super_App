import 'package:somi/core/models/input.dart';
import 'package:somi/core/repos/auth_data_repo.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/utils/device_utils.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card.dart';
import 'package:somi/core/widgets/dg_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ThumbnailSize {
  final Map<String, Size> sizes;
  final Size fallback;

  ThumbnailSize({required this.sizes, required this.fallback});

  ThumbnailSize.large()
      : sizes = {
          'book': const Size(-1, 128),
          'episode': const Size(-1, 128),
        },
        fallback = const Size(303, 170);

  ThumbnailSize.small()
      : sizes = {
          'book': const Size(155, 96),
          'episode': const Size(155, 96),
        },
        fallback = const Size(228, 128);
}

class InputThumbnail extends StatelessWidget {
  final Input input;
  final ThumbnailSize? thumbnailSize;
  final Widget Function(Widget child)? wrapper;
  final bool cardThumbnail;

  const InputThumbnail(this.input,
      {super.key, this.thumbnailSize, this.wrapper, this.cardThumbnail = true});

  static const fallbackPatternTypes = [
    'article',
    'video',
    'course',
    'book',
    'episode',
    'task',
    'event',
    'assessment',
    'position',
    'post',
  ];

  @override
  Widget build(BuildContext context) {
    String? imageUrl = input.imageUrl ?? input.reference?.imageUrl;
    String? type = (input.inputType ??
            input.referenceType ??
            input.reference?.type?.name ??
            '')
        .toLowerCase();

    // Fall back to provider image URLs first
    imageUrl ??= input.reference?.providerImageInfo['svg'] ??
        input.reference?.providerImageInfo['png'];

    if (imageUrl != null) {
      // Prepend blob base url if necessary
      if (imageUrl.startsWith(RegExp(r'~?/'))) {
        imageUrl = locator<AuthDataRepo>().blobBaseUrl +
            imageUrl.replaceFirst('~/', '/');
      } else if (!imageUrl.contains('.svg')) {
        // Use image proxy
        final encoded = Uri.encodeComponent(imageUrl);

        ThumbnailSize size = thumbnailSize ??
            (DGCardConfig.of(context).format.isLarge
                ? ThumbnailSize.large()
                : ThumbnailSize.small());

        Size imageSize = size.sizes[type] ?? size.fallback;

        String transformations = {
          'w':
              imageSize.width == -1 ? 'auto' : imageSize.width.toInt(), // Width
          'h': imageSize.height == -1
              ? 'auto'
              : imageSize.height.toInt(), // Height
          'c': 'fill', // Crop
          'g': 'faces:center', // Gravity
          'f': _isAvifSupported ? 'avif' : 'webp',
          'q': 'auto', // Quality
          'dpr': 2.0, // Device Pixel Ratio
        }.entries.map((e) => '${e.key}_${e.value}').join(',');

        // 'pg_1' returns the first frame of animated images
        imageUrl =
            'https://img.degreed.com/image/fetch/pg_1/$transformations/$encoded';
      }
    }

    Widget image;
    if (imageUrl == null || imageUrl.contains('/dg-')) {
      // Use fallback image if the URL is null or points to a web fallback image
      image = fallbackImage();
    } else if (imageUrl.contains('.svg')) {
      image = Container(
        color: SomiColors.ebony3,
        child: FractionallySizedBox(
          widthFactor: 0.75,
          heightFactor: 0.75,
          child: SvgPicture.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (type == 'book' || type == 'episode') {
      image = DGNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 300),
        placeholder: (_, __) => _shadowboxPlaceholder(context, type),
        errorWidget: (_, __, ___) => _shadowboxPlaceholder(context, type),
      );
    } else {
      image = DGNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 300),
        placeholder: (_, __) => Container(color: AppColors.background),
        errorWidget: (_, __, ___) => fallbackImage(),
      );
    }

    if (type == 'video') {
      image = _addPlayIcon(image);
    }

    if (wrapper != null) {
      return wrapper!(image);
    }

    return cardThumbnail
        ? ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: image)
        : ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: image);
  }

  Widget _addPlayIcon(Widget child) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        Center(
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 2, top: 2),
              child: Icon(Icons.play_arrow),
            ),
          ),
        ),
      ],
    );
  }

  Widget fallbackImage() {
    String? type =
        (input.inputType ?? input.referenceType ?? input.reference?.type?.name)
            ?.toLowerCase();
    if (type == null) {
      return Container();
    }

    if (type == 'pathway' || type == 'target') {
      int imageId = ((input.inputId ?? 0) + 773) % 24;
      return SvgPicture.asset(
        'images/placeholders/content/abstract/dg-$imageId.svg',
        fit: BoxFit.cover,
      );
    } else if (fallbackPatternTypes.contains(type)) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFe9f5f3),
              Color(0xFFf6eee3),
              Color(0xFFf7e4ed),
            ],
          ),
        ),
        child: Image(
          image:
              Svg('images/placeholders/content/icon_patterns/$type-tile.svg'),
          color: SomiColors.ebony18,
          repeat: ImageRepeat.repeat,
          height: 176,
          width: 176,
          fit: BoxFit.none,
        ),
      );
    } else {
      return Container(color: AppColors.background);
    }
  }

  /// Returns whether the device supports AVIF image decoding. AVIF images are preferred due to a ~30% size advantage
  /// compared to WEBP, but while Flutter can directly decode WEBP images it currently falls back to native decoding
  /// for AVIF, which is only supported on recent OS versions (Android 12+, iOS 16+)
  bool get _isAvifSupported {
    // Check if DeviceUtils is registered first so we don't need to mock it in tests
    if (locator.isRegistered<DeviceUtils>()) {
      return locator<DeviceUtils>().supportsAvif;
    }
    return false;
  }

  Widget _shadowboxPlaceholder(BuildContext context, String inputType) {
    return AspectRatio(
      aspectRatio: inputType == 'book' ? 2 / 3 : 1,
      child: Icon(
        inputType == 'book' ? Icons.book : Icons.volume_up,
        size: 48,
        color: AppColors.grayLight,
      ),
    );
  }
}
