
import 'package:dw/entities/test/model/tests_repo.dart';
import 'package:dw/screens/Test/test_screen.dart';
import 'package:flutter/material.dart';

class TestScreenWidgetState extends State<TestScreen> {
  TestScreenWidgetState(this.version);
 
  /// notify change state without deep clone state
  final int version;
  @override
  List<TestsRepo> get props => [version];
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

