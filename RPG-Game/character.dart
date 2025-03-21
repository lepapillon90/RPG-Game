import 'dart:io';
import 'dart:math';
import 'monster.dart';

class Character {
  // 캐릭터 클래스
  String name; // 이름
  int level = 1; // 레벨
  int experience = 0; // 경험치
  int health; // 체력
  int mana; // 마나
  int attackPower; // 공격력
  int defense; // 방어력
  bool hasUsedItem = false; // 아이템 사용 여부 확인

  Character(
    // 생성자
    this.name,
    this.health,
    this.mana,
    this.attackPower,
    this.defense, {
    this.level = 1,
    this.experience = 0,
  });

  void useManaSkill(Monster monster) {
    // 마나 스킬 사용
    if (mana >= 20) {
      // 마나가 20 이상일 때
      int skillDamage = attackPower * 2; // 스킬 데미지 계산
      monster.health -= skillDamage; // 몬스터의 체력 감소
      mana -= 20; // 마나 감소
      print('✨ $name(이)가 스킬을 사용하여 ${monster.name}에게 $skillDamage의 피해를 입혔습니다!');
    } else {
      print('❌ 마나가 부족합니다!');
    }
  }

  void gainExperience(int exp) {
    // 경험치 획득
    experience += exp; // 경험치 증가
    print('🎖️ 경험치 +$exp (현재 경험치: $experience / ${level * 50})');

    if (experience >= level * 50) {
      // 레벨업 조건
      levelUp(); // 레벨 업
    }
  }

  void levelUp() {
    // 레벨 업
    level++; // 레벨 증가
    experience = 0; // 경험치 초기화
    health += 20; // 체력 증가
    mana += 10; // 마나 증가
    attackPower += 5; // 공격력 증가
    defense += 2; // 방어력 증가
    print('🎉 레벨 업! 현재 레벨: $level');
  }

  void attackMonster(Monster monster) {
    // 공격
    int damage = max(0, attackPower - monster.defense); // 데미지 계산
    monster.health -= damage; // 몬스터의 체력 감소
    print('$name(이)가 ${monster.name}에게 $damage의 데미지를 입혔습니다.');
  }

  void defend() {
    // 방어
    int heal = (defense / 2).round(); // 방어력의 절반만큼 회복
    health += heal; // 체력 회복
    print('$name(이)가 방어 태세를 취하여 $heal 만큼 체력을 얻었습니다.');
  }

  void useItem() {
    // 아이템 사용
    if (!hasUsedItem) {
      // 아이템을 사용하지 않았다면
      attackPower *= 2; // 공격력 2배 증가
      hasUsedItem = true; // 아이템 사용 여부를 true로 변경
      print('⚡ 아이템을 사용하여 공격력이 증가했습니다! 현재 공격력: $attackPower');
    } else {
      print('❌ 이미 아이템을 사용하였습니다. 다시 사용할 수 없습니다.');
    }
  }

  void showStatu1() {
    print('$level레벨, 경험치: $experience / ${level * 100}');
  }

  void showStatu2() {
    print('공격력: $attackPower, 방어력: $defense');
  }

  void showStatu3() {
    print('체력: $health, 마나: $mana');
  }

  // **💾 상태 저장 기능**
  void saveCharacterState() {
    final file = File('save_character.txt');
    file.writeAsStringSync(
      '$name,$level,$health,$mana,$attackPower,$defense,$experience',
    );
    print('💾 캐릭터 상태가 저장되었습니다!');
  }

  // **📂 상태 불러오기 기능**
  static Character loadCharacterState(String name) {
    final file = File('save_character.txt');
    if (!file.existsSync()) {
      print('⚠️ 저장된 캐릭터 데이터가 없습니다. 기본 상태로 시작합니다.');
      return Character(name, 100, 50, 10, 5);
    }

    try {
      final contents = file.readAsStringSync().trim();
      final stats = contents.split(',');

      return Character(
        stats[0], // 이름
        int.parse(stats[2]), // 체력
        int.parse(stats[3]), // 마나
        int.parse(stats[4]), // 공격력
        int.parse(stats[5]), // 방어력
        level: int.parse(stats[1]), // 레벨
        experience: int.parse(stats[6]), // 경험치
      );
    } catch (e) {
      print('⚠️ 캐릭터 데이터를 불러오는 중 오류 발생! 기본 상태로 시작합니다.');
      return Character(name, 100, 50, 10, 5);
    } // **📂 상태 불러오기 기능 끝**
  } // **💾 상태 저장 기능 끝**
} // Character 클래스 끝
