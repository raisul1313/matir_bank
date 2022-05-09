class BankAccount {
  int? id;
  String? accountNumber;
  String? branch;
  double? amount;
  String? type;

  BankAccount(
      {this.id, this.accountNumber, this.branch, this.amount, this.type});

  BankAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountNumber = json['account_number'];
    branch = json['branch'];
    amount = json['amount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_number'] = this.accountNumber;
    data['branch'] = this.branch;
    data['amount'] = this.amount;
    data['type'] = this.type;
    return data;
  }
}