import 'package:flutter/material.dart';
import 'package:matir_bank/model/bank_account.dart';
import 'package:matir_bank/utils/values/palette.dart';

class ItemAccount extends StatefulWidget {
  final BankAccount bankAccount;
  final Function itemClick;
  final bool isEnabled;
  final Function itemDelete;
  final Function itemEdit;

  const ItemAccount({Key? key,
    required this.bankAccount,
    required this.itemClick,
    required this.isEnabled,
    required this.itemDelete,
    required this.itemEdit})
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
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.bankAccount.bankName.toString().toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Palette.orangeShade.shade800,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 25.0,
                          width: 25.0,
                          child: PopupMenuButton(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                                child: Icon(
                                  Icons.more_horiz_rounded,
                                  color: Colors.deepOrangeAccent,
                                ),
                              ),
                              itemBuilder: (context) =>
                              [
                                PopupMenuItem(
                                  child: Text("Edit"),
                                  value: 1,
                                  onTap: () =>
                                      widget.itemEdit(widget.bankAccount),
                                ),
                                PopupMenuItem(
                                  child: Text("Delete"),
                                  value: 2,
                                  onTap: () =>
                                      widget.itemDelete(widget.bankAccount),
                                )
                              ]),
                        ),
                      ))
                ],
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
                            "৳ " + widget.bankAccount.amount.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: widget.bankAccount.amount! <= 0 ? Colors.red : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () => widget.itemClick(widget.bankAccount),
    );
  }
}
