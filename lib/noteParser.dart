double pitchParser(int pitch) {
  switch (pitch) {
    case -1:
      return 5/14;
    case -2:
      return 7/14;
    case 60:
      return 1 / 16; //도
      break;
    case 61:
      return 1 / 16; //도#
      break;
    case 62:
      return 2 / 16; //레
      break;
    case 63:
      return 2 / 16; //레#
      break;
    case 64:
      return 3 / 16; //미
      break;
    case 65:
      return 4 / 16; //파
      break;
    case 66:
      return 4 / 16; //파#
      break;
    case 67:
      return 5 / 16; //솔
      break;
    case 68:
      return 5 / 16; //솔#
      break;
    case 69:
      return 6 / 14; //라
      break;
    case 70:
      return 6 / 14; //라#
      break;
    case 71:
      return 1 / 14; //시
      break;
    case 72:
      return 2 / 14; //도
      break;
    case 73:
      return 2 / 14; //도#
      break;
    case 74:
      return 3 / 14; //레
      break;
    case 75:
      return 3 / 14; //레#
      break;
    case 76:
      return 4 / 14; //미
      break;
    case 77:
      return 5 / 14; //파
      break;
    case 78:
      return 5 / 14; //파#
      break;
    case 79:
      return 6 / 14; //솔
      break;
    case 80:
      return 6 / 14; //솔#
      break;
    case 81:
      return 7 / 14; //라
      break;
    case 82:
      return 7 / 14; //라#
      break;
  }
}
double pitchScore(int pitch) {
  switch (pitch) {
    case -1:
      return 0;
    case -2:
      return 0;
    case 60:
      return 520; //도
      break;
    case 61:
      return 0; //도#
      break;
    case 62:
      return 590; //레
      break;
    case 63:
      return 2 / 16; //레#
      break;
    case 64:
      return 660; //미
      break;
    case 65:
      return 700; //파
      break;
    case 66:
      return 4 / 16; //파#
      break;
    case 67:
      return 780; //솔
      break;
    case 68:
      return 5 / 16; //솔#
      break;
    case 69:
      return 870; //라
      break;
    case 70:
      return 6 / 14; //라#
      break;
    case 71:
      return 990; //시
      break;
    case 72:
      return 1050; //도
      break;
    case 73:
      return 2 / 14; //도#
      break;
    case 74:
      return 3 / 14; //레
      break;
    case 75:
      return 3 / 14; //레#
      break;
    case 76:
      return 4 / 14; //미
      break;
    case 77:
      return 5 / 14; //파
      break;
    case 78:
      return 5 / 14; //파#
      break;
    case 79:
      return 6 / 14; //솔
      break;
    case 80:
      return 6 / 14; //솔#
      break;
    case 81:
      return 7 / 14; //라
      break;
    case 82:
      return 7 / 14; //라#
      break;
  }
}

double beatParser(int beat) {
  switch (beat) {
    case 4000:
      return 1 / 32; //온
      break;
    case 3000:
      return 2 / 32; //.2
      break;
    case 2000:
      return 4 / 32; //2
      break;
    case 1500:
      return 6 / 32; //.4
      break;
    case 1000:
      return 8 / 32; // 4
      break;
    case 750:
      return 10 / 32; // .8
      break;
    case 500:
      return 12 / 32; // 8
      break;
    case 250:
      return 16 / 32; // 16
      break;
  }
}
