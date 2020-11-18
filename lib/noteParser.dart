double pitchParser(int pitch){
  switch(pitch){
    case 60 : return 1; //도
    break;
    case 61 : return 1; //도#
    break;
    case 62 : return 1; //레
    break;
    case 63 : return 1; //레#
    break;
    case 64 : return 1; //미
    break;
    case 65 : return 1; //파
    break;
    case 66 : return 1; //파#
    break;
    case 67 : return 1; //솔
    break;
    case 68 : return 1; //솔#
    break;
    case 69 : return 1; //라
    break;
    case 70 : return 1; //라#
    break;
    case 71 : return 1; //시
    break;
    case 72 : return 1; //도
    break;
    case 73 : return 1; //도#
    break;
    case 74 : return 1; //레
    break;
    case 75 : return 1; //레#
    break;
    case 76 : return 1; //미
    break;
    case 77 : return 1; //파
    break;
    case 78 : return 1; //파#
    break;
    case 79 : return 1; //솔
    break;
    case 80 : return 1; //솔#
    break;
    case 81 : return 1; //라
    break;
    case 82 : return 1; //라#
    break;
  }
}

double beatParser(int beat){
  switch(beat){
    case 4000 : return 1; //온
    break;
    case 3000 : return 1; //.2
    break;
    case 2000: return 1;  //2
    break;
    case 1500 : return 1; //.4
    break;
    case 1000 : return 1; // 4
    break;
    case 500 : return 1;  // 8
    break;
    case 250 : return 1;  // 16
    break;
  }

}