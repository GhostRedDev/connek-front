import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/empty_space_top_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/m_ilestone5/components_chat/bubble_chat/bubble_chat_widget.dart';
import 'chat_page_widget.dart' show ChatPageWidget;
import 'package:flutter/material.dart';

class ChatPageModel extends FlutterFlowModel<ChatPageWidget> {
  ///  Local state fields for this page.

  List<FFUploadedFile> uploadedImages = [];
  void addToUploadedImages(FFUploadedFile item) => uploadedImages.add(item);
  void removeFromUploadedImages(FFUploadedFile item) =>
      uploadedImages.remove(item);
  void removeAtIndexFromUploadedImages(int index) =>
      uploadedImages.removeAt(index);
  void insertAtIndexInUploadedImages(int index, FFUploadedFile item) =>
      uploadedImages.insert(index, item);
  void updateUploadedImagesAtIndex(
          int index, Function(FFUploadedFile) updateFn) =>
      uploadedImages[index] = updateFn(uploadedImages[index]);

  ChatbotDataStruct? greg;
  void updateGregStruct(Function(ChatbotDataStruct) updateFn) {
    updateFn(greg ??= ChatbotDataStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Model for EmptySpaceTop component.
  late EmptySpaceTopModel emptySpaceTopModel;
  Stream<List<MessagesRow>>? listViewSupabaseStream;
  // Models for BubbleChat dynamic component.
  late FlutterFlowDynamicModels<BubbleChatModel> bubbleChatModels;
  // State field(s) for MessageFieldNew widget.
  FocusNode? messageFieldNewFocusNode;
  TextEditingController? messageFieldNewTextController;
  String? Function(BuildContext, String?)?
      messageFieldNewTextControllerValidator;
  // Stores action output result for [Backend Call - API (Send Message)] action in MessageFieldNew widget.
  ApiCallResponse? newMessageQuery;
  bool isDataUploading_uploadimages = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadimages = [];

  @override
  void initState(BuildContext context) {
    emptySpaceTopModel = createModel(context, () => EmptySpaceTopModel());
    bubbleChatModels = FlutterFlowDynamicModels(() => BubbleChatModel());
  }

  @override
  void dispose() {
    emptySpaceTopModel.dispose();
    bubbleChatModels.dispose();
    messageFieldNewFocusNode?.dispose();
    messageFieldNewTextController?.dispose();
  }
}
