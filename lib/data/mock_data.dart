import '../models/place.dart';

class MockData {
  static const places = <Place>[
    Place(
      id: 'mah',
      title: 'Mahasthangarh',
      location: 'Shibgonj, Bogra',
      likes: 12,
      imageUrl:
          'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=1400&q=80',
    ),
    Place(
      id: 'somp',
      title: 'Somapura Mahavihara',
      location: 'Badalgachhi, Naogaon',
      likes: 14,
      imageUrl:
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1400&q=80',
    ),
    Place(
      id: 'saj',
      title: 'Sajek Valley',
      location: 'Sajek, Rangamati',
      likes: 17,
      imageUrl:
          'https://images.unsplash.com/photo-1500375592092-40eb2168fd21?auto=format&fit=crop&w=1400&q=80',
    ),
    Place(
      id: 'boga',
      title: 'Boga Lake',
      location: 'Ruma, Bandarban',
      likes: 10,
      imageUrl:
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?auto=format&fit=crop&w=1400&q=80',
    ),
    Place(
      id: 'sund',
      title: 'Sundarban',
      location: 'Mangrove Forest',
      likes: 10,
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1400&q=80',
    ),
  ];
}
