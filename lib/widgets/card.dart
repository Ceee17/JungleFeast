import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:uas/design/design.dart';
import 'package:uas/models/CartFood.dart';
import 'package:uas/models/Food.dart';
import 'package:uas/models/Review.dart';
import 'package:uas/models/Zone.dart';
import 'package:uas/routes.dart';

// HOMEPAGE CARD
class OrderCard extends StatelessWidget {
  final IconData? icon;
  final String label;
  final ImageProvider? image;
  final VoidCallback? onPressed;

  const OrderCard({
    Key? key,
    this.icon,
    required this.label,
    this.image,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      color: white,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image != null)
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: FittedBox(
                        child: Image(
                          image: image!,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              if (icon != null)
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Icon(
                      icon,
                      size: 50,
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  label,
                  style: labelText,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Container(
          width: 100,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              review.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(review.review),
        subtitle: Text(review.name),
      ),
    );
  }
}

// ZONE CARD
class ZoneCard extends StatefulWidget {
  final Zone zone;

  const ZoneCard({required this.zone});

  @override
  _ZoneCardState createState() => _ZoneCardState();
}

class _ZoneCardState extends State<ZoneCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: Image.network(
                  widget.zone.image,
                  width: double.infinity,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.zone.title, style: cardText),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// FOOD CARD
class FoodCard extends StatefulWidget {
  final Food food;

  const FoodCard({required this.food});

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    Fluttertoast.showToast(
      msg: isFavorite
          ? "Item has been saved to Favourites"
          : "Item has been removed from Favourites",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: black,
      textColor: white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedPrice =
        NumberFormat.decimalPattern('id').format(widget.food.price);
    return Stack(
      children: [
        Card(
          color: white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    widget.food.image,
                    width: double.infinity,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 92,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.food.title, style: cardText),
                    h(4),
                    Text("Rp. ${formattedPrice},00", style: priceText),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: primaryColor,
            ),
            onPressed: toggleFavorite,
          ),
        ),
      ],
    );
  }
}

Widget buildCartFoodCard(CartFood item, Function _updateQuantity) {
  final numberFormat = NumberFormat.decimalPattern('id');
  final itemPrice = numberFormat.format(item.price);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Rp. $itemPrice,00',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => _updateQuantity(item, false),
                    ),
                    Text('${item.quantity}'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _updateQuantity(item, true),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// HISTORY CARD
class HistoryItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String category;

  HistoryItem({
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 75,
            height: 75,
            fit: BoxFit.cover,
          ),
          w(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: cardText),
              Text(date, style: priceText),
            ],
          ),
        ],
      ),
    );
  }
}

// PAKCET CARD
class PacketCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      elevation: 4,
      child: ListTile(
        title: const Text('Book Now !'),
        subtitle: const Text(
          'Now You Can Buy Zoo Ticket and Some food cheaper...',
        ),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          navigateToOrderTicketPage(context);
        },
      ),
    );
  }
}
