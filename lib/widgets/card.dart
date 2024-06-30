import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas/design/design.dart';
import 'package:uas/historypage/history_page.dart';
import 'package:uas/models/CartFood.dart';
import 'package:uas/models/Food.dart';
import 'package:uas/models/History.dart';
import 'package:uas/models/Member.dart';
import 'package:uas/models/Review.dart';
import 'package:uas/models/Zone.dart';
import 'package:uas/routes.dart';
import 'package:url_launcher/url_launcher.dart';

// HOMEPAGE CARD
class OrderCard extends StatelessWidget {
  final IconData? icon;
  final String label;
  final ImageProvider? image;
  final VoidCallback? onPressed;

  const OrderCard({
    super.key,
    this.icon,
    required this.label,
    this.image,
    this.onPressed,
  });

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
                child: Image.asset(
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

  @override
  void initState() {
    super.initState();
    _loadFavoriteState();
  }

  void _loadFavoriteState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool(widget.food.title) ?? false;
    });
  }

  void _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
    });
    await prefs.setBool(widget.food.title, isFavorite);
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
                  child: Image.asset(
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
            onPressed: _toggleFavorite,
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
              child: Image.asset(
                item.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
            ),
            h(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: headerText(16)),
                    h(5),
                    Text('Rp. $itemPrice,00', style: priceText),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      color: primaryColor,
                      onPressed: () => _updateQuantity(item, false),
                    ),
                    Text('${item.quantity}'),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      color: primaryColor,
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
class HistoryItemCard extends StatelessWidget {
  final HistoryItem historyItem;

  HistoryItemCard({required this.historyItem});

  @override
  Widget build(BuildContext context) {
    final double imageWidth = 50; // Ubah sesuai kebutuhan
    final double imageHeight = 100; // Ubah sesuai kebutuhan
    final double borderRadius = 6.0; // Ubah sesuai kebutuhan

    return Card(
      child: ListTile(
        leading: Container(
          width: imageWidth,
          height: imageHeight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image.asset(historyItem.imageUrl, fit: BoxFit.contain),
          ),
        ),
        subtitle: Text("${historyItem.date}\n${historyItem.finalPrice}"),
        onTap: () {
          showTransactionDetails(context, historyItem.transactionId);
        },
      ),
    );
  }
}

// PACKET CARD
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

// SEARCH CARD
Widget SearchCard(String title, String imagePath, String category,
    {int? priceStart, int? priceEnd}) {
  final formattedPrice = NumberFormat.decimalPattern('id');
  final formattedStartPrice =
      priceStart != null ? formattedPrice.format(priceStart) : null;
  final formattedEndPrice =
      priceEnd != null ? formattedPrice.format(priceEnd) : null;

  return Card(
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              imagePath,
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
              Text(title, style: cardText),
              h(4),
              if ((category == 'ticket' &&
                      formattedStartPrice != null &&
                      formattedEndPrice != null) ||
                  (category == 'food' && formattedStartPrice != null))
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      category == 'ticket'
                          ? "Rp. $formattedStartPrice,00 -      Rp. $formattedEndPrice,00"
                          : "Rp. $formattedStartPrice,00",
                      style: priceText,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget FeaturedCard(String imageUrl, String title) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          child: Image.asset(
            imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          child: Text(
            title,
            style: customText(16, FontWeight.bold, white),
          ),
        ),
      ],
    ),
  );
}

// TICKET ORDER DETAIL CARD
Widget TicketDetailCard(
    String title, int count, int price, Function(int) onChanged) {
  String imageUrl;
  if (title == 'Adults') {
    imageUrl = 'assets/ticketage/adults.png';
  } else {
    imageUrl = 'assets/ticketage/kids.png';
  }
  final numberFormat = NumberFormat.decimalPattern('id');
  final itemPrice = numberFormat.format(price);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: 100.0,
              ),
            ),
            h(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: cardText),
                    h(5),
                    Text('Rp. $itemPrice,00', style: priceText),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      color: primaryColor,
                      onPressed: count > 0 ? () => onChanged(count - 1) : null,
                    ),
                    Text(
                      count.toString(),
                      style: customText(16, FontWeight.normal, black),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      color: primaryColor,
                      onPressed: () => onChanged(count + 1),
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

// ABOUT US CARD
class MemberCard extends StatelessWidget {
  final Member member;
  const MemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Center(
                  child: Text(member.name),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(member.qrCodePath),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (member.link.startsWith('LinkedIn :'))
                          Image.asset(
                            'assets/aboutus/linkedin.png',
                            width: 30,
                            height: 30,
                          ),
                        if (member.link.startsWith('Instagram :'))
                          Image.asset(
                            'assets/aboutus/instagram.png',
                            width: 30,
                            height: 30,
                          ),
                        SizedBox(width: 8),
                        Flexible(
                          child: GestureDetector(
                            onTap: () async {
                              final url = member.link.split(' : ')[1];
                              final Uri urlParsed = Uri.parse(url);
                              if (await canLaunchUrl(urlParsed)) {
                                await launchUrl(urlParsed);
                              } else {
                                throw 'Could not launch $urlParsed';
                              }
                            },
                            child: Text(
                              member.link.split(' : ')[1],
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: primaryColor,
            child: Text(
              member.initials,
              style: TextStyle(color: Colors.white),
            ),
          ),
          title: Text(member.name),
          subtitle: Text(member.id),
        ),
      ),
    );
  }
}
