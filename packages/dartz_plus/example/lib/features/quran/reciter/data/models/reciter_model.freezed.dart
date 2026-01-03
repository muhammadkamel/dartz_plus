// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reciter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReciterModel {

 int get id; String get name; String get letter; String get date; MoshafModel get moshaf;
/// Create a copy of ReciterModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReciterModelCopyWith<ReciterModel> get copyWith => _$ReciterModelCopyWithImpl<ReciterModel>(this as ReciterModel, _$identity);

  /// Serializes this ReciterModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReciterModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.letter, letter) || other.letter == letter)&&(identical(other.date, date) || other.date == date)&&(identical(other.moshaf, moshaf) || other.moshaf == moshaf));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,letter,date,moshaf);

@override
String toString() {
  return 'ReciterModel(id: $id, name: $name, letter: $letter, date: $date, moshaf: $moshaf)';
}


}

/// @nodoc
abstract mixin class $ReciterModelCopyWith<$Res>  {
  factory $ReciterModelCopyWith(ReciterModel value, $Res Function(ReciterModel) _then) = _$ReciterModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String letter, String date, MoshafModel moshaf
});


$MoshafModelCopyWith<$Res> get moshaf;

}
/// @nodoc
class _$ReciterModelCopyWithImpl<$Res>
    implements $ReciterModelCopyWith<$Res> {
  _$ReciterModelCopyWithImpl(this._self, this._then);

  final ReciterModel _self;
  final $Res Function(ReciterModel) _then;

/// Create a copy of ReciterModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? letter = null,Object? date = null,Object? moshaf = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,letter: null == letter ? _self.letter : letter // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,moshaf: null == moshaf ? _self.moshaf : moshaf // ignore: cast_nullable_to_non_nullable
as MoshafModel,
  ));
}
/// Create a copy of ReciterModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoshafModelCopyWith<$Res> get moshaf {
  
  return $MoshafModelCopyWith<$Res>(_self.moshaf, (value) {
    return _then(_self.copyWith(moshaf: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReciterModel].
extension ReciterModelPatterns on ReciterModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReciterModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReciterModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReciterModel value)  $default,){
final _that = this;
switch (_that) {
case _ReciterModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReciterModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReciterModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String letter,  String date,  MoshafModel moshaf)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReciterModel() when $default != null:
return $default(_that.id,_that.name,_that.letter,_that.date,_that.moshaf);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String letter,  String date,  MoshafModel moshaf)  $default,) {final _that = this;
switch (_that) {
case _ReciterModel():
return $default(_that.id,_that.name,_that.letter,_that.date,_that.moshaf);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String letter,  String date,  MoshafModel moshaf)?  $default,) {final _that = this;
switch (_that) {
case _ReciterModel() when $default != null:
return $default(_that.id,_that.name,_that.letter,_that.date,_that.moshaf);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReciterModel implements ReciterModel {
  const _ReciterModel({required this.id, required this.name, required this.letter, required this.date, required this.moshaf});
  factory _ReciterModel.fromJson(Map<String, dynamic> json) => _$ReciterModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String letter;
@override final  String date;
@override final  MoshafModel moshaf;

/// Create a copy of ReciterModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReciterModelCopyWith<_ReciterModel> get copyWith => __$ReciterModelCopyWithImpl<_ReciterModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReciterModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReciterModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.letter, letter) || other.letter == letter)&&(identical(other.date, date) || other.date == date)&&(identical(other.moshaf, moshaf) || other.moshaf == moshaf));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,letter,date,moshaf);

@override
String toString() {
  return 'ReciterModel(id: $id, name: $name, letter: $letter, date: $date, moshaf: $moshaf)';
}


}

/// @nodoc
abstract mixin class _$ReciterModelCopyWith<$Res> implements $ReciterModelCopyWith<$Res> {
  factory _$ReciterModelCopyWith(_ReciterModel value, $Res Function(_ReciterModel) _then) = __$ReciterModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String letter, String date, MoshafModel moshaf
});


@override $MoshafModelCopyWith<$Res> get moshaf;

}
/// @nodoc
class __$ReciterModelCopyWithImpl<$Res>
    implements _$ReciterModelCopyWith<$Res> {
  __$ReciterModelCopyWithImpl(this._self, this._then);

  final _ReciterModel _self;
  final $Res Function(_ReciterModel) _then;

/// Create a copy of ReciterModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? letter = null,Object? date = null,Object? moshaf = null,}) {
  return _then(_ReciterModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,letter: null == letter ? _self.letter : letter // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,moshaf: null == moshaf ? _self.moshaf : moshaf // ignore: cast_nullable_to_non_nullable
as MoshafModel,
  ));
}

/// Create a copy of ReciterModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MoshafModelCopyWith<$Res> get moshaf {
  
  return $MoshafModelCopyWith<$Res>(_self.moshaf, (value) {
    return _then(_self.copyWith(moshaf: value));
  });
}
}

// dart format on
