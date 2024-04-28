// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestDTO _$TestDTOFromJson(Map<String, dynamic> json) => TestDTO(
      json['cover'] as String,
      json['question'] as String,
      (json['answer'] as List<dynamic>).map((e) => e as String).toList(),
      (json['rightanswer'] as num).toInt(),
    );

Map<String, dynamic> _$TestDTOToJson(TestDTO instance) => <String, dynamic>{
      'cover': instance.cover,
      'question': instance.question,
      'answer': instance.answer,
      'rightanswer': instance.rightanswer,
    };
