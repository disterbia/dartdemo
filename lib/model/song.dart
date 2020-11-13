class Song {
  int id;
  String title;
  List<Note> notes;    // 음표의 배열 (화음 금지)
  int tempo ;     // 템포(템포변경금지 , 4분음표만)
  int rhythmUpper ; // 박자 (위)
  int rhythmUnder ; // 박자 (아래)

  Song({this.id,this.title,this.notes,this.tempo,this.rhythmUnder,this.rhythmUpper});
}

class Note {
  int pitch ;  // 음정 : 제너럴미디의 noteNumber 를 그대로 씁시다. 쉼표는 -1로.
  int leng   ; // 길이 : 온음표(1) 2분음표(2) 점2분음표(3) 4분음표(4) 점4분음표(6) 8분음표(8)


  Note({this.pitch , this.leng});
}