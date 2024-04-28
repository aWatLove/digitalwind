import 'package:dw/shared/lib/JsonRepository/json_serializable.dart';

class ThemeDTO extends JsonSerializable {
  final int id;
  ThemeDTO(this.id);
  @override
  Map<String, dynamic> toJson() {
    return {
      'id':id
    };
  }
  

}