import 'package:json_annotation/json_annotation.dart';
part 'test.g.dart';
@JsonSerializable()
class TestDTO{
  final String cover;
  final String question;
  final List<String> answer;
  final int rightanswer; 
  TestDTO(this.cover, this.question, this.answer, this.rightanswer);
  Map<String, dynamic> toJson() => _$TestDTOToJson(this);
  factory TestDTO.fromJson(Map<String, dynamic> json) => _$TestDTOFromJson(json);
  }
    
