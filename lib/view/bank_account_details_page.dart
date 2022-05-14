import 'package:flutter/material.dart';
import 'package:matir_bank/custom_ui/custom_button.dart';
import 'package:matir_bank/model/bank_account.dart';
import 'package:matir_bank/utils/values/palette.dart';

class BankAccountDetails extends StatefulWidget {
  final BankAccount bankAccount;
  const BankAccountDetails({Key? key, required this.bankAccount})
      : super(key: key);

  @override
  State<BankAccountDetails> createState() => _BankAccountDetailsState();
}

class _BankAccountDetailsState extends State<BankAccountDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bank Account No. " + widget.bankAccount.accountID.toString(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Details",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.black),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bank Name:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Palette.orangeShade),
                            ),
                            Text(
                              "Account Type:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Palette.orangeShade),
                            ),
                            Text(
                              "Account Number:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Palette.orangeShade),
                            ),
                            Text(
                              "Branch Name:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Palette.orangeShade),
                            ),
                            Text(
                              "Total Amount:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Palette.orangeShade),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.bankAccount.bankName.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                            Text(
                              widget.bankAccount.type.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                            Text(
                              widget.bankAccount.accountNumber.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                            Text(
                              widget.bankAccount.branch.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.black),
                            ),
                            Text(
                              widget.bankAccount.amount.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "Want to add/withdraw money",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: CustomButton(
                            buttonName: 'Add',
                            buttonHeight: 50,
                            backgroundColor: Palette.orangeShade.shade700,
                            onButtonPressed: () => null,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        SizedBox(
                          width: 100,
                          child: CustomButton(
                            buttonName: 'Withdraw',
                            buttonHeight: 50,
                            backgroundColor: Palette.orangeShade.shade700,
                            onButtonPressed: () => null,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
