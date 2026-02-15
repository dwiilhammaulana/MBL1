import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../fruit_catcher_game.dart';
import 'basket.dart';

enum FruitType { apple, banana, orange, strawberry }

class Fruit extends PositionComponent 
    with HasGameRef<FruitCatcherGame>, CollisionCallbacks {
  final FruitType type;
  final double fallSpeed = 200;
  final Random random = Random();

  Fruit({super.position})
      : type = FruitType.values[Random().nextInt(FruitType.values.length)],
        super(size: Vector2.all(40));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    anchor = Anchor.center;
    
    // PENTING: Tambahkan CircleHitbox
    final hitbox = CircleHitbox(
      radius: size.x / 2,
      position: Vector2.zero(),
      anchor: Anchor.center,
    );
    add(hitbox);
    
    
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    position.y += fallSpeed * dt;

    if (position.y > gameRef.size.y + 50) {
  
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    
    
    
    if (other is Basket) {

      gameRef.incrementScore();
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    final paint = Paint()..style = PaintingStyle.fill;

    switch (type) {
      case FruitType.apple:
        paint.color = Colors.red;
        break;
      case FruitType.banana:
        paint.color = Colors.yellow;
        break;
      case FruitType.orange:
        paint.color = Colors.orange;
        break;
      case FruitType.strawberry:
        paint.color = Colors.pink;
        break;
    }

    canvas.drawCircle(
      Offset.zero,  // 👈 CENTERED karena anchor = center
      size.x / 2,
      paint,
    );

    // Shine effect
    final shinePaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      const Offset(-5, -5),
      size.x / 5,
      shinePaint,
    );
    
    // DEBUG: Draw hitbox outline (hapus nanti)
    final debugPaint = Paint()
      ..color = Colors.green.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset.zero, size.x / 2, debugPaint);
  }
}