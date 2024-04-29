import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class DescriptionBlock  {
  final String text;
  final String cover;
  final String header;
  DescriptionBlock(this.text, this.cover, this.header);
  Map<String, dynamic> toJson() {
    return {
      'text':text as String,
      'cover':cover as String,
      'header':header as String
    };
  }
  factory DescriptionBlock.fromJson(Map<String, dynamic> json) {
    return DescriptionBlock(json['text'] as String, json['cover'] as String, json['header'] as String);
  }
}