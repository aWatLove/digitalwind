import 'package:dw/shared/lib/JsonRepository/json_serializable.dart';

class TestDTO extends JsonSerializable{
  final String cover;
  final String question;
  final List<String> answer;
  final int rightAnswer; 
  TestDTO(this.cover, this.question, this.answer, this.rightAnswer);
  @override
  Map<String, dynamic> toJson() {
    return {
      'cover':cover,
      'question':question,
      'answer':answer,
      'rightAnswer':rightAnswer
    };
  }
    
}