import 'dart:convert';

import 'package:flutter_discord_oauth2/globals/global_settings.dart';

/*
Example Partial Guild
{
  "id": "80351110224678912",
  "name": "1337 Krew",
  "icon": "8342729096ea3675442027381ff50dfe",
  "owner": true,
  "permissions": 36953089
}
*/
class DiscordGuild {
  String id;
  String name;
  String icon;
  bool owner;

  String get iconURL => AppGlobalSettings.CND_DISCORD_ICONS_URL + id + "/" + icon + ".png";

  DiscordGuild({
    this.id,
    this.name,
    this.icon,
    this.owner,
  });

  DiscordGuild copyWith({
    String id,
    String name,
    String icon,
    bool owner,
  }) {
    return DiscordGuild(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      owner: owner ?? this.owner,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'owner': owner,
    };
  }

  static DiscordGuild fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DiscordGuild(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
      owner: map['owner'],
    );
  }

  String toJson() => json.encode(toMap());

  static DiscordGuild fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'DiscordGuild(id: $id, name: $name, icon: $icon, owner: $owner)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DiscordGuild && o.id == id && o.name == name && o.icon == icon && o.owner == owner;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ icon.hashCode ^ owner.hashCode;
  }
}
