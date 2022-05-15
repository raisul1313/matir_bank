import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matir_bank/model/bank_account.dart';
import 'package:matir_bank/utils/values/palette.dart';

class ItemAccount extends StatefulWidget {
  final BankAccount bankAccount;
  final Function itemClick;
  final Function itemLongClick;

  const ItemAccount(
      {Key? key,
      required this.bankAccount,
      required this.itemClick,
      required this.itemLongClick})
      : super(key: key);

  @override
  State<ItemAccount> createState() => _ItemAccountState();
}

class _ItemAccountState extends State<ItemAccount> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                widget.bankAccount.bankName.toString(),
                style: TextStyle(
                    fontSize: 20.0,
                    color: Palette.orangeShade.shade800,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                thickness: 3.0,
                color: Palette.orangeShade,
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Account Type",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            widget.bankAccount.type.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Palette.orangeShade),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Account Number",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            widget.bankAccount.accountNumber.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Palette.orangeShade),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Available Balance",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            "৳ " + widget.bankAccount.amount!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.green.shade700),
                          ),
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
      onTap: () => widget.itemClick(widget.bankAccount),
      onLongPress: () => widget.itemLongClick(widget.bankAccount),
    );
  }
}
