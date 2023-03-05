class PaymentType {
  String name;
  String code;
  String shortcutKey;
  int position;
  bool enabled;
  bool quickPayment;
  bool customerRequired;
  bool printReceipt;
  bool changeAllowed;
  bool markTransaction;
  bool openCashDrawer;

  PaymentType(
      {required this.name,
      required this.code,
      required this.shortcutKey,
      required this.position,
      required this.enabled,
      required this.quickPayment,
      required this.customerRequired,
      required this.printReceipt,
      required this.changeAllowed,
      required this.markTransaction,
      required this.openCashDrawer});
}
