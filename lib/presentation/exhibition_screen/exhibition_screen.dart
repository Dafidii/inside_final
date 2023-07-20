import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:inside_1/domain/model/model.dart';
import 'package:inside_1/presentation/resources/assets_manager.dart';
import 'package:inside_1/presentation/resources/color_manager.dart';
import 'package:inside_1/presentation/resources/route_manager.dart';
import 'package:inside_1/presentation/resources/value_manager.dart';

class ExhibitionScreen extends StatelessWidget {
  const ExhibitionScreen({super.key, required this.exhibition});

  final Exhibition exhibition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.zero,
          child: SizedBox(
            height: double.infinity,
          )),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    IconButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      icon: SvgPicture.asset(
                        IconsAsset.arrowLeft,
                        colorFilter: ColorFilter.mode(
                          ColorManager.secondary,
                          BlendMode.srcIn,
                        ),
                        width: AppSize.s32,
                        height: AppSize.s32,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(
                      height: AppSize.s24,
                    ),
                    Text(
                      exhibition.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: ColorManager.secondaryTextColor),
                    ),
                    const SizedBox(
                      height: AppSize.s24,
                    ),
                    Material(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(AppRadius.r5),
                      child: CachedNetworkImage(
                        imageUrl: exhibition.image,
                        width: ((MediaQuery.of(context).size.width - 32) / 2)
                            .floorToDouble(),
                        height: AppSize.s250,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            width: AppSize.s40,
                            height: AppSize.s40,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s16,
                    ),
                    Flexible(
                      child: Text(
                        exhibition.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s24,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed(AppPageRouteName.paymentPage);
                      },
                      child: const Text('Book a visit'),
                    ),
                    const SizedBox(
                      height: AppSize.s40,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
