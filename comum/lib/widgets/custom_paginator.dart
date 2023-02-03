import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../custom_widgets.dart';
import '../utilities/utilities.dart';

class CustomPaginator extends StatelessWidget {
  const CustomPaginator({
    super.key,
    required this.page,
    required this.maxpage,
    required this.nextPage,
    required this.lastPage,
    required this.firstPage,
    required this.backPage,
  });

  final int page;
  final int maxpage;
  final void Function() nextPage;
  final void Function() lastPage;
  final void Function() firstPage;
  final void Function() backPage;

  @override
  Widget build(BuildContext context) => Padding(
        padding: kIsWeb
            ? const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
            : const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              spacing: 10,
              children: [
                RoundButton(
                  text: '',
                  icon: const Icon(Icons.first_page_rounded, size: 30),
                  color: getColors(context).primary,
                  fontsize: 12,
                  width: MediaQuery.of(context).size.width * 0.15,
                  onPressed: (page == 0 ? null : firstPage),
                ),
                RoundButton(
                  text: (MediaQuery.of(context).orientation ==
                          Orientation.portrait
                      ? ''
                      : 'Anterior'),
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 30),
                  color: getColors(context).primary,
                  fontsize: 12,
                  width: MediaQuery.of(context).size.width * 0.15,
                  onPressed: (page == 0 ? null : backPage),
                ),
              ],
            ),
            Text(
              'Página ${page + 1}/$maxpage',
              textAlign: TextAlign.center,
              style: getStyles(context).labelMedium!.copyWith(
                    color: getColors(context).primary,
                  ),
            ),
            Wrap(
              spacing: 10,
              children: [
                RoundButton(
                  text:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? ''
                          : 'Próxima',
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 30),
                  color: getColors(context).primary,
                  fontsize: 12,
                  width: MediaQuery.of(context).size.width * 0.15,
                  onPressed: page == maxpage - 1 ? null : nextPage,
                ),
                RoundButton(
                  text: '',
                  icon: const Icon(Icons.last_page_rounded, size: 30),
                  color: getColors(context).primary,
                  fontsize: 12,
                  width: MediaQuery.of(context).size.width * 0.15,
                  onPressed: page == maxpage - 1 ? null : lastPage,
                ),
              ],
            ),
          ],
        ),
      );
}
