import 'package:flutter_discord_oauth2/home_page.dart';
import 'package:flutter_discord_oauth2/stores/discordoauth2.store.dart';
import 'package:flutter_discord_oauth2/stores/theme.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          Provider<ThemeStore>(
            create: (_) => ThemeStore(),
          ),
          Provider<DiscordOAuth2Store>(
            create: (_) => DiscordOAuth2Store(),
          )
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => MaterialApp(
        title: 'Flutter Discord OAuth2',
        theme: context.watch<ThemeStore>().currentThemeData,
        home: HomePage(),
      ),
    );
  }
}
