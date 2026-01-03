// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moshaf_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MoshafModel {

 int get id; String get name; String get server;@JsonKey(name: 'surah_total') int get surahTotal;@JsonKey(name: 'moshaf_type') int get moshafType;@JsonKey(name: 'surah_list') String get surahList;
/// Create a copy of MoshafModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoshafModelCopyWith<MoshafModel> get copyWith => _$MoshafModelCopyWithImpl<MoshafModel>(this as MoshafModel, _$identity);

  /// Serializes this MoshafModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoshafModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.server, server) || other.server == server)&&(identical(other.surahTotal, surahTotal) || other.surahTotal == surahTotal)&&(identical(other.moshafType, moshafType) || other.moshafType == moshafType)&&(identical(other.surahList, surahList) || other.surahList == surahList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,server,surahTotal,moshafType,surahList);

@override
String toString() {
  return 'MoshafModel(id: $id, name: $name, server: $server, surahTotal: $surahTotal, moshafType: $moshafType, surahList: $surahList)';
}


}

/// @nodoc
abstract mixin class $MoshafModelCopyWith<$Res>  {
  factory $MoshafModelCopyWith(MoshafModel value, $Res Function(MoshafModel) _then) = _$MoshafModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String server,@JsonKey(name: 'surah_total') int surahTotal,@JsonKey(name: 'moshaf_type') int moshafType,@JsonKey(name: 'surah_list') String surahList
});




}
/// @nodoc
class _$MoshafModelCopyWithImpl<$Res>
    implements $MoshafModelCopyWith<$Res> {
  _$MoshafModelCopyWithImpl(this._self, this._then);

  final MoshafModel _self;
  final $Res Function(MoshafModel) _then;

/// Create a copy of MoshafModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? server = null,Object? surahTotal = null,Object? moshafType = null,Object? surahList = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,server: null == server ? _self.server : server // ignore: cast_nullable_to_non_nullable
as String,surahTotal: null == surahTotal ? _self.surahTotal : surahTotal // ignore: cast_nullable_to_non_nullable
as int,moshafType: null == moshafType ? _self.moshafType : moshafType // ignore: cast_nullable_to_non_nullable
as int,surahList: null == surahList ? _self.surahList : surahList // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MoshafModel].
extension MoshafModelPatterns on MoshafModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoshafModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoshafModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoshafModel value)  $default,){
final _that = this;
switch (_that) {
case _MoshafModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoshafModel value)?  $default,){
final _that = this;
switch (_that) {
case _MoshafModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String server, @JsonKey(name: 'surah_total')  int surahTotal, @JsonKey(name: 'moshaf_type')  int moshafType, @JsonKey(name: 'surah_list')  String surahList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoshafModel() when $default != null:
return $default(_that.id,_that.name,_that.server,_that.surahTotal,_that.moshafType,_that.surahList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String server, @JsonKey(name: 'surah_total')  int surahTotal, @JsonKey(name: 'moshaf_type')  int moshafType, @JsonKey(name: 'surah_list')  String surahList)  $default,) {final _that = this;
switch (_that) {
case _MoshafModel():
return $default(_that.id,_that.name,_that.server,_that.surahTotal,_that.moshafType,_that.surahList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String server, @JsonKey(name: 'surah_total')  int surahTotal, @JsonKey(name: 'moshaf_type')  int moshafType, @JsonKey(name: 'surah_list')  String surahList)?  $default,) {final _that = this;
switch (_that) {
case _MoshafModel() when $default != null:
return $default(_that.id,_that.name,_that.server,_that.surahTotal,_that.moshafType,_that.surahList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MoshafModel implements MoshafModel {
  const _MoshafModel({required this.id, required this.name, required this.server, @JsonKey(name: 'surah_total') required this.surahTotal, @JsonKey(name: 'moshaf_type') required this.moshafType, @JsonKey(name: 'surah_list') required this.surahList});
  factory _MoshafModel.fromJson(Map<String, dynamic> json) => _$MoshafModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String server;
@override@JsonKey(name: 'surah_total') final  int surahTotal;
@override@JsonKey(name: 'moshaf_type') final  int moshafType;
@override@JsonKey(name: 'surah_list') final  String surahList;

/// Create a copy of MoshafModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoshafModelCopyWith<_MoshafModel> get copyWith => __$MoshafModelCopyWithImpl<_MoshafModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MoshafModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoshafModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.server, server) || other.server == server)&&(identical(other.surahTotal, surahTotal) || other.surahTotal == surahTotal)&&(identical(other.moshafType, moshafType) || other.moshafType == moshafType)&&(identical(other.surahList, surahList) || other.surahList == surahList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,server,surahTotal,moshafType,surahList);

@override
String toString() {
  return 'MoshafModel(id: $id, name: $name, server: $server, surahTotal: $surahTotal, moshafType: $moshafType, surahList: $surahList)';
}


}

/// @nodoc
abstract mixin class _$MoshafModelCopyWith<$Res> implements $MoshafModelCopyWith<$Res> {
  factory _$MoshafModelCopyWith(_MoshafModel value, $Res Function(_MoshafModel) _then) = __$MoshafModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String server,@JsonKey(name: 'surah_total') int surahTotal,@JsonKey(name: 'moshaf_type') int moshafType,@JsonKey(name: 'surah_list') String surahList
});




}
/// @nodoc
class __$MoshafModelCopyWithImpl<$Res>
    implements _$MoshafModelCopyWith<$Res> {
  __$MoshafModelCopyWithImpl(this._self, this._then);

  final _MoshafModel _self;
  final $Res Function(_MoshafModel) _then;

/// Create a copy of MoshafModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? server = null,Object? surahTotal = null,Object? moshafType = null,Object? surahList = null,}) {
  return _then(_MoshafModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,server: null == server ? _self.server : server // ignore: cast_nullable_to_non_nullable
as String,surahTotal: null == surahTotal ? _self.surahTotal : surahTotal // ignore: cast_nullable_to_non_nullable
as int,moshafType: null == moshafType ? _self.moshafType : moshafType // ignore: cast_nullable_to_non_nullable
as int,surahList: null == surahList ? _self.surahList : surahList // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
