import 'package:flutter_discord_oauth2/discord_oauth2_page.dart';
import 'package:flutter_discord_oauth2/globals/credentials.secret.dart';
import 'package:flutter/material.dart';
import 'package:flutter_discord_oauth2/globals/global_settings.dart';
import 'package:flutter_discord_oauth2/presentation/custom_icons.dart';
import 'package:flutter_discord_oauth2/stores/discordoauth2.store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'stores/theme.store.dart';
import 'dart:async';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'model/discord_user.dart';
import 'model/discord_guild.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final identifier = Credentials.APP_DISCORD_OAUTH_CLIENT_ID;
  final secret = Credentials.APP_DISCORD_OAUTH_CLIENT_SECRET;

  Future<bool> getClientCredentials() async {
    final discordOAuth2Store = context.read<DiscordOAuth2Store>();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var exists = prefs.containsKey("client");

    if (exists) {
      var credentials = new oauth2.Credentials.fromJson(prefs.getString("client"));
      discordOAuth2Store.oauth2client = new oauth2.Client(credentials, identifier: identifier, secret: secret);
      discordOAuth2Store.setOAuth2Client(discordOAuth2Store.oauth2client);
      return true;
    } else {
      if (discordOAuth2Store.userOAuth2ReponseURL.isNotEmpty) {
        if (discordOAuth2Store.oauth2client == null) {
          discordOAuth2Store.oauth2client = await discordOAuth2Store.grant
              .handleAuthorizationResponse(Uri.parse(discordOAuth2Store.userOAuth2ReponseURL).queryParameters);
        }
        if (discordOAuth2Store.oauth2client != null) {
          await prefs.setString("client", discordOAuth2Store.oauth2client.credentials.toJson());
        }
        return true;
      }
    }

    return false;
  }

  Future<bool> getUserData() async {
    final discordOAuth2Store = context.read<DiscordOAuth2Store>();

    if (discordOAuth2Store.oauth2client != null) {
      if (discordOAuth2Store.discordUser == null) {
        Response response = await discordOAuth2Store.oauth2client.get(
            AppGlobalSettings.apiEndpointURL + AppGlobalSettings.API_DISCORD_GET_CURRENT_USER,
            headers: discordOAuth2Store.headers);

        discordOAuth2Store.setLastReceivedResponse(response);
        if (response.statusCode == 200) {
          discordOAuth2Store.setDiscordUser(DiscordUser.fromJson(response.body));
        }
      }
      if (discordOAuth2Store.discordUser != null) return true;
    }
    return false;
  }

  Future<bool> getUserGuildData() async {
    final discordOAuth2Store = context.read<DiscordOAuth2Store>();

    if (discordOAuth2Store.discordUser != null) {
      Response response = await discordOAuth2Store.oauth2client.get(
          AppGlobalSettings.apiEndpointURL + AppGlobalSettings.API_DISCORD_GET_CURRENT_USER_GUILDS,
          headers: discordOAuth2Store.headers);

      discordOAuth2Store.setLastReceivedResponse(response);
      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<DiscordGuild> guilds = [];
        l.forEach((element) => guilds.add(DiscordGuild.fromJson(json.encode(element))));
        discordOAuth2Store.setDiscordUserGuilds(guilds);
      }

      if (discordOAuth2Store.discordUserGuilds.isNotEmpty) return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("theme")) {
        final themeStore = context.read<ThemeStore>();
        if (themeStore.currentThemeType.toString() != prefs.getString("theme")) {
          themeStore.toggleCurrentTheme();
        }
      }

      if (prefs.containsKey("client")) {
        getClientCredentials();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeStore = context.watch<ThemeStore>();
    final discordOAuth2Store = context.watch<DiscordOAuth2Store>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Discord OAuth2"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.brightness_medium),
            onPressed: () async {
              themeStore.toggleCurrentTheme();
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("theme", themeStore.currentThemeType.toString());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /*Observer(
              builder: (_) => Text(
                "Last Response Status: " +
                    (discordOAuth2Store.lastReceivedResponse == null
                        ? ""
                        : discordOAuth2Store.lastReceivedResponse.statusCode.toString()),
              ),
            ),
            */
            Observer(
              builder: (_) =>
                  (discordOAuth2Store.userOAuth2ReponseURL.isEmpty && discordOAuth2Store.oauth2client == null)
                      ? Text('Please click the button below to connect.')
                      : Container(),
            ),
            Observer(
              builder: (_) =>
                  (discordOAuth2Store.userOAuth2ReponseURL.isNotEmpty && discordOAuth2Store.oauth2client == null)
                      ? FutureBuilder<bool>(
                          future: getClientCredentials(),
                          builder: (BuildContext context, snapshot) {
                            return RaisedButton(
                              child: Text("Get User Credentials"),
                              onPressed: () {
                                getClientCredentials();
                              },
                            );
                          })
                      : Container(),
            ),
            Observer(
              builder: (_) => (discordOAuth2Store.oauth2client != null && discordOAuth2Store.discordUser == null)
                  ? FutureBuilder<bool>(
                      future: getUserData(),
                      builder: (BuildContext context, snapshot) {
                        return RaisedButton(
                          child: Text("Reload User Data"),
                          onPressed: () {
                            getUserData();
                          },
                        );
                      })
                  : Container(),
            ),
            Observer(
              builder: (_) => discordOAuth2Store.discordUser != null
                  ? DiscordUserCard(user: discordOAuth2Store.discordUser)
                  : Container(),
            ),
            Observer(
              builder: (_) => (discordOAuth2Store.discordUser != null &&
                      discordOAuth2Store.discordUserGuilds != null &&
                      discordOAuth2Store.discordUserGuilds.isNotEmpty)
                  ? Divider()
                  : Container(),
            ),
            Observer(
              builder: (_) => (discordOAuth2Store.discordUser != null &&
                      (discordOAuth2Store.discordUserGuilds == null || discordOAuth2Store.discordUserGuilds.isEmpty))
                  ? FutureBuilder<bool>(
                      future: getUserGuildData(),
                      builder: (BuildContext context, snapshot) {
                        return RaisedButton(
                          child: Text("Reload User Guild Data"),
                          onPressed: () {
                            getUserGuildData();
                          },
                        );
                      })
                  : Container(),
            ),
            Observer(
              builder: (_) => (discordOAuth2Store.discordUser != null &&
                      discordOAuth2Store.discordUserGuilds != null &&
                      discordOAuth2Store.discordUserGuilds.isNotEmpty)
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: discordOAuth2Store.discordUserGuilds.length,
                        itemBuilder: (context, index) =>
                            DiscordGuildCard(guild: discordOAuth2Store.discordUserGuilds[index]),
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
      floatingActionButton: Observer(
        builder: (_) => (discordOAuth2Store.oauth2client != null)
            ? FloatingActionButton.extended(
                onPressed: () {},
                label: Text(
                    (discordOAuth2Store.discordUser == null ? "Connected!" : discordOAuth2Store.discordUser.userDiscr)),
                tooltip: 'Connected!',
                icon: Icon(CustomIcons.discord),
              )
            : FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiscordOAuth2Page()),
                  );
                },
                label: Text('Connect'),
                tooltip: 'Connect',
                icon: Icon(CustomIcons.discord),
              ),
      ),
    );
  }
}

class DiscordUserCard extends StatelessWidget {
  final DiscordUser user;

  DiscordUserCard({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return user == null
        ? Card()
        : Card(
            child: ListTile(
              leading: Image.network(user.avatarURL),
              title: Text(user.userDiscr),
              subtitle: Text(user.email + " (" + (user.verified ? "" : "Not ") + "Verified) "),
            ),
          );
  }
}

class DiscordGuildCard extends StatelessWidget {
  final DiscordGuild guild;

  DiscordGuildCard({Key key, this.guild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return guild == null
        ? Card()
        : Card(
            child: ListTile(
              leading: Image.network(guild.iconURL),
              title: Text(guild.name),
              subtitle: Text('ID: ' + guild.id + " (" + (guild.owner ? "" : "Not ") + "Owner) "),
            ),
          );
  }
}
