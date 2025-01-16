import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:happit_flutter/app/modules/auth/data/model/token_model.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class TokenRepository {
  final FlutterSecureStorage _storage;
  final _subject = BehaviorSubject<TokenModel?>.seeded(null);

  TokenRepository(this._storage);

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final accessToken = await _storage.read(key: 'accessToken');
    final refreshToken = await _storage.read(key: 'refreshToken');
    accessToken != null && refreshToken != null
        ? _subject.add(TokenModel(accessToken, refreshToken))
        : _subject.add(null);
  }

  Future<void> saveToken(TokenModel token) async {
    _subject.add(token);
    _storage
      ..write(key: 'accessToken', value: token.access_token.toString())
      ..write(key: 'refreshToken', value: token.refresh_token.toString());
  }

  Stream<TokenModel?> get token => _subject.stream;

  Future<void> deleteToken() async {
    _subject.add(null);
    _storage
      ..delete(key: 'accessToken')
      ..delete(key: 'refreshToken');
  }
}
