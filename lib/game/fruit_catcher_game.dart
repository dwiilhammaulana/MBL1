import 'dart:async';
import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/basket.dart';
import 'components/fruit.dart';
import 'managers/audio_manager.dart';

class FruitCatcherGame extends FlameGame 
    with PanDetector, HasCollisionDetection { 
  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  
  late Basket basket;
  final Random random = Random();
  double spawnTimer = 0;
  final double spawnInterval = 1.5;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    basket = Basket();
    await add(basket);
   
    
    AudioManager().playBackgroundMusic();
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    spawnTimer += dt;
    if (spawnTimer >= spawnInterval) {
      spawnTimer = 0;
      spawnFruit();
    }
  }

  void spawnFruit() {
    final x = random.nextDouble() * (size.x - 40) + 20;
    final fruit = Fruit(position: Vector2(x, -50));
    add(fruit);
    
  }

  void incrementScore() {
    scoreNotifier.value++;
    AudioManager().playSfx('collect.mp3');
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    basket.position.x += info.delta.global.x;
    basket.position.x = basket.position.x.clamp(40, size.x - 40);
  }

  @override
  void onPanStart(DragStartInfo info) {
    basket.position.x = info.eventPosition.global.x;
    basket.position.x = basket.position.x.clamp(40, size.x - 40);
  }
}