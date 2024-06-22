// Mocks generated by Mockito 5.4.4 from annotations
// in nasa_api/test/features/last_week_pictures/presentation/bloc/apod_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:nasa_api/core/error/failure.dart' as _i6;
import 'package:nasa_api/core/use_case/base_use_case.dart' as _i8;
import 'package:nasa_api/features/last_week_pictures/domain/entity/picture_of_the_day.dart'
    as _i7;
import 'package:nasa_api/features/last_week_pictures/domain/repository/apod_repository.dart'
    as _i2;
import 'package:nasa_api/features/last_week_pictures/domain/use_case/get_last_week_pictures_use_case.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeApodRepository_0 extends _i1.SmartFake
    implements _i2.ApodRepository {
  _FakeApodRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetLastWeekPicturesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetLastWeekPicturesUseCase extends _i1.Mock
    implements _i4.GetLastWeekPicturesUseCase {
  MockGetLastWeekPicturesUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ApodRepository get apodRepository => (super.noSuchMethod(
        Invocation.getter(#apodRepository),
        returnValue: _FakeApodRepository_0(
          this,
          Invocation.getter(#apodRepository),
        ),
      ) as _i2.ApodRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.PictureOfTheDay>>> call(
          _i8.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5
            .Future<_i3.Either<_i6.Failure, List<_i7.PictureOfTheDay>>>.value(
            _FakeEither_1<_i6.Failure, List<_i7.PictureOfTheDay>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.PictureOfTheDay>>>);
}