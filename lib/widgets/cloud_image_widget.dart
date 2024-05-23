import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class CloudImageWidget extends StatefulWidget {
  const CloudImageWidget(
      {super.key,
      required this.topicDir,
      required this.imageName,
      this.isFullScreen = false});

  final String topicDir;
  final String imageName;
  final bool isFullScreen;

  @override
  State<CloudImageWidget> createState() => _CloudImageWidgetState();
}

class _CloudImageWidgetState extends State<CloudImageWidget> {
  @override
  void initState() {
    super.initState();
  }

  Future<CachedNetworkImage> _loadImage() async {
    final url = await FirebaseStorage.instance
        .ref()
        .child('questions')
        .child(widget.topicDir)
        .child('images')
        .child('/${widget.imageName}')
        .getDownloadURL();

    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => widget.isFullScreen
          ? InstaImageViewer(
              backgroundColor: Theme.of(context).colorScheme.background,
              backgroundIsTransparent: true,
              child: Image(
                image: imageProvider,
              ),
            )
          : Image(image: imageProvider),
      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => Column(
        children: [
          Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
          ),
          Text(error.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadImage(),
      builder: (BuildContext context, AsyncSnapshot<Widget> image) {
        if (image.hasData) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(8), child: image.data!);
        } else {
          return _getLoad();
        }
      },
    );
  }

  Widget _getLoad() => const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      );
}
