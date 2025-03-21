import 'dart:math';
import 'character.dart';

class Monster {
  String name;
  int health;
  int attackPower;
  int defense = 0;
  int turnCounter = 0; // 턴 카운트 변수
  int experienceReward; // 경험치 변수

  Monster(this.name, this.health, this.attackPower, this.experienceReward); // 생성자

  void attackCharacter(Character character) { // 캐릭터를 공격
    int damage = max(0, attackPower - character.defense);  // 데미지 계산
    character.health -= damage; // 캐릭터의 체력 감소
    print('$name(이)가 ${character.name}에게 $damage의 데미지를 입혔습니다.');
  }

  void increaseDefense() { // 방어력 증가
    turnCounter++; // 턴 카운트 증가
    if (turnCounter % 3 == 0) { // 3턴마다 방어력 증가
      defense += 2; // 방어력 2 증가
      print('🛡️ ${name}의 방어력이 증가했습니다! 현재 방어력: $defense');
    }
  }

  void showStatus() { // 상태 출력
    print('$name - 체력: $health, 공격력: $attackPower, 방어력: $defense'); 
  }  
}
