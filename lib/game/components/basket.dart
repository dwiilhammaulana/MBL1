import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Basket extends PositionComponent 
    with HasGameRef, CollisionCallbacks {
  Basket() : super(size: Vector2(80, 60));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
    anchor = Anchor.center;
    
    final hitbox = RectangleHitbox(
      size: size,
      position: Vector2(-size.x / 2, -size.y / 2),
    );
    add(hitbox);

  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    final paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(-size.x / 2, -size.y / 2, size.x, size.y),
      const Radius.circular(10),
    );
    canvas.drawRRect(rect, paint);

    final handlePaint = Paint()
      ..color = Colors.brown[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final handlePath = Path()
      ..moveTo(-size.x / 2 + 10, -size.y / 2)
      ..quadraticBezierTo(0, -size.y / 2 - 20, size.x / 2 - 10, -size.y / 2);

    canvas.drawPath(handlePath, handlePaint);
    
    // DEBUG: Draw hitbox outline
    final debugPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(
      Rect.fromLTWH(-size.x / 2, -size.y / 2, size.x, size.y),
      debugPaint,
    );
  }
}