class ScanUtility {
  final typeList = [
    "animal",
    "job",
    'highschool',
    'fruit',
    'programming',
    'fruit',
  ];
  get getTypeList => typeList;
  final Map<String, String> typeMap = {
    "animal": "동물상 테스트",
    "job": "직업상 테스트",
    "highschool": "학창시절 테스트",
    "fruit": "과일상 테스트",
    "programming": "개발자상 테스트",
  };
  get getTypeMap => typeMap;
  final scanTitleList = [
    ["나는 ", "어떤 동물", "을 닮았을까?"],
    ["나는 ", "어떤 직업", "이 어울릴까?"],
    ["학창시절 ", "어떤 학생", "이었을까?"],
    ["나와 ", "닮은 과일", "은 무엇일까?"],
    ["내가 개발자면 ", "어떤 언어로 ", "코딩할까?"],
    ["나는 전생에 ", "어떤 인물", "이었을까?"],
  ];
  get getScanTitleList => scanTitleList;

  final scanTitlePreviewList = [
    ["동물상 테스트", "어떤 동물을 닮았는지", "검사 해보세요!"],
    ["직업상 테스트", "어떤 직업이 어울릴지", "알아 보세요!"],
    ["학창시절 테스트", "어떤 학생같은지", "검사 해보세요!"],
    ["과일상 테스트", "나는 무슨 과일인지", "검사 해보세요!"],
    ["개발자 테스트", "무슨 언어를 배울까", "알아 보세요!"],
    ["전생 테스트", "전생에 어떤 인물이었을지", "확인해 보세요!"],
  ];
  get getScanTitlePreviewList => scanTitlePreviewList;

  final scanDescription = [
    // "다른 사람이 봤을때 나는 어떤 동물로 보여질지 확인해 보세요! 결과 검사를 통해서 귀여운 프로필과 ninu 코인을 받아보세요!",
    "다른 사람이 봤을때 나는 어떤 동물로 보여질지 확인해 보세요!",
    "자네가 보기엔 내가 왕이 될 상인가? 어떤 직업이 어울리는지 확인해 보세요!",
    "나는 누가봐도 모범생이지! 학창시절 다른사람들은 나를 어떻게 봤는지 확인해보세요!",
    "다른 사람이 봤을때 나는 어떤 과일로 보여질지 확인해 보세요!",
    "hello, world! 내가 개발자라면 가장 잘 다룰 수 있을 것 같은 언어를 확인해 보세요!",
    "나는 전생에 어떤 인물이었을지 확인해 보세요!",
  ];
  get getScanDescription => scanDescription;
}
