import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uae_user/constants/constant_methods.dart';
import 'package:uae_user/constants/enums.dart';
import 'package:uae_user/presentation/views/adding_product_to_cart_counter_item.dart';
import 'package:uae_user/presentation/widgets/default_cached_network_image.dart';

import '../../../../business_logic/user/add_to_cart/add_to_cart_cubit.dart';
import '../../../../business_logic/user/change_favorite/favorite_change_cubit.dart';
import '../../../../business_logic/user/get_products/get_products_cubit.dart';
import '../../../../constants/screens.dart';
import '../../../styles/colors.dart';
import '../../../widgets/DefaultSvg.dart';
import '../../../widgets/default_error_widget.dart';
import '../../../widgets/default_loading_indicator.dart';
import '../../../widgets/default_material_button.dart';
import '../../../widgets/default_text.dart';

class AddingProductToCartScreen extends StatefulWidget {
  final int productId;

  const AddingProductToCartScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<AddingProductToCartScreen> createState() =>
      _AddingProductToCartScreenState();
}

late GetProductsCubit _getProductsCubit;

class _AddingProductToCartScreenState extends State<AddingProductToCartScreen> {
  bool favClicked = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [

          BlocProvider(
            create: (context) => GetProductsCubit()
              ..userGetProducts(productId: widget.productId),
          ),
        ],
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.lightBlue,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HOME_LAYOUT_R,
                      (route) => false,
                );
              },
            ),
          ),
          backgroundColor: AppColors.lightBlue,
          body: BlocBuilder<GetProductsCubit, GetProductsState>(
            builder: (context, state) {
              _getProductsCubit = GetProductsCubit.get(context);

              if (state is UserGetProductsSuccessState) {
                return ListView(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 300,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              )),
                          child: Center(
                              child: DefaultCachedNetworkImage(
                                  imageUrl: _getProductsCubit.getProductsModel
                                          .product.images.isEmpty
                                      ? ''
                                      : _getProductsCubit
                                          .getProductsModel.product.images[0],
                                  fit: BoxFit.contain)),
                        ),
                        Positioned(
                          top: 20.0,
                          right: 20.0,
                          child: BlocListener<ChangeFavoriteCubit,
                              ChangeFavoriteStates>(
                            listener: (context, state) {
                              if (state is FavoriteChangeSuccessState) {
                                favClicked = false;
                                if (_getProductsCubit
                                        .getProductsModel.product.id ==
                                    state.productId) {
                                  setState(() {
                                    printTest(  _getProductsCubit
                                        .getProductsModel.product.isFav.toString());
                                    _getProductsCubit
                                            .getProductsModel.product.setIsFav =
                                        !_getProductsCubit
                                            .getProductsModel.product.isFav;
                                  });
                                }
                              } else if (state is FavoriteChangeErrorState) {
                                favClicked = false;
                              }
                            },
                            child: InkWell(
                              onTap: () {
                                if (!favClicked) {
                                  favClicked = true;
                                  ChangeFavoriteCubit.get(context)
                                      .changeFavorite(
                                    productId: _getProductsCubit
                                        .getProductsModel.product.id,
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.lightBlue),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _getProductsCubit
                                              .getProductsModel.product.isFav ==
                                          false
                                      ? const Icon(
                                          Icons.favorite_outline,
                                          color: AppColors.grey,
                                        )
                                      : const Icon(
                                          Icons.favorite,
                                          color: AppColors.red,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 12.0, top: 10.0, end: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultText(
                                    maxLines: 4,
                                    text: _getProductsCubit
                                        .getProductsModel.product.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Bukra-Regular'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: DefaultText(
                                      text: _getProductsCubit
                                          .getProductsModel.product.description,
                                      maxLines: 4,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(
                                            color: Colors.white70,
                                          ),
                                    ),
                                  ),
                                  DefaultText(
                                    text:
                                        '${_getProductsCubit.getProductsModel.product.price.toStringAsFixed(2)} ${AppLocalizations.of(context)!.appCurrency}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 12.0),
                              child: AddingProductToCartCounterItem(
                                  getProductsModel: _getProductsCubit
                                      .getProductsModel.product),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Builder(builder: (context) {
                                    AddToCartCubit _cartCubit =
                                        AddToCartCubit.get(context);
                                    return BlocListener<AddToCartCubit,
                                        AddToCartState>(
                                      listener: (context, state) {
                                        if (state is UserAddCartSuccessStates) {
                                          showToastMsg(
                                              msg: AppLocalizations.of(context)!.addedSuccessfully,
                                              toastState: ToastStates.SUCCESS);
                                        }else{
                                          showToastMsg(
                                              msg: AppLocalizations.of(context)!.notAvailable,
                                              toastState: ToastStates.WARNING);
                                        }
                                      },
                                      child: DefaultMaterialButton(
                                        text: AppLocalizations.of(context)!
                                            .addToCart,
                                        onTap: () {
                                          _cartCubit.userAddToCart(
                                              productId: widget.productId);
                                        },
                                        height: 50,
                                        width: 260,
                                        color: Colors.white,
                                        textColor: AppColors.lightBlue,
                                      ),
                                    );
                                  })
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else if (state is UserGetProductsLoadingState) {
                return const DefaultLoadingIndicator(color: Colors.white,);
              } else if (state is UserGetProductsEmptyState) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const DefaultSvg(
                        imagePath: 'assets/icons/no_search_data.svg',
                        color: AppColors.lightBlue2,
                      ),
                      DefaultText(
                        text: AppLocalizations.of(context)!.noResultsFound,
                        textStyle: Theme.of(context).textTheme.headline6,
                      )
                    ],
                  ),
                );
              } else {
                return const DefaultErrorWidget();
              }
            },
          ),
        )));
  }
}
