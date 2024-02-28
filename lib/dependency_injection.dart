import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evemanager/data/datasource/firebase_datasource.dart';
import 'package:evemanager/data/datasource/firebase_datasource_impl.dart';
import 'package:evemanager/data/repository/firebase_repository_impl.dart';
import 'package:evemanager/domain/repository/firebase_repository.dart';
import 'package:evemanager/domain/usecases/User/delete_user_usecase.dart';
import 'package:evemanager/domain/usecases/User/get_current_uid_usecase.dart';
import 'package:evemanager/domain/usecases/User/get_user_usecase.dart';
import 'package:evemanager/domain/usecases/User/is_sign_in_usecase.dart';
import 'package:evemanager/domain/usecases/User/sign_in_usecase.dart';
import 'package:evemanager/domain/usecases/User/sign_out_usecase.dart';
import 'package:evemanager/domain/usecases/User/sign_up_usecase.dart';
import 'package:evemanager/domain/usecases/User/update_user-usecase.dart';
import 'package:evemanager/domain/usecases/catering/add_catering_service_usecase.dart';
import 'package:evemanager/domain/usecases/catering/delete_catering_service_usecase.dart';
import 'package:evemanager/domain/usecases/catering/get_catering_service_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/catering/get_catering_service_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/catering/update_catering_service_usecase.dart';
import 'package:evemanager/domain/usecases/marriage_halls/add_marriage_hall_usecase.dart';
import 'package:evemanager/domain/usecases/marriage_halls/delete_marriage_hall_usecase.dart';
import 'package:evemanager/domain/usecases/marriage_halls/edit_availability_of_hall_usecase.dart';
import 'package:evemanager/domain/usecases/marriage_halls/get_marriage_hall_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/marriage_halls/get_marriage_hall_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/marriage_halls/update_marriage_hall_pictures_usecase.dart';
import 'package:evemanager/domain/usecases/marriage_halls/update_marriage_hall_usecase.dart';
import 'package:evemanager/presentation/cubit/auth/auth_cubit.dart';
import 'package:evemanager/presentation/cubit/cateringservice/cateringservice_cubit.dart';
import 'package:evemanager/presentation/cubit/credentials/credentials_cubit.dart';
import 'package:evemanager/presentation/cubit/marriagehall/marriage_hall_cubit.dart';
import 'package:evemanager/presentation/cubit/userprofile/user_profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(() => AuthCubit(
      signOutUsecase: sl.call(),
      getCurrentUidUsecase: sl.call(),
      isSignInUsecase: sl.call()));
  sl.registerFactory(() => CredentialsCubit(
        signInUsecase: sl.call(),
        signUpUserUsecase: sl.call(),
      ));
  sl.registerFactory(() => UserProfileCubit(
        uidusecase: sl.call(),
        deleteUserUsecase: sl.call(),
        updateUserUsecase: sl.call(),
        getUserUsecase: sl.call(),
      ));
  sl.registerFactory(() => MarriageHallCubit(
        addMarriageHallUsecase: sl.call(),
        deleteMarriageHallUsecase: sl.call(),
        editAvailabilityOfHallUsecase: sl.call(),
        updateMarriageHallPicturesUsecase: sl.call(),
        updateMarriageHallUsecase: sl.call(),
        getMarriageHallForClientUsecase: sl.call(),
        getMarriageHallForOwnerUsecase: sl.call(),
      ));
  sl.registerFactory(() => CateringserviceCubit(
        addCateringServiceUsecase: sl.call(),
        deleteCateringServiceUsecase: sl.call(),
        updateCateringServiceUsecase: sl.call(),
        getCateringServiceForClientUsecase: sl.call(),
        getCateringServiceForOwnerUsecase: sl.call(),
      ));

  // Usecases

  // Users
  sl.registerLazySingleton(() => SignOutUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => DeleteUserUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => GetCurrentUidUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => GetUserUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => IsSignInUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => SignInUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => SignUpUserUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => UpdateUserUsecase(firebaseRepository: sl.call()));

  // Marrige Hall
  sl.registerLazySingleton(
      () => AddMarriageHallUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => EditAvailabilityOfHallUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => DeleteMarriageHallUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => UpdateMarriageHallPicturesUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => UpdateMarriageHallUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => GetMarriageHallForClientUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => GetMarriageHallForOwnerUsecase(firebaseRepository: sl.call()));

// Catering Service
  sl.registerLazySingleton(
      () => AddCateringServiceUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => DeleteCateringServiceUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => UpdateCateringServiceUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => GetCateringServiceForClientUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => GetCateringServiceForOwnerUsecase(firebaseRepository: sl.call()));

// Repository

  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseDatasource: sl.call()));

// Firebase Data Source

  sl.registerLazySingleton<FirebaseDatasource>(() => FirebaseDatasourceImpl(
      firebaseAuth: sl.call(),
      firebaseFirestore: sl.call(),
      storage: sl.call()));

// Externals
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => storage);
}
