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
import 'package:evemanager/domain/usecases/venues/add_venue_usecase.dart';
import 'package:evemanager/domain/usecases/venues/delete_venue_usecase.dart';
import 'package:evemanager/domain/usecases/venues/edit_availability_of_venue_usecase.dart';
import 'package:evemanager/domain/usecases/venues/get_venue_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/venues/get_venue_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/venues/update_venue_pictures_usecase.dart';
import 'package:evemanager/domain/usecases/venues/update_venue_usecase.dart';
import 'package:evemanager/presentation/cubit/auth/auth_cubit.dart';
import 'package:evemanager/presentation/cubit/cateringservice/cateringservice_cubit.dart';
import 'package:evemanager/presentation/cubit/credentials/credentials_cubit.dart';
import 'package:evemanager/presentation/cubit/venue/venue_cubit.dart';
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
  sl.registerFactory(() => VenueCubit(
        addVenueUsecase: sl.call(),
        deleteVenueUsecase: sl.call(),
        editAvailabilityOfVenueUsecase: sl.call(),
        updateVenuePicturesUsecase: sl.call(),
        updateVenueUsecase: sl.call(),
        getVenueForClientUsecase: sl.call(),
        getVenueForOwnerUsecase: sl.call(),
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

  // Venue
  sl.registerLazySingleton(
      () => AddVenueUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => EditAvailabilityOfVenueUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => DeleteVenueUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => UpdateVenuePicturesUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => UpdateVenueUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => GetVenueForClientUsecase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => GetVenueForOwnerUsecase(firebaseRepository: sl.call()));

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
