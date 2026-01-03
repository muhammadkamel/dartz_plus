import 'package:dartz_plus/dartz_plus.dart';
import 'package:source_gen_test/source_gen_test.dart';

@ShouldGenerate(r'''
extension HappyPathModelToHappyPathEntityMapper on HappyPathModel {
  HappyPathEntity toHappyPathEntity() {
    return HappyPathEntity(name: name, age: age);
  }
}

extension HappyPathEntityToHappyPathModelMapper on HappyPathEntity {
  HappyPathModel toHappyPathModel() {
    return HappyPathModel(name: name, age: age);
  }
}
''')
@Mapper(HappyPathEntity)
class HappyPathModel {
  HappyPathModel({required this.name, required this.age});
  final String name;
  final int age;
}

class HappyPathEntity {
  HappyPathEntity({required this.name, required this.age});
  final String name;
  final int age;
}

@ShouldGenerate(r'''
extension SmartResolutionModelToSmartResolutionEntityMapper
    on SmartResolutionModel {
  SmartResolutionEntity toSmartResolutionEntity() {
    return SmartResolutionEntity(name: name);
  }
}

extension SmartResolutionEntityToSmartResolutionModelMapper
    on SmartResolutionEntity {
  SmartResolutionModel toSmartResolutionModel() {
    return SmartResolutionModel(name: name);
  }
}
''')
@Mapper(SmartResolutionEntity)
class SmartResolutionModel {
  SmartResolutionModel({required this.name});
  final String name;
}

class SmartResolutionEntity {
  SmartResolutionEntity({required this.name, this.bio, this.email = ''});
  final String name;
  final String? bio;
  final String email;
}

class SmartResolutionEntityRefined {
  SmartResolutionEntityRefined(this.name, {this.optional, this.nullable});
  final String name;
  final String? optional;
  final String? nullable;
}

@ShouldGenerate(r'''
extension SmartResolutionModel2ToSmartResolutionEntityRefinedMapper
    on SmartResolutionModel2 {
  SmartResolutionEntityRefined toSmartResolutionEntityRefined() {
    return SmartResolutionEntityRefined(name);
  }
}

extension SmartResolutionEntityRefinedToSmartResolutionModel2Mapper
    on SmartResolutionEntityRefined {
  SmartResolutionModel2 toSmartResolutionModel2() {
    return SmartResolutionModel2(name);
  }
}
''')
@Mapper(SmartResolutionEntityRefined)
class SmartResolutionModel2 {
  SmartResolutionModel2(this.name);
  final String name;
}

@ShouldThrow(
  'Could not find matching field or constructor parameter for required parameter "age" in FailureModel while mapping to FailureEntity',
)
@Mapper(FailureEntity)
class FailureModel {
  FailureModel(this.name);
  final String name;
}

class FailureEntity {
  FailureEntity(this.name, this.age);
  final String name;
  final int age;
}

@ShouldGenerate(r'''
extension InheritanceModelToInheritanceEntityMapper on InheritanceModel {
  InheritanceEntity toInheritanceEntity() {
    return InheritanceEntity(id: id, name: name);
  }
}

extension InheritanceEntityToInheritanceModelMapper on InheritanceEntity {
  InheritanceModel toInheritanceModel() {
    return InheritanceModel(id: id, name: name);
  }
}
''')
@Mapper(InheritanceEntity)
class InheritanceModel extends BaseModel {
  InheritanceModel({required super.id, required this.name});
  final String name;
}

class BaseModel {
  BaseModel({required this.id});
  final String id;
}

class InheritanceEntity {
  InheritanceEntity({required this.id, required this.name});
  final String id;
  final String name;
}

@ShouldGenerate(r'''
extension ReverseFalseModelToReverseFalseEntityMapper on ReverseFalseModel {
  ReverseFalseEntity toReverseFalseEntity() {
    return ReverseFalseEntity(name: name);
  }
}
''')
@Mapper(ReverseFalseEntity, reverse: false)
class ReverseFalseModel {
  ReverseFalseModel(this.name);
  final String name;
}

class ReverseFalseEntity {
  ReverseFalseEntity({required this.name});
  final String name;
}

@ShouldGenerate(r'''
extension PositionalModelToPositionalEntityMapper on PositionalModel {
  PositionalEntity toPositionalEntity() {
    return PositionalEntity(name);
  }
}

extension PositionalEntityToPositionalModelMapper on PositionalEntity {
  PositionalModel toPositionalModel() {
    return PositionalModel(name);
  }
}
''')
@Mapper(PositionalEntity)
class PositionalModel {
  PositionalModel(this.name);
  final String name;
}

class PositionalEntity {
  PositionalEntity(this.name);
  final String name;
}

@ShouldThrow('@Mapper can only be applied to classes.')
@Mapper(ReverseFalseEntity)
enum EnumMapper { A, B }

@ShouldThrow('Target class int must have a default (unnamed) constructor.')
@Mapper(int)
class InvalidTargetTypeModel {}

@ShouldThrow(
  'Target class NoCtorEntity must have a default (unnamed) constructor.',
)
@Mapper(NoCtorEntity)
class NoCtorModel {
  NoCtorModel(this.name);
  final String name;
}

class NoCtorEntity {
  NoCtorEntity.named();
}

// -----------------------------------------------------------------------------
// NEW: FREEZED-LIKE TEST (MOCKING FREEZED STRUCTURE)
// -----------------------------------------------------------------------------
@ShouldGenerate(r'''
extension FreezedSourceModelToFreezedSourceEntityMapper on FreezedSourceModel {
  FreezedSourceEntity toFreezedSourceEntity() {
    return FreezedSourceEntity(id: id, name: name);
  }
}

extension FreezedSourceEntityToFreezedSourceModelMapper on FreezedSourceEntity {
  FreezedSourceModel toFreezedSourceModel() {
    return FreezedSourceModel(id: id, name: name);
  }
}
''')
@Mapper(FreezedSourceEntity)
class FreezedSourceModel {
  // Freezed classes have a factory constructor and properties are usually
  // getters. In our generator we check the factory constructor parameters
  // if fields are missing.
  factory FreezedSourceModel({required int id, required String name}) =
      _FreezedSourceModel;

  // These getters would be generated by Freezed
  int get id => 0;
  String get name => '';
}

class _FreezedSourceModel implements FreezedSourceModel {
  _FreezedSourceModel({required this.id, required this.name});
  @override
  final int id;
  @override
  final String name;
}

class FreezedSourceEntity {
  FreezedSourceEntity({required this.id, required this.name});
  final int id;
  final String name;
}

// -----------------------------------------------------------------------------
// NEW: NESTED MAPPING TEST
// -----------------------------------------------------------------------------
@ShouldGenerate(r'''
extension NestedModelToNestedEntityMapper on NestedModel {
  NestedEntity toNestedEntity() {
    return NestedEntity(
      id: id,
      item: item.toNestedItemEntity(),
      items: items.map((e) => e.toNestedItemEntity()).toList(),
    );
  }
}

extension NestedEntityToNestedModelMapper on NestedEntity {
  NestedModel toNestedModel() {
    return NestedModel(
      id: id,
      item: item.toNestedItemModel(),
      items: items.map((e) => e.toNestedItemModel()).toList(),
    );
  }
}
''')
@Mapper(NestedEntity)
class NestedModel {
  NestedModel({required this.id, required this.item, required this.items});
  final int id;
  final NestedItemModel item;
  final List<NestedItemModel> items;
}

class NestedEntity {
  NestedEntity({required this.id, required this.item, required this.items});
  final int id;
  final NestedItemEntity item;
  final List<NestedItemEntity> items;
}

class NestedItemModel {
  NestedItemModel(this.name);
  final String name;
}

class NestedItemEntity {
  NestedItemEntity(this.name);
  final String name;
}

// -----------------------------------------------------------------------------
// NEW: NAMED TARGET TEST
// -----------------------------------------------------------------------------
@ShouldGenerate(r'''
extension NamedTargetModelToNamedTargetEntityMapper on NamedTargetModel {
  NamedTargetEntity toNamedTargetEntity() {
    return NamedTargetEntity(name: name);
  }
}

extension NamedTargetEntityToNamedTargetModelMapper on NamedTargetEntity {
  NamedTargetModel toNamedTargetModel() {
    return NamedTargetModel(name);
  }
}
''')
@Mapper(NamedTargetEntity)
class NamedTargetModel {
  NamedTargetModel(this.name);
  final String name;
}

class NamedTargetEntity {
  NamedTargetEntity({required this.name});
  final String name;
}

// -----------------------------------------------------------------------------
// NEW: MIXED CONSTRUCTOR PARAMETERS TEST
// -----------------------------------------------------------------------------
@ShouldGenerate(r'''
extension MixedCtorModelToMixedCtorEntityMapper on MixedCtorModel {
  MixedCtorEntity toMixedCtorEntity() {
    return MixedCtorEntity(id, name: name);
  }
}

extension MixedCtorEntityToMixedCtorModelMapper on MixedCtorEntity {
  MixedCtorModel toMixedCtorModel() {
    return MixedCtorModel(id: id, name: name);
  }
}
''')
@Mapper(MixedCtorEntity)
class MixedCtorModel {
  MixedCtorModel({required this.id, required this.name});
  final int id;
  final String name;
}

class MixedCtorEntity {
  MixedCtorEntity(this.id, {required this.name});
  final int id;
  final String name;
}

// -----------------------------------------------------------------------------
// NEW: @MapTo TEST
// -----------------------------------------------------------------------------
@ShouldGenerate(r'''
extension MapToModelToMapToEntityMapper on MapToModel {
  MapToEntity toMapToEntity() {
    return MapToEntity(fullName: name);
  }
}

extension MapToEntityToMapToModelMapper on MapToEntity {
  MapToModel toMapToModel() {
    return MapToModel(name: fullName);
  }
}
''')
@Mapper(MapToEntity)
class MapToModel {
  MapToModel({required this.name});
  @MapTo('fullName')
  final String name;
}

class MapToEntity {
  MapToEntity({required this.fullName});
  final String fullName;
}

// -----------------------------------------------------------------------------
// NEW: @IgnoreMap TEST
// -----------------------------------------------------------------------------
@ShouldGenerate(r'''
extension IgnoreMapModelToIgnoreMapEntityMapper on IgnoreMapModel {
  IgnoreMapEntity toIgnoreMapEntity() {
    return IgnoreMapEntity(name: name);
  }
}

extension IgnoreMapEntityToIgnoreMapModelMapper on IgnoreMapEntity {
  IgnoreMapModel toIgnoreMapModel() {
    return IgnoreMapModel(name: name);
  }
}
''')
@Mapper(IgnoreMapEntity)
class IgnoreMapModel {
  IgnoreMapModel({required this.name, this.secret});
  final String name;
  @IgnoreMap()
  final String? secret;
}

class IgnoreMapEntity {
  IgnoreMapEntity({required this.name});
  final String name;
}

// -----------------------------------------------------------------------------
// NEW: CUSTOM CONSTRUCTOR TEST
// -----------------------------------------------------------------------------
@ShouldGenerate(r'''
extension CustomCtorModelToCustomCtorEntityMapper on CustomCtorModel {
  CustomCtorEntity toCustomCtorEntity() {
    return CustomCtorEntity.named(name: name);
  }
}

extension CustomCtorEntityToCustomCtorModelMapper on CustomCtorEntity {
  CustomCtorModel toCustomCtorModel() {
    return CustomCtorModel(name: name);
  }
}
''')
@Mapper(CustomCtorEntity, constructor: 'named')
class CustomCtorModel {
  CustomCtorModel({required this.name});
  final String name;
}

class CustomCtorEntity {
  CustomCtorEntity.named({required this.name});
  final String name;
}

// -----------------------------------------------------------------------------
// NEW: COMPLEX MAPPINGS (RENAMES, IGNORES, CUSTOM CTOR)
// -----------------------------------------------------------------------------
@ShouldGenerate(r'''
extension ComplexModelToComplexEntityMapper on ComplexModel {
  ComplexEntity toComplexEntity() {
    return ComplexEntity.fromDto(fullName: name, status: status);
  }
}

extension ComplexEntityToComplexModelMapper on ComplexEntity {
  ComplexModel toComplexModel() {
    return ComplexModel(name: fullName, status: status);
  }
}
''')
@Mapper(ComplexEntity, constructor: 'fromDto')
class ComplexModel {
  ComplexModel({required this.name, required this.status, this.internalId});

  @MapTo('fullName')
  final String name;

  final int status;

  @IgnoreMap()
  final String? internalId;
}

class ComplexEntity {
  ComplexEntity.fromDto({required this.fullName, required this.status});
  final String fullName;
  final int status;
}
