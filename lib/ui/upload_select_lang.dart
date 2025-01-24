import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app/listenners/call_back_listeners.dart';
import 'package:app/network/api_call.dart';
import 'package:app/network/api_constants.dart';
import 'package:app/network/method.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

import '../base_class.dart';
import '../utils/app_constants.dart';

class UploadSelectLanguage extends StatefulWidget {
  const UploadSelectLanguage({super.key});

  @override
  State<UploadSelectLanguage> createState() => _UploadSelectLanguageState();
}

class _UploadSelectLanguageState extends State<UploadSelectLanguage>
    implements ApiResponse {
  final _controller = TextEditingController();
  String _translatedText = '';
  String _extractedText = '';
  TranslateLanguage _targetLanguage =
      TranslateLanguage.english; // Default target language

  final Map<String, TranslateLanguage> _languageMap = {
    'English': TranslateLanguage.english,
    'Hindi': TranslateLanguage.hindi,
    'Bengali': TranslateLanguage.bengali,
    'Tamil': TranslateLanguage.tamil,
    'Telugu': TranslateLanguage.telugu,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Translator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Choose the book
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {
                  chooseFile();
                },
                child: Text(
                  "Choose book",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Target Language Dropdown
            DropdownButton<TranslateLanguage>(
              value: _targetLanguage,
              onChanged: (TranslateLanguage? newValue) {
                setState(() {
                  _targetLanguage = newValue!;
                });
              },
              items: _languageMap.entries.map((entry) {
                return DropdownMenuItem<TranslateLanguage>(
                  value: entry.value,
                  child: Text(entry.key),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Translate Button
            if (_extractedText.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  translateText(_extractedText);
                  callVoiceApi();
                },
                child: Text('Translate'),
              ),
            SizedBox(height: 20),

            // Translated Text
            if (_translatedText.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _translatedText,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void chooseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      log(file.path.toString());
      extractPdfText(file);
    }
  }

  void extractPdfText(PlatformFile file) {
    final PdfDocument document =
        PdfDocument(inputBytes: File(file.path.toString()).readAsBytesSync());
    String text = PdfTextExtractor(document).extractText();
    log(text);
    setState(() {
      _extractedText = text;
    });
    document.dispose();
  }

  void translateText(String inputText) async {
    if (inputText.isEmpty) return;

    final onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: _targetLanguage,
    );

    try {
      final translatedText = await onDeviceTranslator.translateText(inputText);
      setState(() {
        _translatedText = translatedText;
      });
    } catch (e) {
      setState(() {
        _translatedText = 'Error: $e';
      });
    } finally {
      onDeviceTranslator.close();
    }
  }

  void callVoiceApi() async {
    final dio = Dio(); // Create a Dio instance

    final params = {
      "text": _translatedText,
      "voice_id": "f27d74e5-ea71-4697-be3e-f04bbd80c1a8"
    };

    final url = ApiConstants.BASE_URL_LIVE + ApiConstants.CALL_VOICE_TTS;

    try {
      final response = await dio.post(
        url,
        data: params,
        options: Options(
          headers: {
            'Content-Type':
                'application/json', // Set the content type if needed
          },
        ),
      );

      // Handle the response
      onResponse(response.data, response.statusCode, ApiRequest.CALL_VOICE_TTS);
    } on DioException catch (e) {
      // Handle the error
      if (e.response != null) {
        onError(e.response!.data, e.response!.statusCode,
            ApiRequest.CALL_VOICE_TTS);
      } else {
        onError(e.message ?? 'Unknown error', 500, ApiRequest.CALL_VOICE_TTS);
      }
    }
  }

  @override
  void onError(String errorResponse, int responseCode, Enum requestCode) {
    debugPrint('$requestCode:> $errorResponse');
    // hideProgress(context);
    final msg = json.decode(errorResponse)['message'];
    // showSnackBar(msg, msgType: AppConstants.ERROR);
  }

  @override
  void onResponse(String response, int responseCode, Enum requestCode) {
    debugPrint('$requestCode:> $response');
    log(response);
    // hideProgress();
  }
}
