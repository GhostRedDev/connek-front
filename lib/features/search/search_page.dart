import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'widgets/search_result_google_widget.dart';

class SearchPage extends StatefulWidget {
  final String? prompt;

  const SearchPage({super.key, this.prompt});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _currentPrompt = '';

  void _performSearch(String query) {
    setState(() {
      _currentPrompt = query;
    });
    // In a real app, this would trigger an API call or filter a list
    print('Searching for: $_currentPrompt');
  }

  @override
  void initState() {
    super.initState();
    if (widget.prompt != null) {
      _currentPrompt = widget.prompt!;
    }

    // Simulating "normalSearch" action block
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Logic to trigger initial search if prompt exists
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1D21), // bg1Sec
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 120), // Top padding for Glass AppBar, bottom handled by widget
            child: const SearchResultGoogleWidget(),
          ),
        ),
      ),
    );
  }
}
