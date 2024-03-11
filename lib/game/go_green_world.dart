import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:go_green/game/go_green_game.dart';
import 'package:go_green/game/sprites/astroids.dart';
import 'package:go_green/game/sprites/player.dart';

class GoGreenWorld extends World with HasGameRef<GoGreenGame> {
  late final Player player;
  final Random _random = Random();
  int asteroidCount = 0;
  late TimerComponent asteroidTimer;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    player = Player();
    add(player);

    // Start spawning asteroids every 2 seconds
    asteroidTimer = TimerComponent(
      period: 2,
      repeat: true,
      onTick: () => spawnAsteroid(),
    );
    add(asteroidTimer);
  }

  void spawnAsteroid() {
    final asteroid = Astroid();

    // Create a new instance of Random and seed it with the current system time
    final Random random = Random(DateTime.now().millisecondsSinceEpoch);

    // Set a random x position for the asteroid within the screen width
    asteroid.position.x =
        random.nextDouble() * gameRef.size.x - gameRef.size.x / 2;

    // Start above the screen
    asteroid.position.y = -(gameRef.size.y / 2 + asteroid.size.y / 2);

    add(asteroid);

    // Increment asteroid count
    asteroidCount++;

    // Check if it's the 4th asteroid, and if so, remove the asteroidTimer
    if (asteroidCount >= 4) {
      remove(asteroidTimer);
    }
  }
}
