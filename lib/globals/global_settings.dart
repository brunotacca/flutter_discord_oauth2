abstract class AppGlobalSettings {
  static const discordBaseUrl = "https://discord.com/";
  static const discordApiBaseUrl = "https://discord.com/api";
  static const discordApiVersion = "/v6";
  static const discordApiOAuth2Path = "/oauth2";
  static const discordApiOAuth2PathAuth = "/authorize";
  static const discordApiOAuth2PathToken = "/token";
  static const APP_DISCORD_OAUTH_RESPONSE_TYPE_SUCCESS = "code";
  static const APP_DISCORD_OAUTH_RESPONSE_TYPE_ERROR = "error";
  static const APP_DISCORD_OAUTH_RESPONSE_TYPE_ERROR_DESC = "error_description";
  static const Iterable<String> APP_DISCORD_OAUTH_SCOPES = ["identify", "email", "guilds", "guilds.join"];

  static get authEndpointURL => discordApiBaseUrl + discordApiOAuth2Path + discordApiOAuth2PathAuth;
  static get tokenEndpointURL => discordApiBaseUrl + discordApiOAuth2Path + discordApiOAuth2PathToken;
}
