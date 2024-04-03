import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';

class PhotoZoom extends ConsumerStatefulWidget {
  final String url;
  final String name;
  PhotoZoom({required this.name, required this.url, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PhotoZoom();
  }
}

class _PhotoZoom extends ConsumerState<PhotoZoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: PhotoView(imageProvider: NetworkImage(widget.url)));
  }
}
