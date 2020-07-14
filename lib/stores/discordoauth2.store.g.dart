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

  final _$lastReceivedResponseAtom =
      Atom(name: '_DiscordOAuth2Store.lastReceivedResponse');

  @override
  Response get lastReceivedResponse {
    _$lastReceivedResponseAtom.reportRead();
    return super.lastReceivedResponse;
  }

  @override
  set lastReceivedResponse(Response value) {
    _$lastReceivedResponseAtom.reportWrite(value, super.lastReceivedResponse,
        () {
      super.lastReceivedResponse = value;
    });
  }

  final _$oauth2clientAtom = Atom(name: '_DiscordOAuth2Store.oauth2client');

  @override
  oauth2.Client get oauth2client {
    _$oauth2clientAtom.reportRead();
    return super.oauth2client;
  }

  @override
  set oauth2client(oauth2.Client value) {
    _$oauth2clientAtom.reportWrite(value, super.oauth2client, () {
      super.oauth2client = value;
    });
  }

  final _$discordUserAtom = Atom(name: '_DiscordOAuth2Store.discordUser');

  @override
  DiscordUser get discordUser {
    _$discordUserAtom.reportRead();
    return super.discordUser;
  }

  @override
  set discordUser(DiscordUser value) {
    _$discordUserAtom.reportWrite(value, super.discordUser, () {
      super.discordUser = value;
    });
  }

  final _$discordUserGuildsAtom =
      Atom(name: '_DiscordOAuth2Store.discordUserGuilds');

  @override
  List<DiscordGuild> get discordUserGuilds {
    _$discordUserGuildsAtom.reportRead();
    return super.discordUserGuilds;
  }

  @override
  set discordUserGuilds(List<DiscordGuild> value) {
    _$discordUserGuildsAtom.reportWrite(value, super.discordUserGuilds, () {
      super.discordUserGuilds = value;
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
  void setLastReceivedResponse(Response response) {
    final _$actionInfo = _$_DiscordOAuth2StoreActionController.startAction(
        name: '_DiscordOAuth2Store.setLastReceivedResponse');
    try {
      return super.setLastReceivedResponse(response);
    } finally {
      _$_DiscordOAuth2StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOAuth2Client(oauth2.Client c) {
    final _$actionInfo = _$_DiscordOAuth2StoreActionController.startAction(
        name: '_DiscordOAuth2Store.setOAuth2Client');
    try {
      return super.setOAuth2Client(c);
    } finally {
      _$_DiscordOAuth2StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDiscordUser(DiscordUser user) {
    final _$actionInfo = _$_DiscordOAuth2StoreActionController.startAction(
        name: '_DiscordOAuth2Store.setDiscordUser');
    try {
      return super.setDiscordUser(user);
    } finally {
      _$_DiscordOAuth2StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDiscordUserGuilds(List<DiscordGuild> list) {
    final _$actionInfo = _$_DiscordOAuth2StoreActionController.startAction(
        name: '_DiscordOAuth2Store.setDiscordUserGuilds');
    try {
      return super.setDiscordUserGuilds(list);
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
lastReceivedResponse: ${lastReceivedResponse},
oauth2client: ${oauth2client},
discordUser: ${discordUser},
discordUserGuilds: ${discordUserGuilds},
userOAuth2ReponseURL: ${userOAuth2ReponseURL},
headers: ${headers}
    ''';
  }
}
