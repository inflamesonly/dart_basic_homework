import 'dart:developer';
import 'dart:math' as math;

void main() {
  final num = Num();
  // num.toDecimal("1001");
  // num.toBinary(44);
  // num.toArray("value 444 221.21");
  // num.toMap(["one","two","one","five","one"]);
  // num.onlyNumber(['zero, zero, two, five', 'zero, one, cat, dog']);
  print(num.rootOfNum(-8, -3));
  // User("test@gmail.com").getMailSystem();
  // print(AdminUser("test@gmail.com").getMailSystem());
  // final userManager = UserManager();
  // userManager.addUser(AdminUser("test@gmail.com"));
  // userManager.addUser(GeneralUser("test1@gmail.com"));
  // userManager.addUser(AdminUser("test2@gmail.com"));
  // userManager.addUser(GeneralUser("test3@gmail.com"));
  // userManager.printAllUserInfo();
  
}

enum StringNumber  {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,

  error,
}

class Num {

  void toDecimal (String value) {
    try {
      log("to toDecimal");
      log(int.parse(value, radix: 2).toString());
    } catch (e) {
      log("is not binnary string");
    }
  }

  void toBinary (int value) {
    log("to toBinary");
    log(value.toRadixString(2));
  }

  void toArray (String value) {
    const divider = ' '; 

    var counter = value.split(divider).length;

    if (counter == 0) {
      print("syntax error");
      return;
    }

    List<String>? list = value.split(divider);

    if (list.isEmpty) {
      print("list empty");
      return;   
    }

    final numberList = <num>[];

    for (var word in list) {
      var number = num.tryParse(word);

      if (number != null) {
        numberList.add(number);
      }
    }
    print(numberList); 
  }

  void toMap (List<String> values) {
    final map = <String, int>{};

    for (var word in values) {
      var key = map[word];

      if (key == null) {
        map[word] = 1;
      } else {
        var counter = map[word] as int;
        counter += 1;
        map[word] = counter;
      }
    }
    print(map); 
  }

  void onlyNumber (List<String> values) {
    const divider = ',';  
    const onlyLetters = r"[^a-z]";  

    var allValues = <String>{};
    var onlyNumber = <int>{};


    for (var arrWords in values) {
      List<String>? list = arrWords.split(divider);
      for (var word in list) {
        allValues.add(word.replaceAll(RegExp(onlyLetters), ''));
      }
    }

    for (var word in allValues) {
      final finded = StringNumber.values.firstWhere((i) => i.toShortString() == word, orElse: () => StringNumber.error);
      if (finded != null) {
        if (finded.toIntValue() != StringNumber.error.toIntValue()) {
          onlyNumber.add(finded.toIntValue()!);
        }
        
      }
    }

    print(onlyNumber); 
  }

}

extension ParseToString on StringNumber {
  String toShortString() {
    return this.toString().split('.').last;
  }

  int? toIntValue () {
    switch (this) {
    case StringNumber.zero:
      return 0;
    case StringNumber.one:
      return 1;
    case StringNumber.two:
      return 2;
    case StringNumber.three:
      return 3;
    case StringNumber.four:
      return 4;
    case StringNumber.five:
      return 5;
    case StringNumber.six:
      return 6;
    case StringNumber.seven:
      return 7;
    case StringNumber.eight:
      return 8;
    case StringNumber.nine:
      return 9;
    default:
      return 100;
    }
  }
}

class Point {

  final double x;
  final double y;
  final double z;

  Point(this.x, this.y, this.z);

  Point.start () : x = 1 ,y = 1, z = 1;
  Point.zero () : x = 0 ,y = 0, z = 0;

  void printDistanceBetweenTwoPoint(Point first, Point second) {
    var value = this.disatenceTo(first,second);
    log('Distance between two point $value');
  }

  double disatenceTo (Point first, Point second) {
    var distance = math.sqrt(math.pow(second.x - first.x, 2) + math.pow(second.y - first.y, 2) + math.pow(second.z - first.z, 2));
    return distance;
  } 
}

extension RootOfNum on Num {
  double rootOfNum (double value, double n) {
	  double root = value / n;
	  double eps = 0.01;
	  int iter = 0;
	  while(root - value / root > eps) {
		iter++;
		root = 0.5 * (root + value / root);
	}
    return root;
  }
}

class User {
  final String email;

  User(this.email);

  String? getUserMail() {
    return email;
  }
}

mixin UserMail on User {
  String? getMailSystem () {
    if (!email.contains("@")) {
      return null;
    }
    List values = email.split("@"); 
    return values.last.toString();
  }
}


class UserManager<T extends User> {

  List<T> allUsersList = [];

  void removeUser (T user) {
    allUsersList.removeWhere((item) => item.email == user.email);
  }

  void addUser (T user) {
    allUsersList.add(user);
  }

  void printAllUserInfo () {
    allUsersList.forEach((element) {
      print(element.getUserMail());
    });
  }
}

class AdminUser extends User with UserMail {

  AdminUser(String email) : super(email);

  @override
  String? getUserMail() {
    return getMailSystem();
  }

}

class GeneralUser extends User {
  
  GeneralUser(String email) : super(email);

}
