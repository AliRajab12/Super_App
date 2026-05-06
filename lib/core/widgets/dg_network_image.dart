import 'package:cached_network_image/cached_network_image.dart';
import 'package:somi/core/service_locator.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DGNetworkImage extends CachedNetworkImage {
  DGNetworkImage({
    super.key,
    required String? imageUrl,
    super.httpHeaders,
    super.imageBuilder,
    super.placeholder,
    super.progressIndicatorBuilder,
    super.errorWidget,
    super.fadeOutDuration,
    super.fadeOutCurve,
    super.fadeInDuration,
    super.fadeInCurve,
    super.width,
    super.height,
    super.fit,
    super.alignment,
    super.repeat,
    super.matchTextDirection,
    BaseCacheManager? cacheManager,
    super.useOldImageOnUrlChange,
    super.color,
    super.filterQuality,
    super.colorBlendMode,
    super.placeholderFadeInDuration,
    super.memCacheWidth,
    super.memCacheHeight,
    super.cacheKey,
    super.maxWidthDiskCache,
    super.maxHeightDiskCache,
  }) : super(
          imageUrl: imageUrl ?? '',
          cacheManager: cacheManager ??
              (locator.isRegistered<CacheManager>()
                  ? locator<CacheManager>()
                  : null),
        );
}

class DGNetworkImageProvider extends CachedNetworkImageProvider {
  DGNetworkImageProvider(
    String? url, {
    super.maxHeight,
    super.maxWidth,
    super.scale = 1.0,
    super.errorListener,
    super.headers,
    BaseCacheManager? cacheManager,
    super.cacheKey,
  }) : super(
          url ?? '',
          cacheManager: cacheManager ??
              (locator.isRegistered<CacheManager>()
                  ? locator<CacheManager>()
                  : null),
        );
}
