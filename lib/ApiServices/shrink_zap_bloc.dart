import 'dart:convert';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_shortener_project/Utils/Constants.dart';
import 'package:http/http.dart' as http;


part 'shrink_zap_event.dart';
part 'shrink_zap_state.dart';

class ShrinkZapBloc extends Bloc<ShrinkZapEvent, ShrinkZapState> {
  ShrinkZapBloc() : super(ShrinkZapInitial()) {

    on<ShrinkZapEventHandler>((event, emit) async {
      emit(ShrinkZapLoading());
      try {
        final String avatarKey = ApiConstants.xAvatarKey;
        String url = ApiConstants.baseUrl;

        final Map<String, dynamic> body = {
          'base_url': event.url,
        };

        final response = await http.post(
          Uri.parse(ApiConstants.baseUrl),
          headers: {
            "Content-Type": "application/json",
            "X-Avatar-Key": avatarKey,
          },
          body: jsonEncode(body),
        );

        developer.log('response: ${response.body}');
        final responseBody = jsonDecode(response.body);
        if(response.statusCode == 200 || response.statusCode == 201) {
          String message = responseBody.containsKey('message') ? responseBody['message'] : 'Short url created successfully.';
          final responseData = responseBody['urldata'];
          emit(ShrinkZapSuccess(message, responseData));
        } else {
          String message = responseBody['message'];
          emit(ShrinkZapError(message));
        }

      } catch (e) {
        emit(ShrinkZapError("Something went wrong. Please try again."));
      }
    });


  }
}
