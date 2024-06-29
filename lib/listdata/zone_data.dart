import 'package:flutter/material.dart';
import 'package:uas/models/Zone.dart';
import 'package:uas/routes.dart';

final int priceStart = 200000;
final int priceEnd = 300000;
final int? priceStartCS = null;
final int? priceEndCS = null;

final List<Zone> zoneData = [
  Zone(
    image: 'assets/zone/jungleexpedition.jpg',
    title: 'Jungle Expedition',
    priceStart: priceStart,
    priceEnd: priceEnd,
    onTap: (BuildContext context) {
      navigateToFaunaZonePage(context);
    },
    category: 'ticket',
    description:
        'Immerse yourself in the wild at the Jungle Expedition Zone, where you can dine alongside majestic elephants as they parade through the lush surroundings. Enjoy a unique dining experience that brings you close to nature, providing both an adventurous and relaxing atmosphere for families and animal lovers alike.',
    zone: 'fauna',
  ),
  Zone(
    image: 'assets/zone/underwaterparadise.jpg',
    title: 'Underwater Paradise',
    priceStart: priceStart,
    priceEnd: priceEnd,
    onTap: (BuildContext context) {
      navigateToSeaZonePage(context);
    },
    category: 'ticket',
    description:
        "Dive into the Underwater Paradise, an extraordinary dining experience surrounded by enormous aquarium walls. Enjoy your meal while gazing at the mesmerizing marine life swimming around you. The soothing blue hues and exotic underwater scenery make this zone a serene and unique place to dine, offering a one-of-a-kind experience that feels like being beneath the ocean's surface.",
    zone: 'sea',
  ),
  Zone(
    image: 'assets/zone/skysanctuary.jpg',
    title: 'Sky Sanctuary',
    priceStart: priceStart,
    priceEnd: priceEnd,
    onTap: (BuildContext context) {
      navigateToBirdZonePage(context);
    },
    category: 'ticket',
    description:
        'Elevate your senses at the Sky Sanctuary, a breathtaking dining adventure suspended high above the ground. This sky-high restaurant offers stunning views and a thrilling experience as you enjoy gourmet meals in the open air. Ideal for thrill-seekers and those looking for a dining experience like no other, the Sky Sanctuary combines culinary delight with adrenaline-pumping heights.',
    zone: 'bird',
  ),
  Zone(
    image: 'assets/zone/spookyforest.jpg',
    title: 'Spooky Forest',
    priceStart: priceStart,
    priceEnd: priceEnd,
    onTap: (BuildContext context) {
      navigateToForestZonePage(context);
    },
    category: 'ticket',
    description:
        'Step into the Spooky Forest, a magical realm where vibrant, glowing mushrooms illuminate the night. Wander through a captivating landscape filled with whimsical lights and enchanting decorations that create an otherworldly experience. Perfect for those seeking an immersive escape into a fantasy world, this zone promises to transport you to a land of wonder and awe.',
    zone: 'forest',
  ),
  Zone(
    image: 'assets/zone/koilane.jpg',
    title: 'Koi Lane',
    priceStart: priceStart,
    priceEnd: priceEnd,
    onTap: (BuildContext context) {},
    category: 'ticket',
    description:
        'Step into the serene and colorful world of Koi Lane, a tranquil zone featuring vibrant koi ponds lined with rainbow-colored umbrellas. Here, you can feed the beautiful koi fish and enjoy the soothing ambiance of flowing water, making it a perfect spot for relaxation and contemplation.',
    zone: 'koi',
  ),
  Zone(
    image: 'assets/zone/piratesgalley.jpg',
    title: "Pirate's Galley",
    priceStart: priceStart,
    priceEnd: priceEnd,
    onTap: (BuildContext context) {},
    category: 'ticket',
    description:
        "Embark on a nautical adventure at Pirate's Galley, a restaurant designed like a grand pirate ship overlooking a stunning lake. With panoramic views of the surrounding landscape, this elevated dining area offers a unique experience where guests can enjoy delicious meals while feeling like they are sailing the high seas.",
    zone: 'pirates',
  ),
];
