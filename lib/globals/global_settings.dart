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
  static const Iterable<String> APP_DISCORD_OAUTH_SCOPES = ["identify", "email", "guilds"];

  static get authEndpointURL => discordApiBaseUrl + discordApiOAuth2Path + discordApiOAuth2PathAuth;
  static get tokenEndpointURL => discordApiBaseUrl + discordApiOAuth2Path + discordApiOAuth2PathToken;
  static get apiEndpointURL => discordApiBaseUrl + discordApiVersion;

  static const API_DISCORD_GET_CURRENT_USER = "/users/@me";
  static const API_DISCORD_GET_CURRENT_USER_GUILDS = "/users/@me/guilds";
  static const CND_DISCORD_AVATAR_URL = "https://cdn.discordapp.com/avatars/";
  static const CND_DISCORD_ICONS_URL = "https://cdn.discordapp.com/icons/";
}
