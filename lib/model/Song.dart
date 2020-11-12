class Song {
  var notes = List<MctRecorderNote>();    // 음표의 배열 (화음 금지)
  var tempo = 120                      ;        // 템포(템포변경금지 , 4분음표만)
  var rhythmUpper = 4                  ;       // 박자 (위)
  var rhythmUnder = 4                   ;      // 박자 (아래)
}

class MctRecorderNote {
  var pitch = 20;  // 음정 : 제너럴미디의 noteNumber 를 그대로 씁시다. 쉼표는 -1로.
  var leng = 3   ; // 길이 : 온음표(1) 2분음표(2) 점2분음표(3) 4분음표(4) 점4분음표(6) 8분음표(8)
}