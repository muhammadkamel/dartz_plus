import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/mapper_generator.dart';

/// Builder factory for the MapperGenerator.
Builder mapperBuilder(BuilderOptions options) =>
    PartBuilder([MapperGenerator()], '.g.dart');
