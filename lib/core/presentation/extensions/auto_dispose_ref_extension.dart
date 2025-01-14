part of 'package:deliverzler/core/presentation/providers/provider_utils.dart';

extension AutoDisposeRefExtension on AutoDisposeRef {
  // When invoked keeps your provider alive for [duration]
  void cacheFor(Duration duration) {
    final link = keepAlive();
    final timer = Timer(duration, () => link.close());
    onDispose(() => timer.cancel());
  }

  CancelToken cancelToken() {
    // An object from package:dio that allows cancelling pending network requests
    // if they are no-longer needed.
    final cancelToken = CancelToken();
    onDispose(() => cancelToken.cancel());
    return cancelToken;
  }
}
