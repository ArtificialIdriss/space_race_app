import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:go_green/game/go_green_game.dart';
import 'package:go_green/game/sprites/player.dart';

class Astroid extends SpriteComponent
    with HasGameRef<GoGreenGame>, CollisionCallbacks {
  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load("astroid01.png");
    size = Vector2.all(300);

    // Set random x position within the screen width
    double minX = -(gameRef.size.x / 2) + size.x / 2; // Left boundary
    double maxX = (gameRef.size.x / 2) - size.x / 2; // Right boundary
    double randomX = Random().nextDouble() * (maxX - minX) + minX;

    position = Vector2(
        randomX, -(gameRef.size.y / 2 + size.y / 2)); // Start above the screen
    anchor = Anchor.center;
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    double fallSpeed = 400; // Adjust this value to control the speed of falling

    // Move the bin downwards
    position.y += fallSpeed * dt;

    if (position.y > gameRef.size.y) {
      position.y =
          -(gameRef.size.y / 2 + size.y / 2); // Start again above the screen
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player && other.position.y > position.y) {
      other.removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
