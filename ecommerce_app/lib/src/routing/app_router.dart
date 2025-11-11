import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/products_list/products_list_screen.dart';
import '../features/shopping_cart/shopping_cart_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
          path: 'cart',
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            child: ShoppingCartScreen(),
          ),
        ),
      ],
    ),
  ],
);
