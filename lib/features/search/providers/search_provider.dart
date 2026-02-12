import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/business_model.dart';
import '../repositories/search_repository.dart';
import '../../settings/providers/profile_provider.dart';

// State class for Search
class SearchState {
  final bool isLoading;
  final List<Business> results;
  final String? error;
  final String query;

  SearchState({
    this.isLoading = false,
    this.results = const [],
    this.error,
    this.query = '',
  });

  SearchState copyWith({
    bool? isLoading,
    List<Business>? results,
    String? error,
    String? query,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
      error: error ?? this.error,
      query: query ?? this.query,
    );
  }
}

// Notifier class using Riverpod 2.0 Notifier
class SearchNotifier extends Notifier<SearchState> {
  Timer? _debounceTimer;

  @override
  SearchState build() {
    // Clean up timer when provider is destroyed
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    return SearchState();
  }

  void onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    state = state.copyWith(query: query);

    // Check for minimum length (e.g. 3 characters) to avoid "Prompt too short" error
    if (query.trim().length < 3) {
      state = state.copyWith(results: [], isLoading: false, error: null);
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    state = state.copyWith(isLoading: true, error: null);

    // In Notifier, we can read other providers using ref.read
    final repository = ref.read(searchRepositoryProvider);
    final profileState = ref.read(profileProvider);
    final clientId = profileState.value?.id;

    try {
      final response = await repository.search(query, clientId: clientId);

      // If results are empty and there is a message, treat it as an error to display in UI
      String? displayError;
      if (response.results.isEmpty && response.message != null) {
        displayError = response.message;
      }

      state = state.copyWith(
        isLoading: false,
        results: response.results,
        error: displayError,
      );
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      state = state.copyWith(isLoading: false, error: errorMessage);
    }
  }
}

// Global Provider
final searchProvider = NotifierProvider<SearchNotifier, SearchState>(
  SearchNotifier.new,
);
