class History {
  History({
    this.idHistory,
    this.detailHistory,
    this.listProduct,
    this.totalPrice,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  int? idHistory;
  String? detailHistory;
  String? listProduct;
  String? totalPrice;
  String? type;
  String? createdAt;
  String? updatedAt;

  factory History.fromJson(Map<String, dynamic> json) => History(
        idHistory: json["id_history"] != null
            ? int.parse(json["id_history"].toString())
            : null,
        detailHistory: json["detail_history"],
        listProduct: json["list_product"],
        totalPrice: json["total_price"],
        type: json["type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_history ": idHistory,
        "detail_history": detailHistory,
        "list_product": listProduct,
        "total_price": totalPrice,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
