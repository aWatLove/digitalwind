import 'package:dw/shared/lib/JsonRepository/json_serializable.dart';

class DescriptionBlock extends JsonSerializable {
  final String text;
  final String cover;
  DescriptionBlock(this.text, this.cover);
  @override
  Map<String, dynamic> toJson() {
    return {'text':text, 'cover':cover};
  }

}