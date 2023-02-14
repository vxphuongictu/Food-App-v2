

class Payment {
  String ? cardNumber;
  String ? expiryDate;
  String ? cvv;

  Payment({
    this.cardNumber,
    this.expiryDate,
    this.cvv,
  });

  factory Payment.formJson(Map<String, dynamic> json) {
    return Payment(
        cardNumber: json['cardNumber'],
        expiryDate: json['expiryDate'],
        cvv: json['cvv'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
    };
    return map;
  }
}