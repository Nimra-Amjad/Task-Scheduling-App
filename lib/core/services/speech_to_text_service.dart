import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;

  /// Initialize the speech engine
  Future<bool> init() async {
    _isInitialized = await _speechToText.initialize();
    return _isInitialized;
  }

  /// Start listening to the user's voice
  Future<void> startListening({
    required Function(String recognizedWords) onResult,
    Function()? onListeningStart,
    Function()? onListeningStop,
  }) async {
    if (!_isInitialized) await init();

    _speechToText.listen(
      onResult: (result) {
        onResult(result.recognizedWords);
      },
      listenMode: ListenMode.confirmation,
    );

    if (onListeningStart != null) onListeningStart();
  }

  /// Stop listening manually
  Future<void> stopListening({Function()? onListeningStop}) async {
    await _speechToText.stop();
    if (onListeningStop != null) onListeningStop();
  }

  /// Whether currently listening
  bool get isListening => _speechToText.isListening;

  /// Whether initialized
  bool get isAvailable => _isInitialized;
}
