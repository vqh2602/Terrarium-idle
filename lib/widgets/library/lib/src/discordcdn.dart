import 'package:http/http.dart' as http;

import 'clients/bot_discord_client.dart';
import 'clients/discord_client.dart';

///
/// Returns an instance of [BotDiscordClient] which
/// takes on a token that authorizes the bot for requests.
///
DiscordClient withBotToken(final String token) {
  return BotDiscordClient(
    token: token,
    httpClient: http.Client(),
  );
}
