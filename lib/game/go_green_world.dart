import 'dart:async';

import 'package:flame/components.dart';
import 'package:go_green/game/go_green_game.dart';
import 'package:go_green/game/sprites/astroids.dart';
import 'package:go_green/game/sprites/player.dart';

class GoGreenWorld extends World with HasGameRef<GoGreenGame> {
  late final Player player;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    player = Player();
    add(player);

    // Spawn multiple asteroids
    spawnAsteroids(3); // Adjust the number as needed
  }

  void spawnAsteroids(int count) {
    for (int i = 0; i < count; i++) {
      final asteroid = Astroid();

      // Set a random x position for the asteroid
      asteroid.position.x =
          gameRef.size.x * (i + 1) / (count + 1) - gameRef.size.x / 2;

      // Start above the screen
      asteroid.position.y = -(gameRef.size.y / 2 + asteroid.size.y / 2);

      add(asteroid);
    }
  }
}
