import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uae_user/business_logic/user/ads/ads_cubit.dart';
import 'package:uae_user/business_logic/user/category/category_cubit.dart';
import 'package:uae_user/business_logic/user/get_offers/get_offers_cubit.dart';
import 'package:uae_user/presentation/screens/user_screens/search/search_screen.dart';
import 'package:uae_user/presentation/styles/colors.dart';
import 'package:uae_user/presentation/views/custome_carousel_slider.dart';
import 'package:uae_user/presentation/views/home_grid_view_item.dart';
import 'package:uae_user/presentation/views/home_offers_card_item.dart';
import 'package:uae_user/presentation/widgets/custome_search_field.dart';
import 'package:uae_user/presentation/widgets/default_error_widget.dart';
import 'package:uae_user/presentation/widgets/default_text.dart';
import '../../../../business_logic/user/cart/get_my_cart/get_my_cart_cubit.dart';
import '../../../../constants/constant_methods.dart';
import '../../../../constants/screens.dart';
import '../../../widgets/DefaultSvg.dart';
import '../../../widgets/default_loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (context) => GetMyCartCubit()..userGetCart(),
        ),

      ],
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.lightBlue,
            leading: IconButton(
              icon: Image.asset('assets/images/bell1.png'),
              onPressed: () {
                Navigator.pushNamed(context, NOTIFICATIONS_SCREEN_R);
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultText(text: AppLocalizations.of(context)!.home),
              ],
            ),
            actions: [
              IconButton(
                icon: Stack(
                  alignment: Alignment.topRight,
                  children:  [
                    const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.lightGreenAccent,
                      radius: 5.0,
                      child: Center(
                        child: BlocBuilder<GetMyCartCubit, GetMyCartState>(
                          builder: (context, state) {
                            GetMyCartCubit getMyCartCubit = GetMyCartCubit.get(context);
                          if (state is UserGetCartSuccessState) {
                            return Text(
                              '${getMyCartCubit.getMyCartModel.carts.length}',
                              style: const TextStyle(fontSize: 8),
                            );
                          }else{
                            return Text(
                              '${getMyCartCubit.getMyCartModel.carts.length}',
                              style: const TextStyle(fontSize: 8),
                            );
                          }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, CART_SCREEN_R);
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                color: AppColors.lightBlue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DefaultText(
                            text:
                                '${AppLocalizations.of(context)!.welcome}',
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: AppColors.lightGrey,
                                    ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: SizedBox(
                                height: 35,
                                width: 300,
                                child: Form(
                                  key: searchFormKey,
                                  child: CustomeSearchField(
                                    keyboardType: TextInputType.text,
                                    prefixIcon: IconButton(
                                      icon: Image.asset(
                                          'assets/images/search.png'),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, SEARCH_SCREEN_R);
                                      },
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Image.asset(
                                          'assets/images/barcode.png'),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, BAR_CODE_SCREEN_R);
                                      },
                                    ),
                                    controller: _searchController,
                                    validator: (text) {
                                      if (text!.isEmpty) {
                                        return 'البحث فارغ';
                                      }
                                      return '';
                                    },
                                    onFieldSubmitted: (text) {
                                      if (searchFormKey.currentState!
                                          .validate()) {
                                        navigateTo(context,
                                            SearchScreen(searchText: text));
                                      }
                                    },
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: RawScrollbar(
                  thumbColor: AppColors.lightBlue,
                  radius: const Radius.circular(20),
                  thickness: 7,
                  isAlwaysShown: true,
                  interactive: true,
                  controller: scrollController,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        BlocBuilder<AdsCubit, AdsStates>(
                          builder: (context, state) {
                            if (state is UserAdsSuccessState) {
                              return CustomCarouselSlider(userAds: state.ads);
                            } else if (state is UserNoAdsState) {
                              return const SizedBox(
                                height: 15.0,
                              );
                            } else if (state is UserAdsLoadingState) {
                              return const DefaultLoadingIndicator();
                            } else {
                              return const DefaultErrorWidget();
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DefaultText(
                                text: AppLocalizations.of(context)!.offers,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                      fontFamily: 'Bukra-Regular',
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, OFFERS_SCREEN_R);
                                },
                                child: DefaultText(
                                  text: AppLocalizations.of(context)!.all,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        color: AppColors.lightBlue,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<GetOffersCubit, GetOffersState>(
                          builder: (context, state) {
                            if (state is UserGetOffersSuccessState) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      state.offers.length,
                                      (index) => HomeOffersCardItem(offer:state.offers[index],productId:state.offers[index].product.id),
                                    ),
                                  ),
                                ),
                              );
                            } else if (state is UserGetOffersLoadingState) {
                              return const DefaultLoadingIndicator();
                            } else if (state is UserGetOffersEmptyState) {
                              return Center(
                                child: Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const DefaultSvg(
                                        imagePath: 'assets/icons/no_search_data.svg',
                                        color: AppColors.lightBlue2,
                                      ),
                                      DefaultText(
                                        text: AppLocalizations.of(context)!.noResultsFound,
                                        style: const TextStyle(color: Colors.white),
                                        textStyle: Theme.of(context).textTheme.headline6,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const DefaultErrorWidget();
                            }
                          },
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 15, top: 10, bottom: 25),
                              child: DefaultText(
                                text: AppLocalizations.of(context)!.categories,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                      fontFamily: 'Bukra-Regular',
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        BlocBuilder<CategoryCubit, CategoryStates>(
                          builder: (context, state) {
                            if (state is UserCategorySuccessState) {
                              return
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 20,
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 20,
                                          mainAxisExtent: 150),
                                  itemCount: state.userCategories.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return HomeGridViewItem(
                                      homeGridViewItemText:
                                          state.userCategories[index].name,
                                      homeGridViewItemImgageUrl:
                                          state.userCategories[index].image,
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          CATEGORIES_SCREEN_R,
                                          arguments:
                                              state.userCategories[index].id,
                                        );
                                      },
                                    );
                                  });
                            } else if (state is UserCategoryLoadingState) {
                              return const DefaultLoadingIndicator();
                            } else {
                              return const DefaultErrorWidget();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
