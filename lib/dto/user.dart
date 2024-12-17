import 'package:plimsy/dto/host.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserDTO {
  int id;
  String login;
  String firstName;
  String lastName;
  String email;
  List<HostDTO> hosts;
  // String? sessionId;
  // String? csrfToken;

  UserDTO({
    required this.id,
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.hosts,
    // this.sessionId,
    // this.csrfToken
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}
