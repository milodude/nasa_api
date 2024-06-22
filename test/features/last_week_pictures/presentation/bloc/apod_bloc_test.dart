import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_api/core/error/failure.dart';
import 'package:nasa_api/core/use_case/base_use_case.dart';
import 'package:nasa_api/features/last_week_pictures/domain/entity/picture_of_the_day.dart';
import 'package:nasa_api/features/last_week_pictures/domain/use_case/get_last_week_pictures_use_case.dart';
import 'package:nasa_api/features/last_week_pictures/presentation/bloc/apod_bloc.dart';

import '../../../../fixtures/error_message_fixture.dart';
import '../../../../fixtures/pictures_of_the_day/pictures_of_the_day_fixtures.dart';
import 'apod_bloc_test.mocks.dart';

@GenerateMocks(<Type>[GetLastWeekPicturesUseCase])
void main() {
  final MockGetLastWeekPicturesUseCase mockGetLastWeekPicturesUseCase =
      MockGetLastWeekPicturesUseCase();
  late ApodBloc bloc =
      ApodBloc(getLastWeekPicturesUseCase: mockGetLastWeekPicturesUseCase);

  group('${bloc.runtimeType} tests: ', () {
    setUp(() {
      bloc.close();
      bloc = ApodBloc(
        getLastWeekPicturesUseCase: mockGetLastWeekPicturesUseCase,
      );
    });

    blocTest<ApodBloc, ApodState>(
      'emits [] when nothing is called',
      build: () => bloc,
      expect: () => <ApodState>[],
      wait: const Duration(milliseconds: 500),
    );

    blocTest<ApodBloc, ApodState>(
      'emits [ApodLoading, ApodLoaded], should get a list of pictures',
      setUp: () {
        when(mockGetLastWeekPicturesUseCase.call(NoParams())).thenAnswer(
            (Invocation realInvocation) =>
                Future<Either<Failure, List<PictureOfTheDay>>>.value(
                    Right<Failure, List<PictureOfTheDay>>(mockPicturesList)));
      },
      build: () {
        return bloc;
      },
      act: (ApodBloc bloc) => bloc.add(GetLastWeekPicsEvent()),
      expect: () {
        return <ApodState>[
          ApodLoading(),
          ApodLoaded(picturesList: mockPicturesList),
        ];
      },
      tearDown: bloc.close,
      wait: const Duration(milliseconds: 500),
    );

    blocTest<ApodBloc, ApodState>(
      'emits [ApodLoading, ApodError], should try to get the list but throws a failure',
      setUp: () {
        when(mockGetLastWeekPicturesUseCase.call(NoParams())).thenAnswer(
            (Invocation realInvocation) =>
                Future<Either<Failure, List<PictureOfTheDay>>>.value(
                    const Left<Failure, List<PictureOfTheDay>>(
                        ServerFailure(errorMessage: errorMessage))));
      },
      build: () {
        return bloc;
      },
      act: (ApodBloc bloc) => bloc.add(GetLastWeekPicsEvent()),
      expect: () {
        return <ApodState>[
          ApodLoading(),
          const ApodError(errorMessage: errorMessage),
        ];
      },
      tearDown: bloc.close,
      wait: const Duration(milliseconds: 500),
    );
  });
}
