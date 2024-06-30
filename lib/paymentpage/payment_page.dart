import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uas/design/design.dart';
import 'package:uas/models/CartFood.dart';
import 'package:uas/routes.dart';
import 'package:uas/widgets/button.dart';

class PaymentPage extends StatefulWidget {
  final String totalPrice;
  final List<CartFood> cartItems;
  final List<Map<String, dynamic>> zoneItems;
  final String sourcePage;
  final String transactionId;

  const PaymentPage({
    super.key,
    required this.totalPrice,
    required this.cartItems,
    required this.zoneItems,
    required this.sourcePage,
    required this.transactionId,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late double parsedTotalPrice = double.tryParse(
          widget.totalPrice.replaceAll(',', '').replaceAll('.', '')) ??
      0.0;
  late double tax = parsedTotalPrice * 0.11;
  late double finalPrice = _calculatePrices();
  late int totalQuantity;
  late double totalZonePrice = 0.0;
  late int totalZoneQuantity = 0;
  late String transactionId = widget.transactionId;

  @override
  void initState() {
    super.initState();
    _calculatePrices();
    _calculateTotalQuantity();
  }

  double _calculatePrices() {
    return parsedTotalPrice + tax;
  }

  void _calculateTotalQuantity() {
    totalQuantity =
        widget.cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final numberFormat =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Summary',
          style: appBar,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Show this screen to our tenant!",
                          style: warningText,
                          textAlign: TextAlign.center,
                        ),
                        QrImageView(
                          data: transactionId,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        Text(
                          'Transaction ID',
                          style: labelText,
                          textAlign: TextAlign.center,
                        ),
                        h(4),
                        Text(
                          transactionId,
                          style: labelText,
                          textAlign: TextAlign.center,
                        ),
                        h(10),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.shopping_bag,
                              size: 50,
                            ),
                            w(16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Checkout Summary',
                                      style: headerText(16)),
                                  h(8.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Subtotal'),
                                      Text(numberFormat
                                          .format(parsedTotalPrice)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Tax 11%'),
                                      Text(numberFormat.format(tax)),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Price',
                                        style: customText(
                                            14, FontWeight.bold, primaryColor),
                                      ),
                                      Text(
                                        numberFormat.format(finalPrice),
                                        style: customText(
                                            14, FontWeight.bold, primaryColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  h(16.0),
                  Text('Order Details', style: headerText(16)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.sourcePage == 'ticket'
                          ? widget.zoneItems.length
                          : widget.cartItems.length,
                      itemBuilder: (context, index) {
                        if (widget.sourcePage == 'ticket') {
                          final item = widget.zoneItems[index];
                          return ListTile(
                            leading: Image.asset(item['imageUrl']),
                            title: Text(item['title']),
                            subtitle: Text(
                                'Price: Rp ${item['totalPrice']},00\nAdults: ${item['adultCount']}, Kids: ${item['kidsCount']}'),
                          );
                        } else {
                          final item = widget.cartItems[index];
                          return ListTile(
                            leading: Image.asset(item.imageUrl),
                            title: Text(item.name),
                            subtitle: Text(
                                'Price: Rp ${item.price},00\nQuantity: ${item.quantity}'),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  navigateToHomePage(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: PrimaryBtn('Back to Home'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
