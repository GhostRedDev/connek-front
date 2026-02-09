import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/search_result_google_widget.dart';

class SearchPage extends StatelessWidget {
  final String? prompt;

  const SearchPage({super.key, this.prompt});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor, // bg1Sec
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding:
                EdgeInsets.zero, // Top padding handled by internal widget now
            child: SearchResultGoogleWidget(
              autofocus:
                  (GoRouterState.of(context).extra as Map?)?['autofocus'] ??
                  false,
            ),
          ),
        ),
      ),
    );
  }
}
