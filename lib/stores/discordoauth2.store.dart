import 'package:mobx/mobx.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:oauth2/oauth2.dart';

part 'discordoauth2.store.g.dart';

class DiscordOAuth2Store = _DiscordOAuth2Store with _$DiscordOAuth2Store;

abstract class _DiscordOAuth2Store with Store {
  AuthorizationCodeGrant grant;
  Uri authorizationUrl;

  @observable
  oauth2.Client client;

  @action
  void setOAuth2Client(oauth2.Client c) {
    client = c;
  }

  @computed
  Map<String, String> get headers {
    Map<String, String> h = {
      'Authorization': 'Bearer ' + client.credentials.accessToken,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    return h;
  }

  @observable
  String userOAuth2ReponseURL = "";

  @action
  void setUserOAuth2ReponseURL(String url) {
    userOAuth2ReponseURL = url;
  }
}
