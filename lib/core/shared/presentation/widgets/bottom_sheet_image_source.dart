import 'package:flutter/material.dart';

import '../../../statics/statics.dart';
import 'rounded_container.dart';

class BottomSheetImageSource extends StatelessWidget {
  final Function selectCamera;
  final Function selectGallery;
  const BottomSheetImageSource({Key? key, required this.selectCamera, required this.selectGallery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.small),
      color: AppColors.bgGrey,
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.small),
            child: InkWell(
              onTap: () => selectCamera(),
              child: RoundedContainer(
                height: null,
                child: ListTile(
                  dense: true,
                  leading: Image.asset(
                    AppAssets.camera,
                    fit: BoxFit.fitHeight,
                    height: 22.0,
                  ),
                  title: Text('Kamera', style: context.textTheme().titleSmall),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.small),
            child: InkWell(
              onTap: () => selectGallery(),
              child: RoundedContainer(
                height: null,
                child: ListTile(
                  dense: true,
                  leading: Image.asset(
                    AppAssets.gallery,
                    fit: BoxFit.fitHeight,
                    height: 22.0,
                  ),
                  title: Text('Galeri', style: context.textTheme().titleSmall),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
