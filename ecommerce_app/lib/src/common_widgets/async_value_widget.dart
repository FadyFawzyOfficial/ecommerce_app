import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AsyncValue, AsyncValueExtensions;

import 'error_message_widget.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T) data;

  const AsyncValueWidget({
    super.key,
    required this.asyncValue,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: data,
      error: (error, stackTrace) => Center(child: ErrorMessageWidget('$error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
