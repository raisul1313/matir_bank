import 'package:flutter/material.dart';
import 'package:matir_bank/model/bank_account.dart';
import 'package:matir_bank/utils/values/palette.dart';

class ItemAccount extends StatelessWidget {
  final BankAccount bankAccount;
  const ItemAccount({Key? key, required this.bankAccount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.white,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bankAccount.bankName.toString(),
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Palette.orangeShade.shade900,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 3.0,
                color: Palette.orangeShade.shade900,
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("Type: "),
                          Text(bankAccount.type.toString()),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Account Number: "),
                          Text(bankAccount.accountNumber.toString()),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("Available Balance: "),
                          Text(bankAccount.amount!),
                          //bankAccount.amount!,
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onLongPress: (){},
      onTap: (){},
    );
  }
}
