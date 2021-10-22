import 'dart:math';

void main() {
  var orderCalculator = OrderCalculator(
    amount: 50,
    serviceCharge: 50,
    tax: 50,
  );

  var email = EmailSender(
      amount: orderCalculator.calculateTotal(),
      emailAddress: "adahal864@gmail.com",
      emailMessage: "Thank you for order");
  var res = email.sendEmail();
  if (!res) {
    print("oops something went wrong");
  }

  var adj = AdjustedOrderCalculator(
      amount: 50, bonus: 10, serviceCharge: 50, tax: 5, tip: 50);

  print(adj.calculateTotal());

  print("your total is ${orderCalculator.calculateTotal()}");

  Shape square = Square(length: 5);
  square.area();

  Shape rectangle = Rectangle(height: 10, length: 50);
  rectangle.area();

  var currency = CurrencyConversion();
  currency.currencyConverter = USDTONRPCurrencyConverter(
    amt: 100,
    rate: 150,
  );
  currency.calculate();

  currency.currencyConverter = NRPTOUSDCurrencyConverter(
    amt: 1000000,
    rate: 100,
  );
  currency.calculate();
}

//  single responsibility principal
class OrderCalculator {
  final int amount;
  final int tax;
  final int serviceCharge;

  OrderCalculator(
      {required this.amount, required this.tax, required this.serviceCharge});

  int calculateTotal() {
    return amount + tax + serviceCharge;
  }
}

class EmailSender {
  final String emailAddress;
  final int amount;
  final String? emailMessage;

  EmailSender(
      {required this.emailAddress, required this.amount, this.emailMessage});

  bool sendEmail() {
    var rng = Random();
    bool status = rng.nextBool();
    if (status) {
      print(
          "hello $emailAddress, your total amount is $amount, ${emailMessage ?? ""}");
      print("email sent to $emailAddress");
      return status;
    }
    return status;
  }
}
// ============================== single responsibility prinicple =====================

// open close principal
class AdjustedOrderCalculator extends OrderCalculator {
  final int tip;
  final int bonus;
  AdjustedOrderCalculator(
      {int amount = 0,
      int tax = 0,
      int serviceCharge = 0,
      this.tip = 0,
      this.bonus = 0})
      : super(amount: amount, serviceCharge: serviceCharge, tax: tax);

  @override
  int calculateTotal() {
    return amount + tax + serviceCharge + tip + bonus;
  }
}

// Liskov Substitution Principle
abstract class Shape {
  int area();
}

class Square extends Shape {
  final int length;

  Square({required this.length});

  @override
  int area() {
    return length * length;
  }
}

class Rectangle extends Shape {
  final int length;
  final int height;

  Rectangle({required this.length, required this.height});

  @override
  int area() {
    return length * height;
  }
}

//

abstract class Animal {
  void eat();
  void sleep();
}

abstract class Flying {
  void fly();
}

abstract class Swim {
  void swim();
}

class Dog implements Animal {
  @override
  void eat() {}

  @override
  void sleep() {}
}

class Bird implements Animal, Flying {
  @override
  void eat() {}

  @override
  void sleep() {}

  @override
  void fly() {}
}

class Duck implements Animal, Flying, Swim {
  @override
  void eat() {}

  @override
  void sleep() {}

  @override
  void fly() {}

  @override
  void swim() {}
}

// Depencency Inversion Principle

class CurrencyConversion {
  CurrencyConverter? currencyConverter;

  void calculate() {
    currencyConverter?.calculate();
  }
}

abstract class CurrencyConverter {
  void calculate();
}

class USDTONRPCurrencyConverter implements CurrencyConverter {
  final double amt;
  final double rate;
  USDTONRPCurrencyConverter({this.amt = 0, this.rate = 0});
  @override
  calculate() {
    print("usd to nrp is ${amt * rate}");
  }
}

class NRPTOUSDCurrencyConverter implements CurrencyConverter {
  final double amt;
  final double rate;
  NRPTOUSDCurrencyConverter({this.amt = 0, this.rate = 0});

  @override
  calculate() {
    print("nrp to usd is ${amt / rate}");
  }
}
