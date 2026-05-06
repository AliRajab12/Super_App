import 'package:freezed_annotation/freezed_annotation.dart';
part 'SuperApp_service.freezed.dart';
part 'SuperApp_service.g.dart';

@freezed
class SuperAppService with _$SuperAppService {
  factory SuperAppService({
    @Default('') String name,
    @Default('') String imageUrl,
  }) = _SuperAppService;

  factory SuperAppService.fromJson(Map<String, dynamic> json) =>
      _$SuperAppServiceFromJson(json);
}

List<SuperAppService> services = [
  SuperAppService(
    name: 'Car Rental',
    imageUrl: 'images/services/car_rental.svg',
  ),
  SuperAppService(
    name: 'Tourist Visa',
    imageUrl: 'images/services/visa.svg',
  ),
  SuperAppService(
    name: 'Legal Typing',
    imageUrl: 'images/services/typing.svg',
  ),
  SuperAppService(
    name: 'Online Clinic',
    imageUrl: 'images/services/online_clinic.svg',
  ),
  SuperAppService(
    name: 'Groceries',
    imageUrl: 'images/services/groceries.svg',
  ),
  SuperAppService(
    name: 'Food',
    imageUrl: 'images/services/food.svg',
  ),
  SuperAppService(
    name: 'Salon',
    imageUrl: 'images/services/salon.svg',
  ),
  SuperAppService(
    name: 'Roadside\nAssistance',
    imageUrl: 'images/services/road_assist.svg',
  ),
];
