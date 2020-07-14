import 'dart:convert';
import 'package:flutter_discord_oauth2/globals/global_settings.dart';

import 'discord_guild.dart';

/*
Example User
{
  "id": "80351110224678912",
  "username": "Nelly",
  "discriminator": "1337",
  "avatar": "8342729096ea3675442027381ff50dfe",
  "verified": true,
  "email": "nelly@discord.com",
  "flags": 64,
  "premium_type": 1,
  "public_flags": 64
}
*/

class DiscordUser {
  String id;
  String username;
  String avatar;
  String discriminator;
  String email;
  bool verified;

  String get userDiscr => username + '#' + discriminator;
  String get avatarURL => AppGlobalSettings.CND_DISCORD_AVATAR_URL + id + "/" + avatar + ".png";

  DiscordUser({
    this.id,
    this.username,
    this.avatar,
    this.discriminator,
    this.email,
    this.verified,
  });

  DiscordUser copyWith({
    String id,
    String username,
    String avatar,
    String discriminator,
    String email,
    bool verified,
  }) {
    return DiscordUser(
      id: id ?? this.id,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      discriminator: discriminator ?? this.discriminator,
      email: email ?? this.email,
      verified: verified ?? this.verified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'avatar': avatar,
      'discriminator': discriminator,
      'email': email,
      'verified': verified,
    };
  }

  static DiscordUser fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DiscordUser(
      id: map['id'],
      username: map['username'],
      avatar: map['avatar'],
      discriminator: map['discriminator'],
      email: map['email'],
      verified: map['verified'],
    );
  }

  String toJson() => json.encode(toMap());

  static DiscordUser fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'DiscordUser(id: $id, username: $username, avatar: $avatar, discriminator: $discriminator, email: $email, verified: $verified)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DiscordUser &&
        o.id == id &&
        o.username == username &&
        o.avatar == avatar &&
        o.discriminator == discriminator &&
        o.email == email &&
        o.verified == verified;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        avatar.hashCode ^
        discriminator.hashCode ^
        email.hashCode ^
        verified.hashCode;
  }
}
