import 'package:flutter_discord_oauth2/globals/credentials.secret.dart';
import 'package:flutter_discord_oauth2/globals/global_settings.dart';
import 'package:flutter_discord_oauth2/stores/discordoauth2.store.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

class DiscordOAuth2Page extends StatefulWidget {
  @override
  _DiscordOAuth2PageState createState() => _DiscordOAuth2PageState();
}

class _DiscordOAuth2PageState extends State<DiscordOAuth2Page> {
  final authorizationEndpoint = Uri.parse(AppGlobalSettings.authEndpointURL);
  final tokenEndpoint = Uri.parse(AppGlobalSettings.tokenEndpointURL);
  final identifier = Credentials.APP_DISCORD_OAUTH_CLIENT_ID;
  final secret = Credentials.APP_DISCORD_OAUTH_CLIENT_SECRET;

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    final discordOAuth2Store = context.watch<DiscordOAuth2Store>();

    if (discordOAuth2Store.grant == null)
      discordOAuth2Store.grant = new oauth2.AuthorizationCodeGrant(identifier, authorizationEndpoint, tokenEndpoint,
          secret: secret, basicAuth: false);

    if (discordOAuth2Store.authorizationUrl == null)
      discordOAuth2Store.authorizationUrl = discordOAuth2Store.grant.getAuthorizationUrl(
          Uri.parse(Credentials.APP_DISCORD_OAUTH_REDIRECT_URI),
          scopes: AppGlobalSettings.APP_DISCORD_OAUTH_SCOPES);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Discord OAuth2'),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: discordOAuth2Store.authorizationUrl.toString(), //'https://flutter.dev',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) async {
            if (request.url.contains(Credentials.APP_DISCORD_OAUTH_REDIRECT_URI + '?')) {
              if (request.url.contains(AppGlobalSettings.APP_DISCORD_OAUTH_RESPONSE_TYPE_SUCCESS + '=')) {
                discordOAuth2Store.setUserOAuth2ReponseURL(request.url);

                var code = request.url.substring(
                    request.url.indexOf(AppGlobalSettings.APP_DISCORD_OAUTH_RESPONSE_TYPE_SUCCESS + '=') +
                        AppGlobalSettings.APP_DISCORD_OAUTH_RESPONSE_TYPE_SUCCESS.length +
                        1);

                print('SUCCESS, Popping with Code: ' + code);
              } else if (request.url.contains(AppGlobalSettings.APP_DISCORD_OAUTH_RESPONSE_TYPE_ERROR + '=')) {
                print('ERROR, Cause: ' +
                    request.url.substring(
                        request.url.indexOf(AppGlobalSettings.APP_DISCORD_OAUTH_RESPONSE_TYPE_ERROR + '=') +
                            AppGlobalSettings.APP_DISCORD_OAUTH_RESPONSE_TYPE_ERROR.length +
                            1,
                        request.url.indexOf('&')));
                print('ERROR, Description: ' +
                    request.url.substring(
                        request.url.indexOf(AppGlobalSettings.APP_DISCORD_OAUTH_RESPONSE_TYPE_ERROR_DESC + '=') +
                            AppGlobalSettings.APP_DISCORD_OAUTH_RESPONSE_TYPE_ERROR_DESC.length +
                            1));
              }

              Navigator.of(context).pop();

              //print('allowing navigation to $request');
              return NavigationDecision.navigate;
            }
            if (request.url.contains(Credentials.APP_DISCORD_OAUTH_REDIRECT_URI) ||
                request.url.contains(AppGlobalSettings.discordBaseUrl)) {
              //print('allowing navigation to $request');
              return NavigationDecision.navigate;
            }
            //print('preventing navigation to $request');
            Navigator.pop(context);
            return NavigationDecision.prevent;
          },
          onPageStarted: (String url) {
            //print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            //print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
