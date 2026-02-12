import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/job_request_search_item.dart';

final jobSearchProvider =
    FutureProvider.family<List<JobRequestSearchItem>, String>((
      ref,
      query,
    ) async {
      final trimmed = query.trim();
      if (trimmed.length < 3) return <JobRequestSearchItem>[];

      final supabase = Supabase.instance.client;

      final List<dynamic> res = await supabase
          .from('requests')
          .select(
            'id, description, status, created_at, budget_min_cents, budget_max_cents',
          )
          .eq('status', 'pending')
          .ilike('description', '%$trimmed%')
          .order('created_at', ascending: false)
          .limit(20);

      return res
          .whereType<Map<String, dynamic>>()
          .map(JobRequestSearchItem.fromJson)
          .toList();
    });
