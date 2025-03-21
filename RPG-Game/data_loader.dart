import 'dart:io';
import 'character.dart';
import 'monster.dart';

// 파일에서 캐릭터 데이터 불러오기
Character loadCharacterStats(String name) { // 캐릭터 이름을 인자로 받음
  final file = File('characters.txt'); // 파일 경로
  final contents = file.readAsStringSync().trim(); // 파일 내용 읽기
  final stats = contents.split(','); // 쉼표로 구분하여 리스트로 변환
  return Character( // 캐릭터 객체 생성
    name, 
    int.parse(stats[0]), 
    int.parse(stats[1]), 
    int.parse(stats[2]), 
    int.parse(stats[3])
    ); 
}

// 파일에서 몬스터 데이터 불러오기
List<Monster> loadMonsterStats() { 
  final file = File('monsters.txt');  
  final lines = file.readAsLinesSync();   
  return lines.map((line) {
    final data = line.split(',');
    return Monster(
      data[0],           // 몬스터 이름
      int.parse(data[1]), // 체력
      int.parse(data[2]), // 공격력
      int.parse(data[3])  // 경험치 보상
    );
  }).toList();
}
