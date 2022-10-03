import 'package:flutter/material.dart';
import 'package:getinforme/utility/colors.dart';



enum UsernameType {mobile, email,passwoord, name,transaction_id,amount,
  ProductName,Amount,Address,Pincode,pannum,aadharnum}

class UsernameEditText extends StatelessWidget {
  UsernameEditText(
    this.editTextController, {
    Key? key,
    this.isValid,
    this.isReadOnly=false,
    this.borderRadius,
    this.textObsecure = false,
    required this.usernameType,
    required this.hinttext,
    required this.keyboardtype,
        this.maxLines=1,
        this.minLines=1,
     this.onChange,
  }) : super(key: key);
  final TextEditingController editTextController;
  final bool? isValid;
  final bool isReadOnly;
  final BorderRadius? borderRadius;
  final UsernameType usernameType;
  final String hinttext;
   bool textObsecure=false;

  final TextInputType keyboardtype;
  final Function? onChange;
  final int minLines ;
  final int maxLines ;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
   // final l10n = context.l10n;
    return Container(
      child: TextFormField(
        minLines: minLines,
        maxLines: maxLines,
        obscureText: textObsecure!,
        enableInteractiveSelection: false,
        controller: editTextController,
        textDirection: TextDirection.ltr,
        autocorrect: false,
        autofocus: true,
        style: textTheme.bodyText2,
        readOnly: isReadOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) =>
            isValid! ? null : _getInvalidMessage(context, usernameType),
        keyboardType: keyboardtype,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.all(10.0),
         hintText: hinttext,
          hintStyle: textTheme.caption!.copyWith(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.black),
          border: OutlineInputBorder(
            borderRadius: borderRadius == null
                ? BorderRadius.circular(8.0)
                : borderRadius!,
            borderSide: const BorderSide(width: 1, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.disablebordercolor,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.disablebordercolor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppColors.focusedbordercolor,
            ),
          ),
        ),
        onChanged:(i){
          onChange!();
          },
      ),
    );
  }

  String _getInvalidMessage(BuildContext context, UsernameType type) {
    switch (type) {
      case UsernameType.mobile:
        return 'Enter valid mobile number';
      case UsernameType.email:
        return 'Enter valid email id';
        case UsernameType.passwoord:
        return 'Enter valid passwoord';
      case UsernameType.name:
        return 'Enter valid name';
      case UsernameType.ProductName:
        return 'Enter valid product name';
      case UsernameType.Amount:
        return 'Enter amount';
      case UsernameType.Address:
        return 'Enter valid address';
      case UsernameType.Pincode:
        return 'Enter valid pincode';
      case UsernameType.transaction_id:
        return 'Enter valid transaction Id';
      case UsernameType.pannum:
        return 'Enter valid pan card number';
      case UsernameType.aadharnum:
        return 'Enter valid aadhar card number';
      default:
        return 'Enter mobile number';
    }
  }
}

