import 'package:flutter/material.dart';
import 'package:uas/accountpage/account_page.dart';
import 'package:uas/historypage/history_page.dart';
import 'package:uas/orderfoodpage/choose_zone_page.dart';

Color primaryColor = Color(0xFFFFA62F);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Home - No need to navigate, already in HomePage
        break;
      case 1:
        // kemungkinan nanti bakal diganti jadi pushReplacement biargabisa di back
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Placeholder()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HistoryPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ticket & Food'),
            Text('Ordering'),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OrderButton(
                  image: AssetImage('assets/ticket.png'),
                  label: 'Ticket',
                  onPressed: () => Placeholder(),
                ),
                SizedBox(width: 16),
                OrderButton(
                  icon: Icons.restaurant,
                  label: 'Food',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChooseZonePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'People’s Review',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ReviewCard(
              review: 'Very Cozy',
              name: 'Timoty Carloss',
              image: 'assets/food1.png',
            ),
            ReviewCard(
              review: 'Great Food, Great Zoo',
              name: 'Jafier Matadore',
              image: 'assets/food1.png',
            ),
            ReviewCard(
              review: 'My Family Loves The Zoo',
              name: 'Finnia El Nino',
              image: 'assets/food1.png',
            ),
            ReviewCard(
              review: 'The Services are Good!',
              name: 'Jessen La Nina',
              image: 'assets/food1.png',
            ),
            ReviewCard(
              review: 'Very Cozy',
              name: 'Timoty Carloss',
              image: 'assets/food1.png',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

class OrderButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final ImageProvider? image;
  final VoidCallback? onPressed;

  const OrderButton({
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
        borderRadius: BorderRadius.circular(
            16), // Adjust the radius for the desired curvature
      ),
      elevation: 1, // Adjust the elevation for the desired shadow effect
      color: Colors.white, // Adjust the color for the button background
      child: InkWell(
        onTap: onPressed, // Set the onTap callback for the InkWell
        child: Padding(
          padding: const EdgeInsets.all(
              8), // Adjust the padding for the space inside the button
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image != null)
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(
                          0xFFFFA62F), // or any other grey color you prefer
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.all(25), // Adjust the padding as needed
                      child: FittedBox(
                        child: Image(
                          image: image!,
                        ),
                        fit: BoxFit
                            .fill, // this will ensure the image fills the entire space
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
                      color: primaryColor, // or any other grey color you prefer
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
                child: Text(label),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String review;
  final String name;
  final String image;

  const ReviewCard({
    Key? key,
    required this.review,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Container(
          width: 100,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(review),
        subtitle: Text(name),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: primaryColor,
          size: 20,
        ),
      ),
    );
  }
}
