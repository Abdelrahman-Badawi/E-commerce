import 'package:flutter/material.dart';

class HeaderOfList extends StatelessWidget {
  const HeaderOfList({
    super.key,
    required this.title,
    required this.descraption,
    this.onTap,
  });

  final String title;
  final String descraption;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            InkWell(
              onTap: onTap,
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        Text(
          descraption,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }
}
