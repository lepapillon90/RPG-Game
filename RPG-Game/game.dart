import 'dart:io';
import 'dart:math';
import 'character.dart';
import 'data_loader.dart';
import 'monster.dart';

// 게임 클래스 정의
class Game {
  Character player; // 캐릭터 객체
  List<Monster> monsters; // 몬스터 리스트
  int defeatedMonsters = 0; // 물리친 몬스터 수

  Game(this.player, this.monsters); // 생성자

  // 게임 시작 함수
  void startGame() {
    print('게임을 시작하시겠습니까? (1:예, 2:아니오)');
    String? input = stdin.readLineSync(); // 사용자 입력 받기
    switch (input) {
      case '1':
        print('게임을 시작합니다!');
        applyHealthBonus(); // 보너스 체력 적용
        player.showStatu1(); // 캐릭터 상태 출력
        battle(); // 전투 시작
        break; 
      case '2':
        print('게임을 종료합니다.');
        return; // 함수 종료
      default: // 그 외의 경우
        print('올바른 값을 입력하세요.');
        startGame(); // 다시 시작
    }
  }

  // 보너스 체력 적용 함수
  void applyHealthBonus() {
    Random random = Random(); // 랜덤 객체 생성
    if (random.nextInt(100) < 30) {
      // 30% 확률로 보너스 체력 적용
      player.health += 10; // 체력 10 증가
      print('🎉 보너스 체력을 얻었습니다! 현재 체력: ${player.health}');
    }
  }

  // 전투 함수
  void battle() {
    while (player.health > 0) {
      // 캐릭터가 살아있을 때 반복
      Monster currentMonster = getRandomMonster(); // 랜덤 몬스터 선택
      print('새로운 몬스터 ${currentMonster.name}(이)가 나타났습니다!');
      currentMonster.showStatus(); // 몬스터 상태 출력

      while (player.health > 0 && currentMonster.health > 0) {
        // 캐릭터와 몬스터의 체력이 0보다 클 때 반복
        print('--------------------------------------------------');
        print('${player.name}의 턴');
        player.showStatu1();
        player.showStatu2();
        player.showStatu3();
        print('--------------------------------------------------');
        print('행동을 선택하세요 (1:공격, 2:방어, 3:스킬 4:아이템사용):');
        String? input = stdin.readLineSync(); // 사용자 입력 받기

        if (input == '1') {
          player.attackMonster(currentMonster);
        } else if (input == '2') {
          player.defend();
        } else if (input == '3') {
          player.useManaSkill(currentMonster);
        } else if (input == '4') {
          player.useItem();
        } else {
          print('잘못된 입력입니다. 다시 선택하세요.');
          continue;
        }

        if (currentMonster.health > 0) {
          print('--------------------------------------------------');
          print('${currentMonster.name}의 턴');
          currentMonster.showStatus(); // 몬스터 상태 출력
          print('--------------------------------------------------');
          currentMonster.attackCharacter(player); // 캐릭터 공격
          currentMonster.increaseDefense(); // 몬스터 방어력 증가 적용
        }
      }

      if (player.health > 0) {
        // 캐릭터가 살아있을 때
        print('${currentMonster.name}을(를) 물리쳤습니다!');
        player.gainExperience(currentMonster.experienceReward); // 경험치 획득
        defeatedMonsters++; // 물리친 몬스터 수 증가

        if (Random().nextInt(100) < 50) {
          //드랍 확률 추가 (50%)
          print('🎁 몬스터가 체력 회복 물약을 드롭했습니다! HP +20 회복!');
          player.health += 20; // 체력 20 회복
        }
        monsters.add(loadMonsterStats()[Random().nextInt(monsters.length)]);
      }
    }

    print('\n게임 오버!');
    player.saveCharacterState(); // 캐릭터 상태 저장
  }

  Monster getRandomMonster() {
    // 랜덤 몬스터 선택 함수
    if (monsters.isEmpty) {
      // 몬스터 리스트가 비어 있을 때
      print("⚠️ 몬스터 리스트가 비어 있어 새로운 몬스터를 생성합니다!");
      monsters = loadMonsterStats(); // 파일에서 몬스터 리스트 다시 로드
    }
    return monsters[Random().nextInt(monsters.length)]; // 랜덤 몬스터 반환
  }
}
