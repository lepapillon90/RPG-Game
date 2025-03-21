import 'dart:convert';
import 'dart:io';
import 'character.dart';
import 'monster.dart';
import 'game.dart';
import 'data_loader.dart';

void main() { // 메인 함수
  print('=== 게임 실행 시작 ===');

  print('캐릭터의 이름을 입력하세요: ');
  String? name; // 이름 변수 선언

  while (true) { // 이름이 한글 또는 영어로만 입력될 때까지 반복
    name = stdin.readLineSync(encoding: utf8)?.trim(); // 이름 입력
    if (name != null && RegExp(r'^[\uAC00-\uD7A3a-zA-Z]+$').hasMatch(name)) { break; // 한글 또는 영어로만 입력되면 반복 종료
    }
    print('잘못된 이름입니다. 다시 입력하세요 (한글, 영어만 허용).'); // 잘못된 이름 입력 시 안내 메시지 출력
  }

  Character player = loadCharacterStats(name); // 캐릭터 데이터 불러오기
  List<Monster> monsters = loadMonsterStats(); // 몬스터 데이터 불러오기
  Game game = Game(player, monsters); // 게임 객체 생성
  game.startGame(); // 게임 시작
} // 메인 함수 종료
