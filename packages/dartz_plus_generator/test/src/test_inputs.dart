import 'package:dartz_plus/dartz_plus.dart';
import 'package:source_gen_test/source_gen_test.dart';

@ShouldGenerate(
  r'''
extension HappyPathDtoToHappyPathEntityMapper on HappyPathDto {
  HappyPathEntity toHappyPathEntity() {
    return HappyPathEntity(name: name, age: age);
  }
}

extension HappyPathEntityToHappyPathDtoMapper on HappyPathEntity {
  HappyPathDto toHappyPathDto() {
    return HappyPathDto(name: name, age: age);
  }
}
''',
)
@Mapper(HappyPathEntity)
class HappyPathDto {
  HappyPathDto({required this.name, required this.age});
  final String name;
  final int age;
}

class HappyPathEntity {
  HappyPathEntity({required this.name, required this.age});
  final String name;
  final int age;
}

@ShouldGenerate(
  r'''
extension SmartResolutionDtoToSmartResolutionEntityMapper
    on SmartResolutionDto {
  SmartResolutionEntity toSmartResolutionEntity() {
    return SmartResolutionEntity(name: name);
  }
}

extension SmartResolutionEntityToSmartResolutionDtoMapper
    on SmartResolutionEntity {
  SmartResolutionDto toSmartResolutionDto() {
    return SmartResolutionDto(name: name);
  }
}
''',
)
@Mapper(SmartResolutionEntity)
class SmartResolutionDto {
  // Missing 'bio' (optional) and 'email' (nullable)
  SmartResolutionDto({required this.name});
  final String name;
}

class SmartResolutionEntity {
  // email is nullable via default value or null? no email is just string but nullable type
  // Wait, email is 'test field', let's make it explicitly nullable or optional in constructor.

  SmartResolutionEntity({required this.name, this.bio, this.email = ''});
  final String name;
  final String? bio;
  final String email;
  // Wait, my smart resolution checks param.isOptional || param.type.isNullable (renamed to nullability check)

  /*
  Let's refine SmartResolutionEntity to test both cases:
  1. Named Optional: {this.optional}
  2. Nullable Position: String? nullable
  */
}

class SmartResolutionEntityRefined {
  SmartResolutionEntityRefined(this.name, {this.optional, this.nullable});
  final String name;
  final String? optional;
  final String? nullable;
}

@ShouldGenerate(
  r'''
extension SmartResolutionDto2ToSmartResolutionEntityRefinedMapper
    on SmartResolutionDto2 {
  SmartResolutionEntityRefined toSmartResolutionEntityRefined() {
    return SmartResolutionEntityRefined(name);
  }
}

extension SmartResolutionEntityRefinedToSmartResolutionDto2Mapper
    on SmartResolutionEntityRefined {
  SmartResolutionDto2 toSmartResolutionDto2() {
    return SmartResolutionDto2(name);
  }
}
''',
)
@Mapper(SmartResolutionEntityRefined)
class SmartResolutionDto2 {
  SmartResolutionDto2(this.name);
  final String name;
}

@ShouldThrow(
    'Could not find matching field for required parameter "age" in FailureDto while mapping to FailureEntity')
@Mapper(FailureEntity)
class FailureDto {
  FailureDto(this.name);
  final String name;
}

class FailureEntity {
  // Required and missing in Dto
  FailureEntity(this.name, this.age);
  final String name;
  final int age;
}

// -----------------------------------------------------------------------------
// INHERITANCE TEST
// -----------------------------------------------------------------------------
@ShouldGenerate(
  r'''
extension InheritanceDtoToInheritanceEntityMapper on InheritanceDto {
  InheritanceEntity toInheritanceEntity() {
    return InheritanceEntity(id: id, name: name);
  }
}

extension InheritanceEntityToInheritanceDtoMapper on InheritanceEntity {
  InheritanceDto toInheritanceDto() {
    return InheritanceDto(id: id, name: name);
  }
}
''',
)
@Mapper(InheritanceEntity)
class InheritanceDto extends BaseDto {
  InheritanceDto({required super.id, required this.name});
  final String name;
}

class BaseDto {
  BaseDto({required this.id});
  final String id;
}

class InheritanceEntity {
  InheritanceEntity({required this.id, required this.name});
  final String id;
  final String name;
}

// -----------------------------------------------------------------------------
// REVERSE = FALSE TEST
// -----------------------------------------------------------------------------
@ShouldGenerate(
  r'''
extension ReverseFalseDtoToReverseFalseEntityMapper on ReverseFalseDto {
  ReverseFalseEntity toReverseFalseEntity() {
    return ReverseFalseEntity(name: name);
  }
}
''',
)
@Mapper(ReverseFalseEntity, reverse: false)
class ReverseFalseDto {
  ReverseFalseDto(this.name);
  final String name;
}

class ReverseFalseEntity {
  ReverseFalseEntity({required this.name});
  final String name;
}

// -----------------------------------------------------------------------------
// POSITIONAL PARAMETERS TEST
// -----------------------------------------------------------------------------
@ShouldGenerate(
  r'''
extension PositionalDtoToPositionalEntityMapper on PositionalDto {
  PositionalEntity toPositionalEntity() {
    return PositionalEntity(name);
  }
}

extension PositionalEntityToPositionalDtoMapper on PositionalEntity {
  PositionalDto toPositionalDto() {
    return PositionalDto(name);
  }
}
''',
)
@Mapper(PositionalEntity)
class PositionalDto {
  PositionalDto(this.name);
  final String name;
}

class PositionalEntity {
  PositionalEntity(this.name);
  final String name; // Positional
}

// -----------------------------------------------------------------------------
// ERROR: NON-CLASS ELEMENT (ENUM)
// -----------------------------------------------------------------------------
@ShouldThrow('@Mapper can only be applied to classes.')
@Mapper(ReverseFalseEntity)
enum EnumMapper { A, B }

// -----------------------------------------------------------------------------
// ERROR: TARGET IS NOT A CLASS
// -----------------------------------------------------------------------------
@ShouldThrow('Target class int must have a default (unnamed) constructor.')
@Mapper(int)
class InvalidTargetTypeDto {}

// -----------------------------------------------------------------------------
// ERROR: TARGET NO DEFAULT CONSTRUCTOR
// -----------------------------------------------------------------------------
@ShouldThrow(
    'Target class NoCtorEntity must have a default (unnamed) constructor.')
@Mapper(NoCtorEntity)
class NoCtorDto {
  NoCtorDto(this.name);
  final String name;
}

class NoCtorEntity {
  NoCtorEntity.named();
}
