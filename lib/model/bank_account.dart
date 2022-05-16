class BankAccount {
  int? accountID;
  int? userID;
  String? accountNumber;
  String? bankName;
  String? branch;
  double? amount;
  String? type;

  BankAccount(
      {this.accountID,
      this.userID,
      this.accountNumber,
      this.bankName,
      this.branch,
      this.amount,
      this.type});

  BankAccount.fromJson(Map<String, dynamic> json) {
    accountID = json['account_id'];
    userID = json['user_id'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    branch = json['branch'];
    amount = json['amount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_id'] = this.accountID;
    data['user_id'] = this.userID;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['branch'] = this.branch;
    data['amount'] = this.amount;
    data['type'] = this.type;
    return data;
  }
}
