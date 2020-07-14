import 'package:flutter_discord_oauth2/discord_oauth2_page.dart';
import 'package:flutter_discord_oauth2/globals/credentials.secret.dart';
import 'package:flutter_discord_oauth2/globals/global_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_discord_oauth2/stores/discordoauth2.store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'stores/theme.store.dart';
import 'dart:async';
import 'package:oauth2/oauth2.dart' as oauth2;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final identifier = Credentials.APP_DISCORD_OAUTH_CLIENT_ID;
  final secret = Credentials.APP_DISCORD_OAUTH_CLIENT_SECRET;

  Future<bool> getClientCredentialsStored() async {
    final discordOAuth2Store = context.read<DiscordOAuth2Store>();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("client")) {
      //var credentials = new oauth2.Credentials.fromJson(await credentialsFile.readAsString());
      var credentials = new oauth2.Credentials.fromJson(prefs.getString("client"));
      discordOAuth2Store.client = new oauth2.Client(credentials, identifier: identifier, secret: secret);
      discordOAuth2Store.setOAuth2Client(discordOAuth2Store.client);
      return true;
    }
    return false;
  }

  Future<bool> getClientCredentials() async {
    final discordOAuth2Store = context.read<DiscordOAuth2Store>();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var exists = prefs.containsKey("client");

    if (exists) {
      var credentials = new oauth2.Credentials.fromJson(prefs.getString("client"));
      discordOAuth2Store.client = new oauth2.Client(credentials, identifier: identifier, secret: secret);
      discordOAuth2Store.setOAuth2Client(discordOAuth2Store.client);
      return true;
    } else {
      if (discordOAuth2Store.userOAuth2ReponseURL.isNotEmpty) {
        if (discordOAuth2Store.client == null) {
          discordOAuth2Store.client = await discordOAuth2Store.grant
              .handleAuthorizationResponse(Uri.parse(discordOAuth2Store.userOAuth2ReponseURL).queryParameters);
        }
        if (discordOAuth2Store.client != null) {
          await prefs.setString("client", discordOAuth2Store.client.credentials.toJson());
          return true;
        }
      }
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeStore = context.watch<ThemeStore>();
    final discordOAuth2Store = context.watch<DiscordOAuth2Store>();

    print("build HomePage");

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
      body: Column(
        children: <Widget>[
          Observer(
            builder: (_) => discordOAuth2Store.client != null
                ? Text('Welcome back!')
                : FutureBuilder<bool>(
                    future: getClientCredentials(),
                    builder: (BuildContext context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (!snapshot.data) {
                          return const Text("Please log in");
                        } else {
                          return const Text("Hello User!");
                        }
                      }
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiscordOAuth2Page()),
          );
        },
        tooltip: 'Connect',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
