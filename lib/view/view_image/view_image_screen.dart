import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../core/styles/app_colors.dart';
import '../../core/values_manager.dart';



class ViewImageScreen extends StatefulWidget {
  final List<dynamic>? images;
  final int index;



  const ViewImageScreen({super.key,  this.images, required this.index,});

  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  _ViewImageScreenState();

  late PhotoViewController photoViewController;
  late PageController pageController;
  late int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    photoViewController = PhotoViewController();
    pageController = PageController(initialPage: widget.index);
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor:
          AppColors.backgroundColor,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PhotoViewGallery.builder(
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            reverse: true,
            scrollPhysics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            allowImplicitScrolling: true,
            loadingBuilder: (context, event) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryColor,
                  ), // Change color here
                ),
              );
            },
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                basePosition: Alignment.center,
                imageProvider: NetworkImage(widget.images?[index]),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained * 0.9,
                maxScale: PhotoViewComputedScale.contained * 2,
                controller: photoViewController,
              );
            },
            itemCount: widget.images?.length??0,
            pageController: pageController,
            backgroundDecoration: const BoxDecoration(),
          ),
          Positioned(
            bottom: AppHeight.p30,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: Text(
                  "${widget.images?.length}/${currentIndex + 1}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
