// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discordoauth2.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DiscordOAuth2Store on _DiscordOAuth2Store, Store {
  Computed<Map<String, String>> _$headersComputed;

  @override
  Map<String, String> get headers =>
      (_$headersComputed ??= Computed<Map<String, String>>(() => super.headers,
              name: '_DiscordOAuth2Store.headers'))
          .value;

  final _$clientAtom = Atom(name: '_DiscordOAuth2Store.client');

  @override
  Client get client {
    _$clientAtom.reportRead();
    return super.client;
  }

  @override
  set client(Client value) {
    _$clientAtom.reportWrite(value, super.client, () {
      super.client = value;
    });
  }

  final _$userOAuth2ReponseURLAtom =
      Atom(name: '_DiscordOAuth2Store.userOAuth2ReponseURL');

  @override
  String get userOAuth2ReponseURL {
    _$userOAuth2ReponseURLAtom.reportRead();
    return super.userOAuth2ReponseURL;
  }

  @override
  set userOAuth2ReponseURL(String value) {
    _$userOAuth2ReponseURLAtom.reportWrite(value, super.userOAuth2ReponseURL,
        () {
      super.userOAuth2ReponseURL = value;
    });
  }

  final _$_DiscordOAuth2StoreActionController =
      ActionController(name: '_DiscordOAuth2Store');

  @override
  void setOAuth2Client(Client c) {
    final _$actionInfo = _$_DiscordOAuth2StoreActionController.startAction(
        name: '_DiscordOAuth2Store.setOAuth2Client');
    try {
      return super.setOAuth2Client(c);
    } finally {
      _$_DiscordOAuth2StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserOAuth2ReponseURL(String url) {
    final _$actionInfo = _$_DiscordOAuth2StoreActionController.startAction(
        name: '_DiscordOAuth2Store.setUserOAuth2ReponseURL');
    try {
      return super.setUserOAuth2ReponseURL(url);
    } finally {
      _$_DiscordOAuth2StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
client: ${client},
userOAuth2ReponseURL: ${userOAuth2ReponseURL},
headers: ${headers}
    ''';
  }
}
