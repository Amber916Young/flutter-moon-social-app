class PlaceOrderBody {
  List<Cart>? _cart;
  double? _couponDiscountAmount;
  String? _couponDiscountTitle;
  double? _orderAmount;
  double? _deliveryFee;
  String? _orderType;
  String? _deliveryAddress;
  String? _paymentMethod;
  String? _orderNote;
  String? _couponCode;
  String? _deliveryTime;
  String? _deliveryDate;
  int? _branchId;
  double? _distance;
  String? _transactionReference;

  PlaceOrderBody copyWith({String? paymentMethod, String? transactionReference}) {
    _paymentMethod = paymentMethod;
    _transactionReference = transactionReference;
    return this;
  }

  PlaceOrderBody({
    required List<Cart> cart,
    required double? couponDiscountAmount,
    required double? deliveryFee,
    required String? couponDiscountTitle,
    required String? couponCode,
    required double orderAmount,
    required String? deliveryAddress,
    required String? orderType,
    required String paymentMethod,
    required int? branchId,
    required String deliveryTime,
    required String deliveryDate,
    required String orderNote,
    required double distance,
    String? transactionReference,
  }) {
    _cart = cart;
    _couponDiscountAmount = couponDiscountAmount;
    _deliveryFee = deliveryFee;
    _couponDiscountTitle = couponDiscountTitle;
    _orderAmount = orderAmount;
    _orderType = orderType;
    _deliveryAddress = deliveryAddress;
    _paymentMethod = paymentMethod;
    _orderNote = orderNote;
    _couponCode = couponCode;
    _deliveryTime = deliveryTime;
    _deliveryDate = deliveryDate;
    _branchId = branchId;
    _distance = distance;
    _transactionReference = transactionReference;
  }

  List<Cart>? get cart => _cart;

  double? get couponDiscountAmount => _couponDiscountAmount;

  double? get deliveryFee => _deliveryFee;

  String? get couponDiscountTitle => _couponDiscountTitle;

  double? get orderAmount => _orderAmount;

  String? get orderType => _orderType;

  String? get deliveryAddress => _deliveryAddress;

  String? get paymentMethod => _paymentMethod;

  String? get orderNote => _orderNote;

  String? get couponCode => _couponCode;

  String? get deliveryTime => _deliveryTime;

  String? get deliveryDate => _deliveryDate;

  int? get branchId => _branchId;

  double? get distance => _distance;

  String? get transactionReference => _transactionReference;

  PlaceOrderBody.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      _cart = [];
      json['cart'].forEach((v) {
        _cart!.add(Cart.fromJson(v));
      });
    }
    _couponDiscountAmount = json['coupon_discount_amount'];
    _couponDiscountTitle = json['coupon_discount_title'];
    _orderAmount = json['order_amount'];
    _orderType = json['order_type'];
    _deliveryAddress = json['delivery_address'];
    _paymentMethod = json['payment_method'];
    _orderNote = json['order_note'];
    _couponCode = json['coupon_code'];
    _deliveryTime = json['delivery_time'];
    _deliveryDate = json['delivery_date'];
    _deliveryFee = json['delivery_fee'];
    _branchId = json['branch_id'];
    _distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_cart != null) {
      data['cart'] = _cart!.map((v) => v.toJson()).toList();
    }
    data['coupon_discount_amount'] = _couponDiscountAmount;
    data['coupon_discount_title'] = _couponDiscountTitle;
    data['order_amount'] = _orderAmount;
    data['order_type'] = _orderType;
    data['delivery_address'] = _deliveryAddress;
    data['payment_method'] = _paymentMethod;
    data['order_note'] = _orderNote;
    data['coupon_code'] = _couponCode;
    data['delivery_time'] = _deliveryTime;
    data['delivery_date'] = _deliveryDate;
    data['delivery_fee'] = _deliveryFee;
    data['branch_id'] = _branchId;
    data['delivery_address_id'] = 0;
    data['distance'] = _distance == -1 ? 0 : _distance;
    data['delivery_distance'] = _distance == -1 ? 0 : _distance;
    if (_transactionReference != null) {
      data['transaction_reference'] = _transactionReference;
    }
    return data;
  }
}

class Cart {
  String? _productId;
  String? _price;
  List<String>? _variant;
  List<OrderVariation>? _variation;
  double? _discountAmount;
  int? _quantity;
  double? _taxAmount;

  Cart(String productId, String price, List<String> variant, List<OrderVariation> variation, double? discountAmount, int? quantity, double? taxAmount) {
    _productId = productId;
    _price = price;
    _variant = variant;
    _variation = variation;
    _discountAmount = discountAmount;
    _quantity = quantity;
    _taxAmount = taxAmount;
  }

  String? get productId => _productId;

  String? get price => _price;

  List<String>? get variant => _variant;

  List<OrderVariation>? get variation => _variation;

  double? get discountAmount => _discountAmount;

  int? get quantity => _quantity;

  double? get taxAmount => _taxAmount;

  Cart.fromJson(Map<String, dynamic> json) {
    _productId = json['product_id'];
    _price = json['price'];
    if (_variant != null) {
      _variant = json['variant'];
    }

    if (json['variations'] != null) {
      _variation = [];
      json['variations'].forEach((v) {
        _variation!.add(OrderVariation.fromJson(v));
      });
    }
    _discountAmount = json['discount_amount'];
    _quantity = json['quantity'];
    _taxAmount = json['tax_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = _productId;
    data['price'] = _price;
    data['variant'] = _variant;
    if (_variation != null) {
      data['variations'] = _variation!.map((v) => v.toJson()).toList();
    }
    data['discount_amount'] = _discountAmount;
    data['quantity'] = _quantity;
    data['tax_amount'] = _taxAmount;
    return data;
  }
}

class OrderVariation {
  String? name;
  OrderVariationValue? values;

  OrderVariation({this.name, this.values});

  OrderVariation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    values = json['values'] != null ? OrderVariationValue.fromJson(json['values']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (values != null) {
      data['values'] = values!.toJson();
    }
    return data;
  }
}

class OrderVariationValue {
  List<String?>? label;

  OrderVariationValue({this.label});

  OrderVariationValue.fromJson(Map<String, dynamic> json) {
    label = json['label'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    return data;
  }
}
