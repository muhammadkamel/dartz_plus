import 'package:dartz_plus_generator/annotations.dart';
import 'package:dartz_plus_generator/src/mapper_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';
import 'package:source_gen_test/src/init_library_reader.dart';

Future<void> main() async {
  final PathAwareLibraryReader reader =
      await initializeLibraryReaderForDirectory('test/src', 'test_inputs.dart');

  initializeBuildLogTracking();
  testAnnotatedElements<Mapper>(reader, MapperGenerator());
}
