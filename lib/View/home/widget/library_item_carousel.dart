import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/View/home/widget/library_card_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LibraryItemCarousel extends StatelessWidget {
  const LibraryItemCarousel({
    super.key,
    required this.items,
    this.showProgress = false,
  });

  final List<LibraryItem> items;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
          // aspectRatio: 1.8,
          enlargeCenterPage: false,
          viewportFraction: 1,
          enableInfiniteScroll: false),
      itemCount: (items.length / 2).round(),
      itemBuilder: (context, index, realIdx) {
        final int first = index * 2;
        final int second = first + 1;
        return Row(
          children: [first, second].map((idx) {
            LibraryItem currentItem = items[idx];
            return Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: LibraryItemCard(
                      item: currentItem, showProgress: showProgress),
                ));
          }).toList(),
        );
      },
    );
  }
}


