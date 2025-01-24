import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase({dynamic splitPattern = ' '}) =>
      replaceAll(RegExp(' +'), ' ')
          .split(splitPattern)
          .map((str) => str.toCapitalized())
          .join(splitPattern == ' ' ? ' ' : splitPattern + ' ');

  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension RandomListItem<T> on List<T> {
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}

extension ExtensionNum on num {
  String get twoDigits => toString().padLeft(2, "0");
}

extension ExtensionDuration on Duration {
  String get humanizeNoSeconds =>
      "${inDays > 0 ? '${inDays}d ' : ''}${inHours.remainder(24)}h:${inMinutes.remainder(60)}m";
  String get humanizeWithSeconds =>
      "${inDays > 0 ? '${inDays}d ' : ''}${inHours.remainder(24).twoDigits}h:${inMinutes.remainder(60).twoDigits}m:${inSeconds.remainder(60).twoDigits}s";
}

/* extension ToBitDescription on Widget {
  Future<BitmapDescriptor> toBitmapDescriptor(
      {Size? logicalSize,
      Size? imageSize,
      Duration waitToRender = const Duration(milliseconds: 300),
      TextDirection textDirection = TextDirection.ltr}) async {
    final widget = RepaintBoundary(
      child: MediaQuery(
          data: const MediaQueryData(),
          child: Directionality(textDirection: TextDirection.ltr, child: this)),
    );
    final pngBytes = await createImageFromWidget(widget,
        waitToRender: waitToRender,
        logicalSize: logicalSize,
        imageSize: imageSize);
    return BitmapDescriptor.fromBytes(pngBytes);
  }
} */

/// Creates an image from the given widget by first spinning up a element and render tree,
/// wait [waitToRender] to render the widget that take time like network and asset images

/// The final image will be of size [imageSize] and the the widget will be layout, ... with the given [logicalSize].
/// By default Value of  [imageSize] and [logicalSize] will be calculate from the app main window

Future<Uint8List> createImageFromWidget(Widget widget,
    {Size? logicalSize,
    required Duration waitToRender,
    Size? imageSize}) async {
  final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
  final view = ui.PlatformDispatcher.instance.views.first;
  logicalSize ??= view.physicalSize / view.devicePixelRatio;
  imageSize ??= view.physicalSize;

  // assert(logicalSize.aspectRatio == imageSize.aspectRatio);

  final RenderView renderView = RenderView(
    view: view,
    child: RenderPositionedBox(
        alignment: Alignment.center, child: repaintBoundary),
    configuration: ViewConfiguration(
      physicalConstraints: BoxConstraints(
          maxWidth: logicalSize.width, maxHeight: logicalSize.height),
      logicalConstraints: BoxConstraints(
          maxWidth: logicalSize.width, maxHeight: logicalSize.height),
      devicePixelRatio: 1.0,
    ),
  );

  final PipelineOwner pipelineOwner = PipelineOwner();
  final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());

  pipelineOwner.rootNode = renderView;
  renderView.prepareInitialFrame();

  final RenderObjectToWidgetElement<RenderBox> rootElement =
      RenderObjectToWidgetAdapter<RenderBox>(
    container: repaintBoundary,
    child: widget,
  ).attachToRenderTree(buildOwner);

  buildOwner.buildScope(rootElement);

  await Future.delayed(waitToRender);

  buildOwner.buildScope(rootElement);
  buildOwner.finalizeTree();

  pipelineOwner.flushLayout();
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();

  final ui.Image image = await repaintBoundary.toImage(
      pixelRatio: imageSize.width / logicalSize.width);
  final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

  return byteData!.buffer.asUint8List();
}
