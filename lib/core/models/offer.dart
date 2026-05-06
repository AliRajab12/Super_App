import 'package:freezed_annotation/freezed_annotation.dart';
part 'offer.freezed.dart';
part 'offer.g.dart';

@freezed
class Offer with _$Offer {
  factory Offer({
    @Default('') String id,
    @Default('') String imageUrl,
    @Default('') String linkUrl,
  }) = _Offer;

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
}

List<Offer> offers = [
  Offer(
    id: '1',
    imageUrl: 'images/offer1.png',
    linkUrl: 'images/d1.png',
  ),
  Offer(
    id: '2',
    imageUrl: 'images/offer2.png',
    linkUrl: 'images/d1.png',
  ),
  Offer(
    id: '3',
    imageUrl: 'images/offer1.png',
    linkUrl: 'images/d1.png',
  ),
  Offer(
    id: '4',
    imageUrl: 'images/offer2.png',
    linkUrl: 'images/d1.png',
  ),
  Offer(
    id: '5',
    imageUrl: 'images/offer1.png',
    linkUrl: 'images/d1.png',
  ),
];
