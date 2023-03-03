class TaxRate {
  String taxName;
  String taxCode;
  double taxRate;
  bool isFixedRate;

  TaxRate(
      {this.taxName = "",
      this.taxCode = "",
      this.taxRate = 0,
      this.isFixedRate = false});
}
