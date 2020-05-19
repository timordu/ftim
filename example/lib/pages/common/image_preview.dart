import 'package:flutter/material.dart';
import 'package:ftim_example/export.dart';

class ImagePreviewPage extends StatefulWidget {
  ImagePreviewPage(this.imageElem);

  final TimImageElem imageElem;

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  TimImage currentImage;

  @override
  void initState() {
    super.initState();
    currentImage = widget.imageElem.imageList.firstWhere((element) => element.type == 'Thumb');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Center(
        child: CachedNetworkImage(
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return CircularProgressIndicator(value: downloadProgress.progress);
          },
          imageUrl: currentImage?.url,
        ),
      ),

    ]);
  }
}
