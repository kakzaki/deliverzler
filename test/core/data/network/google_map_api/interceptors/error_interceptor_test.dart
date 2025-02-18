import 'package:deliverzler/core/data/network/google_map_api/interceptors/error_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'logging_interceptor_test.mocks.dart';

void main() {
  late MockResponseInterceptorHandler mockResponseInterceptorHandler;
  late ErrorInterceptor errorInterceptor;

  setUp(() {
    mockResponseInterceptorHandler = MockResponseInterceptorHandler();
    errorInterceptor = ErrorInterceptor();
  });

  group('onResponse', () {
    test(
      "should call handler.reject if response.data['status'] != 'OK'"
      'with proper DioError: [error message from backend / statusCode 400 / DioErrorType.response]',
      () async {
        // GIVEN
        final tResponse = Response(
          requestOptions: RequestOptions(path: ''),
          data: {'status': 'invalid'},
          statusCode: 200,
        );
        // WHEN
        errorInterceptor.onResponse(tResponse, mockResponseInterceptorHandler);
        // THEN
        final DioError captured =
            verify(mockResponseInterceptorHandler.reject(captureAny))
                .captured
                .single;
        expect(captured.message, 'invalid');
        expect(captured.response!.statusCode, 400);
        expect(captured.type, DioErrorType.response);
        verifyNoMoreInteractions(mockResponseInterceptorHandler);
      },
    );

    test(
      "should call handler.next if response.data['status'] == 'OK'",
      () async {
        // GIVEN
        final tResponse = Response(
          requestOptions: RequestOptions(path: ''),
          data: {'status': 'OK'},
          statusCode: 200,
        );
        // WHEN
        errorInterceptor.onResponse(tResponse, mockResponseInterceptorHandler);
        // THEN
        verify(mockResponseInterceptorHandler.next(tResponse)).called(1);
        verifyNoMoreInteractions(mockResponseInterceptorHandler);
      },
    );
  });

  //This needed if your api throw custom statusCode for business errors..
  /*
    group('onError', () {
    const tErrorMessage = 'error_message_test';
    const tErrorType = DioErrorType.response;

    test(
      'should call handler.next if response.statusCode is not determined',
      () async {
        // GIVEN
        final tError = DioError(
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'error_description': tErrorMessage},
            statusCode: 500,
          ),
          requestOptions: RequestOptions(path: ''),
          type: DioErrorType.other,
        );
        // WHEN
        errorInterceptor.onError(tError, mockErrorInterceptorHandler);
        // THEN
        verify(mockErrorInterceptorHandler.next(tError)).called(1);
        verifyNoMoreInteractions(mockErrorInterceptorHandler);
      },
    );

    test(
      'should override DioError message with error message from backend'
      'and override DioError type with DioErrorType.response'
      'if response.statusCode is 400',
      () async {
        // GIVEN
        final tError = DioError(
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'error_description': tErrorMessage},
            statusCode: 400,
          ),
          requestOptions: RequestOptions(path: ''),
          type: DioErrorType.other,
        );
        // WHEN
        errorInterceptor.onError(tError, mockErrorInterceptorHandler);
        // THEN
        expect(tError.message, tErrorMessage);
        expect(tError.type, tErrorType);
        expect(tError.response!.statusCode, 400);
      },
    );

    test(
      'should call handler.reject if response.statusCode is 400',
      () async {
        // GIVEN
        final tError = DioError(
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'error_description': tErrorMessage},
            statusCode: 400,
          ),
          requestOptions: RequestOptions(path: ''),
          type: DioErrorType.other,
        );
        // WHEN
        errorInterceptor.onError(tError, mockErrorInterceptorHandler);
        // THEN
        verify(mockErrorInterceptorHandler.reject(tError)).called(1);
        verifyNoMoreInteractions(mockErrorInterceptorHandler);
      },
    );

    test(
      'should override DioError message with error message from backend'
      'and override DioError type with DioErrorType.response'
      'if response.statusCode is 424',
      () async {
        // GIVEN
        final tError = DioError(
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'error_description': tErrorMessage},
            statusCode: 424,
          ),
          requestOptions: RequestOptions(path: ''),
          type: DioErrorType.other,
        );
        // WHEN
        errorInterceptor.onError(tError, mockErrorInterceptorHandler);
        // THEN
        expect(tError.message, tErrorMessage);
        expect(tError.type, tErrorType);
        expect(tError.response!.statusCode, 424);
      },
    );

    test(
      'should call handler.reject if response.statusCode is 424',
      () async {
        // GIVEN
        final tError = DioError(
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'error_description': tErrorMessage},
            statusCode: 424,
          ),
          requestOptions: RequestOptions(path: ''),
          type: DioErrorType.other,
        );
        // WHEN
        errorInterceptor.onError(tError, mockErrorInterceptorHandler);
        // THEN
        verify(mockErrorInterceptorHandler.reject(tError)).called(1);
        verifyNoMoreInteractions(mockErrorInterceptorHandler);
      },
    );
  });*/
}
