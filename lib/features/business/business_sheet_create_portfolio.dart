import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/business_provider.dart';

class BusinessSheetCreatePortfolio extends ConsumerStatefulWidget {
  const BusinessSheetCreatePortfolio({super.key});

  @override
  ConsumerState<BusinessSheetCreatePortfolio> createState() =>
      _BusinessSheetCreatePortfolioState();
}

class _BusinessSheetCreatePortfolioState
    extends ConsumerState<BusinessSheetCreatePortfolio> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  bool _isUploading = false;
  String? _error;

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images.map((x) => File(x.path)));
          _error = null;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error selecting images: $e';
      });
    }
  }

  Future<void> _uploadImages() async {
    if (_selectedImages.isEmpty) return;

    setState(() {
      _isUploading = true;
      _error = null;
    });

    try {
      final businessData = ref.read(businessProvider).value;
      if (businessData == null || businessData.businessProfile == null) {
        throw Exception('Business profile not loaded');
      }

      final businessId = businessData.businessProfile!['id'];
      final supabase = Supabase.instance.client;
      final List<String> uploadedUrls = [];

      for (var file in _selectedImages) {
        final fileName =
            'portfolio/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
        final path = '$businessId/$fileName';

        await supabase.storage
            .from('business')
            .upload(
              path,
              file,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: false,
              ),
            );

        final publicUrl = supabase.storage.from('business').getPublicUrl(path);
        uploadedUrls.add(publicUrl);
      }

      // Update business profile with new images
      // We need to fetch current images first to append
      // Or rely on the provider having them.
      // Let's rely on the repository to handle the merge if possible,
      // but simpler to get current list and append.

      final currentImagesRaw = businessData.businessProfile!['images'];
      List<String> currentImages = [];
      if (currentImagesRaw != null) {
        if (currentImagesRaw is List) {
          currentImages = currentImagesRaw.map((e) => e.toString()).toList();
        } else if (currentImagesRaw is String) {
          // Handle potential single string or json
          currentImages = [currentImagesRaw];
        }
      }

      final updatedImages = [...currentImages, ...uploadedUrls];

      await ref.read(businessProvider.notifier).updateBusinessProfile({
        'images': updatedImages,
      });

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Portfolio updated successfully')),
        );
      }
    } catch (e) {
      setState(() {
        _error = 'Upload failed: $e';
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add to Portfolio',
          style: GoogleFonts.outfit(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _selectedImages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _pickImages,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF111418),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text('Select Photos'),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: _selectedImages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _selectedImages.length) {
                        return GestureDetector(
                          onTap: _pickImages,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.add, color: Colors.grey),
                          ),
                        );
                      }
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _selectedImages[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImages.removeAt(index);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(_error!, style: const TextStyle(color: Colors.red)),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (_selectedImages.isEmpty || _isUploading)
                  ? null
                  : _uploadImages,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4285F4),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isUploading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text('Upload ${_selectedImages.length} Photos'),
            ),
          ),
        ],
      ),
    );
  }
}
