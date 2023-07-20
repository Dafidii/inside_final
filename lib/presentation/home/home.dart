import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inside_1/app/di.dart';
import 'package:inside_1/domain/model/model.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer.dart';
import 'package:inside_1/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:inside_1/presentation/home/home_view_model.dart';
import 'package:inside_1/presentation/resources/color_manager.dart';
import 'package:inside_1/presentation/resources/font_manager.dart';
import 'package:inside_1/presentation/resources/route_manager.dart';
import 'package:inside_1/presentation/resources/value_manager.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => instance<HomeViewModel>(),
      child: Consumer<HomeViewModel>(
        builder: (BuildContext context, homeViewModel, Widget? child) {
          UsersInfo? userInfoData = Provider.of<UsersInfo?>(context);
          return homeViewModel.currentState.getScreenWidget(
            context,
            Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: AppSize.s20,
                            ),
                            Text(
                              'Hi ${userInfoData?.username},',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(
                              height: AppSize.s36,
                            ),
                            StreamBuilder<List<Exhibition>>(
                              stream: homeViewModel.exhibitionsStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Exhibition>> snapshot) {
                                if (snapshot.hasError) {
                                  homeViewModel.currentState.showBanner(
                                      StateRendererType.bannerErrorState,
                                      "An error occurred");
                                  return const Center(
                                    child: SizedBox(
                                      width: AppSize.s40,
                                      height: AppSize.s40,
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else if (snapshot.data?.isNotEmpty ?? false) {
                                  return Wrap(
                                    spacing: 4,
                                    children: snapshot.data
                                            ?.map((e) =>
                                                ExhibitionCard(exhibition: e))
                                            .toList() ??
                                        [],
                                  );
                                } else {
                                  return const Center(
                                    child: SizedBox(
                                      width: AppSize.s40,
                                      height: AppSize.s40,
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ExhibitionCard extends StatelessWidget {
  const ExhibitionCard({
    super.key,
    required this.exhibition,
  });

  final Exhibition exhibition;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(AppRadius.r5),
      child: InkWell(
        onTap: (){
          GoRouter.of(context).goNamed(AppPageRouteName.exhibitionScreen, extra: exhibition);
        },
        child: SizedBox(
          height: AppSize.s250,
          width: ((MediaQuery.of(context).size.width - 36)/2).floorToDouble(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(AppRadius.r5),
                child: CachedNetworkImage(
                  imageUrl: exhibition.image,
                  width: ((MediaQuery.of(context).size.width - 36)/2).floorToDouble(),
                  height: AppSize.s166,
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
                height: AppSize.s8,
              ),
              Text(
                exhibition.title,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontFamily: FontConstant.fontFamily2,
                      color: ColorManager.secondaryTextColor,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
