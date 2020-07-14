import 'package:flutter_discord_oauth2/model/discord_guild.dart';
import 'package:http/http.dart';
import 'package:mobx/mobx.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:flutter_discord_oauth2/model/discord_user.dart';

part 'discordoauth2.store.g.dart';

class DiscordOAuth2Store = _DiscordOAuth2Store with _$DiscordOAuth2Store;

abstract class _DiscordOAuth2Store with Store {
  oauth2.AuthorizationCodeGrant grant;
  Uri authorizationUrl;

  @observable
  Response lastReceivedResponse;

  @action
  void setLastReceivedResponse(Response response) {
    lastReceivedResponse = response;
  }

  @observable
  oauth2.Client oauth2client;

  @action
  void setOAuth2Client(oauth2.Client c) {
    oauth2client = c;
  }

  @observable
  DiscordUser discordUser;

  @action
  void setDiscordUser(DiscordUser user) {
    discordUser = user;
  }

  @observable
  List<DiscordGuild> discordUserGuilds = [];

  @action
  void setDiscordUserGuilds(List<DiscordGuild> list) {
    discordUserGuilds = list;
  }

  @computed
  Map<String, String> get headers {
    Map<String, String> h = {
      'Authorization': 'Bearer ' + oauth2client.credentials.accessToken,
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
