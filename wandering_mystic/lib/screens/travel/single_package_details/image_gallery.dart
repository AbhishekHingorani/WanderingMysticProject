import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageGallery extends StatefulWidget {
  final ImageProvider image1;
  final ImageProvider image2;
  final ImageProvider image3;
  final ImageProvider image4;
  final Widget loadingChild;
  final Color backgroundColor;
  final dynamic minScale;
  final dynamic maxScale;
  final int index;
  final PageController pageController;

  ImageGallery({
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.loadingChild,
    this.backgroundColor,
    this.minScale,
    this.maxScale,
    this.index,
  }) : this.pageController = PageController(initialPage: index);

  @override
  State<StatefulWidget> createState() {
    return _ImageGalleryState();
  }
}

class _ImageGalleryState extends State<ImageGallery> {
  int currentIndex;
  @override
  void initState() {
    currentIndex = widget.index;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              PhotoViewGallery(
                pageOptions: <PhotoViewGalleryPageOptions>[
                  PhotoViewGalleryPageOptions(
                    imageProvider: widget.image1,
                    heroTag: "tag1",
                  ),
                  PhotoViewGalleryPageOptions(
                    imageProvider: widget.image2,
                    heroTag: "tag2",
                  ),
                  PhotoViewGalleryPageOptions(
                    imageProvider: widget.image3,
                    heroTag: "tag3",
                  ),
                  PhotoViewGalleryPageOptions(
                    imageProvider: widget.image4,
                    heroTag: "tag4",
                  ),
                ],
                loadingChild: widget.loadingChild,
                backgroundColor: widget.backgroundColor,
                pageController: widget.pageController,
                onPageChanged: onPageChanged,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Image ${currentIndex + 1}",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 17.0, decoration: null),
                ),
              )
            ],
          )),
    );
  }
}