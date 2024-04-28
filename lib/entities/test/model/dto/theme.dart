import 'package:dw/entities/test/model/dto/description_block.dart';
import 'package:dw/entities/test/model/dto/test_dto.dart';
import 'package:dw/shared/lib/JsonRepository/json_serializable.dart';
class ThemeDTO extends JsonSerializable {
  final int id;
  final String cover;
  final String title;
  final List<DescriptionBlock> description_blocks;
  final List<TestDTO> test;
  ThemeDTO(this.id, this.cover, this.test, this.title, this.description_blocks);
  @override
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'cover':cover,
      'title':title,
      'description_blocks':description_blocks.map((e) => e.toJson()),
      'test':test.map((e) => e.toJson()),
    };
  }
}