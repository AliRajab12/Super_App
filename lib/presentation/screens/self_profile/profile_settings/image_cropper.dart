import 'dart:io';
import 'dart:typed_data';

import 'package:cropperx/cropperx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageCropper extends StatefulWidget {
  final File source;

  const ImageCropper({super.key, required this.source});

  @override
  State<ImageCropper> createState() => _ImageCropperState();
}

class _ImageCropperState extends State<ImageCropper> {
  final GlobalKey _cropperKey = GlobalKey();

  int _rotationTurns = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            OrientationBuilder(builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return buildVertical();
              } else {
                return buildHorizontal();
              }
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CloseButton(
                  onPressed: () => Navigator.of(context).maybePop()),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVertical() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Center(child: buildInstructions()),
          ),
          Flexible(flex: 3, child: buildCropper()),
          const SizedBox(height: 36),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: buildDoneButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHorizontal() {
    return Padding(
      padding: const EdgeInsets.only(left: 28),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 4, child: buildCropper()),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildInstructions(),
                  const SizedBox(height: 36),
                  buildDoneButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCropper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.filledTonal(
          onPressed: () => setState(() => _rotationTurns--),
          icon: const Icon(
            Icons.rotate_left,
            color: Colors.black,
          ),
          tooltip: AppLocalizations.of(context)!.rotateLeft,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 280,
              maxHeight: 280,
            ),
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipOval(
                  child: Cropper(
                    cropperKey: _cropperKey,
                    image: Image.file(widget.source),
                    rotationTurns: _rotationTurns,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton.filledTonal(
          onPressed: () => setState(() => _rotationTurns++),
          icon: const Icon(
            Icons.rotate_right,
            color: Colors.black,
          ),
          tooltip: AppLocalizations.of(context)!.rotateRight,
        ),
      ],
    );
  }

  Widget buildInstructions() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.cropImageTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(AppLocalizations.of(context)!.cropImageMessage,
            textAlign: TextAlign.center),
      ],
    );
  }

  Widget buildDoneButton() {
    return FilledButton.icon(
      onPressed: () => _performCrop(context),
      label: Text(AppLocalizations.of(context)!.done),
      icon: const Icon(Icons.check, size: 16),
    );
  }

  void _performCrop(BuildContext context) async {
    double pixelRatio = 1.0;
    final renderBox =
        _cropperKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) pixelRatio = 256 / renderBox.size.width;
    final Uint8List? imageBytes =
        await Cropper.crop(cropperKey: _cropperKey, pixelRatio: pixelRatio);
    if (!mounted) return;
    Navigator.pop(context, imageBytes);
  }
}
