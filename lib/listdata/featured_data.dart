import 'package:uas/models/FeaturedCardData.dart';

final int priceStart = 200000;
final int priceEnd = 300000;

final List<FeaturedCardData> featured = [
  FeaturedCardData(
      title: 'Underwater Paradise',
      imageUrl: 'assets/zone/underwaterparadise.jpg',
      priceStart: priceStart,
      priceEnd: priceEnd,
      description:
          "Dive into the Underwater Paradise, an extraordinary dining experience surrounded by enormous aquarium walls. Enjoy your meal while gazing at the mesmerizing marine life swimming around you. The soothing blue hues and exotic underwater scenery make this zone a serene and unique place to dine, offering a one-of-a-kind experience that feels like being beneath the ocean's surface.",
      zone: 'sea',
      category: 'ticket'),
  FeaturedCardData(
      title: 'Spooky Forest',
      imageUrl: 'assets/zone/spookyforest.jpg',
      priceStart: priceStart,
      priceEnd: priceEnd,
      description:
          'Step into the Spooky Forest, a magical realm where vibrant, glowing mushrooms illuminate the night. Wander through a captivating landscape filled with whimsical lights and enchanting decorations that create an otherworldly experience. Perfect for those seeking an immersive escape into a fantasy world, this zone promises to transport you to a land of wonder and awe.',
      zone: 'forest',
      category: 'ticket'),
  FeaturedCardData(
      title: 'Sky Sanctuary',
      imageUrl: 'assets/zone/skysanctuary.jpg',
      priceStart: priceStart,
      priceEnd: priceEnd,
      description:
          'Elevate your senses at the Sky Sanctuary, a breathtaking dining adventure suspended high above the ground. This sky-high restaurant offers stunning views and a thrilling experience as you enjoy gourmet meals in the open air. Ideal for thrill-seekers and those looking for a dining experience like no other, the Sky Sanctuary combines culinary delight with adrenaline-pumping heights.',
      zone: 'bird',
      category: 'ticket'),
];
