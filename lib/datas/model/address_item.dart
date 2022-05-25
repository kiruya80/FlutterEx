import 'package:json_annotation/json_annotation.dart';

part 'address_item.g.dart';

/**
 * 위의 코드를 작성하고 터미널에서 flutter pub run build_runner build 실행하면
 * 동일 경로에 user.g.dart 에 code generation 이 생성된다.
 * 일회성이 아닌 지속적인 변경 감지를 위해 watch 모드를 실행하면 된다
 * flutter pub run build_runner watch 실행
 */
@JsonSerializable()
class Address {
  // @JsonKey(name: 'registration_date_millis')
  // final int registrationDateMillis;
  String street;
  String city;

  Address(this.street, this.city);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
