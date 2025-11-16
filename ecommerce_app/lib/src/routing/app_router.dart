import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/presentation/account/account_screen.dart';
import '../features/checkout/presentation/checkout_screen/checkout_screen.dart';
import '../features/review/presentation/leave_review_page/leave_review_screen.dart';
import 'not_found_screen.dart';
import '../features/orders/presentation/order_list/orders_list_screen.dart';
import '../features/products/presentation/product_screen/product_screen.dart';
import '../features/products/presentation/products_list/products_list_screen.dart';
import '../features/cart/presentation/shopping_cart/shopping_cart_screen.dart';
import '../features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import '../features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

enum AppRoute {
  home,
  product,
  review,
  cart,
  checkout,
  orders,
  account,
  signIn,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
          path: 'product/:id',
          name: AppRoute.product.name,
          builder: (context, state) =>
              ProductScreen(productId: state.pathParameters['id']!),
          routes: [
            GoRoute(
              path: 'review',
              name: AppRoute.review.name,
              pageBuilder: (context, state) => MaterialPage(
                fullscreenDialog: true,
                child: LeaveReviewScreen(
                  productId: state.pathParameters['id']!,
                ),
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'cart',
          name: AppRoute.cart.name,
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            child: const ShoppingCartScreen(),
          ),
          routes: [
            GoRoute(
              path: 'checkout',
              name: AppRoute.checkout.name,
              pageBuilder: (context, state) => MaterialPage(
                fullscreenDialog: true,
                child: const CheckoutScreen(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'orders',
          name: AppRoute.orders.name,
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            child: const OrdersListScreen(),
          ),
        ),
        GoRoute(
          path: 'account',
          name: AppRoute.account.name,
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            child: const AccountScreen(),
          ),
        ),
        GoRoute(
          path: 'signIn',
          name: AppRoute.signIn.name,
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            child: const EmailPasswordSignInScreen(
              formType: EmailPasswordSignInFormType.signIn,
            ),
          ),
        ),
      ],
    ),
  ],
  //! GoRouter has its own error handling page, but we built our own to
  //! provide an error builder to handle errors.
  errorBuilder: (context, state) => const NotFoundScreen(),
);
