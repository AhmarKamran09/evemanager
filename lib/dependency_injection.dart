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
import 'package:evemanager/domain/usecases/bridal_makeup_&_hair/add_bridal_makeup_&_hair_usecase.dart';
import 'package:evemanager/domain/usecases/bridal_makeup_&_hair/delete_bridal_makeup_&_hair_usecase.dart';
import 'package:evemanager/domain/usecases/bridal_makeup_&_hair/get_bridal_makeup_&_hair_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/bridal_makeup_&_hair/get_bridal_makeup_&_hair_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/bridal_makeup_&_hair/update_bridal_makeup_&_hair_usecase.dart';
import 'package:evemanager/domain/usecases/catering/add_catering_service_usecase.dart';
import 'package:evemanager/domain/usecases/catering/delete_catering_service_usecase.dart';
import 'package:evemanager/domain/usecases/catering/get_catering_service_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/catering/get_catering_service_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/catering/update_catering_service_usecase.dart';
import 'package:evemanager/domain/usecases/clothing/add_clothing_usecase.dart';
import 'package:evemanager/domain/usecases/clothing/delete_clothing_usecase.dart';
import 'package:evemanager/domain/usecases/clothing/get_clothing_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/clothing/get_clothing_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/clothing/update_clothing_usecase.dart';
import 'package:evemanager/domain/usecases/decorations/add_decorations_usecase.dart';
import 'package:evemanager/domain/usecases/decorations/delete_decorations_usecase.dart';
import 'package:evemanager/domain/usecases/decorations/get_decorations_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/decorations/get_decorations_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/decorations/update_decorations_usecase.dart';
import 'package:evemanager/domain/usecases/entertainment/add_entertainment_usecase.dart';
import 'package:evemanager/domain/usecases/entertainment/delete_entertainment_usecase.dart';
import 'package:evemanager/domain/usecases/entertainment/get_entertainment_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/entertainment/get_entertainment_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/entertainment/update_entertainment_usecase.dart';
import 'package:evemanager/domain/usecases/invitation_design/add_invitation_design_usecase.dart';
import 'package:evemanager/domain/usecases/invitation_design/delete_invitation_design_usecase.dart';
import 'package:evemanager/domain/usecases/invitation_design/get_invitation_design_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/invitation_design/get_invitation_design_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/invitation_design/update_invitation_design_usecase.dart';
import 'package:evemanager/domain/usecases/message/get_chats_for_admin_usecase.dart';
import 'package:evemanager/domain/usecases/message/get_chats_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/message/get_messages_usecase.dart';
import 'package:evemanager/domain/usecases/message/send_message_usecase.dart';
import 'package:evemanager/domain/usecases/photography/add_photography_usecase.dart';
import 'package:evemanager/domain/usecases/photography/delete_photography_usecase.dart';
import 'package:evemanager/domain/usecases/photography/get_photography_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/photography/get_photography_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/photography/update_photography_usecase.dart';
import 'package:evemanager/domain/usecases/sweets/add_sweets_usecase.dart';
import 'package:evemanager/domain/usecases/sweets/delete_sweets_usecase.dart';
import 'package:evemanager/domain/usecases/sweets/get_sweets_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/sweets/get_sweets_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/sweets/update_sweets_usecase.dart';
import 'package:evemanager/domain/usecases/transportation/add_transportation_usecase.dart';
import 'package:evemanager/domain/usecases/transportation/delete_transportation_usecase.dart';
import 'package:evemanager/domain/usecases/transportation/get_transportation_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/transportation/get_transportation_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/transportation/update_transportation_usecase.dart';
import 'package:evemanager/domain/usecases/venues/add_venue_usecase.dart';
import 'package:evemanager/domain/usecases/venues/delete_venue_usecase.dart';
import 'package:evemanager/domain/usecases/venues/edit_availability_of_venue_usecase.dart';
import 'package:evemanager/domain/usecases/venues/get_venue_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/venues/get_venue_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/venues/update_venue_pictures_usecase.dart';
import 'package:evemanager/domain/usecases/venues/update_venue_usecase.dart';
import 'package:evemanager/domain/usecases/videography/add_videography_usecase.dart';
import 'package:evemanager/domain/usecases/videography/delete_videography_usecase.dart';
import 'package:evemanager/domain/usecases/videography/get_videography_for_client_usecase.dart';
import 'package:evemanager/domain/usecases/videography/get_videography_for_owner_usecase.dart';
import 'package:evemanager/domain/usecases/videography/update_videography_usecase.dart';
import 'package:evemanager/presentation/cubit/auth/auth_cubit.dart';
import 'package:evemanager/presentation/cubit/bridal_makeup_and_hair/bridal_makeup_hair_cubit.dart';
import 'package:evemanager/presentation/cubit/cateringservice/cateringservice_cubit.dart';
import 'package:evemanager/presentation/cubit/chat/chat_cubit.dart';
import 'package:evemanager/presentation/cubit/clothing/clothing_cubit.dart';
import 'package:evemanager/presentation/cubit/credentials/credentials_cubit.dart';
import 'package:evemanager/presentation/cubit/decoration/decoration_cubit.dart';
import 'package:evemanager/presentation/cubit/entertainment/entertainment_cubit.dart';
import 'package:evemanager/presentation/cubit/invitation_design/invitation_design_cubit.dart';
import 'package:evemanager/presentation/cubit/messages/messages_cubit.dart';
import 'package:evemanager/presentation/cubit/photography/photography_cubit.dart';
import 'package:evemanager/presentation/cubit/sweets/sweets_cubit.dart';
import 'package:evemanager/presentation/cubit/transportation/transportation_cubit.dart';
import 'package:evemanager/presentation/cubit/venue/venue_cubit.dart';
import 'package:evemanager/presentation/cubit/userprofile/user_profile_cubit.dart';
import 'package:evemanager/presentation/cubit/videography/videography_cubit.dart';
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
  sl.registerFactory(() => BridalMakeupHairCubit(
        addBridalMakeupAndHairUsecase: sl.call(),
        deleteBridalMakeupAndHairUsecase: sl.call(),
        updateBridalMakeupAndHairUsecase: sl.call(),
        getBridalMakeupAndHairForClientUsecase: sl.call(),
        getBridalMakeupAndHairForOwnerUsecase: sl.call(),
      ));

  sl.registerFactory(() => ClothingCubit(
        addClothingUsecase: sl.call(),
        deleteClothingUsecase: sl.call(),
        updateClothingUsecase: sl.call(),
        getClothingForClientUsecase: sl.call(),
        getClothingForOwnerUsecase: sl.call(),
      ));

  sl.registerFactory(() => DecorationCubit(
        addDecorationsUsecase: sl.call(),
        deleteDecorationsUsecase: sl.call(),
        updateDecorationsUsecase: sl.call(),
        getDecorationsForClientUsecase: sl.call(),
        getDecorationsForOwnerUsecase: sl.call(),
      ));

  sl.registerFactory(() => EntertainmentCubit(
        addEntertainmentUsecase: sl.call(),
        deleteEntertainmentUsecase: sl.call(),
        updateEntertainmentUsecase: sl.call(),
        getEntertainmentForClientUsecase: sl.call(),
        getEntertainmentForOwnerUsecase: sl.call(),
      ));

  sl.registerFactory(() => InvitationDesignCubit(
        addInvitationDesignUsecase: sl.call(),
        deleteInvitationDesignUsecase: sl.call(),
        updateInvitationDesignUsecase: sl.call(),
        getInvitationDesignForClientUsecase: sl.call(),
        getInvitationDesignForOwnerUsecase: sl.call(),
      ));

  sl.registerFactory(() => PhotographyCubit(
        addPhotographyUsecase: sl.call(),
        deletePhotographyUsecase: sl.call(),
        updatePhotographyUsecase: sl.call(),
        getPhotographyForClientUsecase: sl.call(),
        getPhotographyForOwnerUsecase: sl.call(),
      ));

  sl.registerFactory(() => SweetsCubit(
        addSweetsUsecase: sl.call(),
        deleteSweetsUsecase: sl.call(),
        updateSweetsUsecase: sl.call(),
        getSweetsForClientUsecase: sl.call(),
        getSweetsForOwnerUsecase: sl.call(),
      ));

  sl.registerFactory(() => TransportationCubit(
        addTransportationUsecase: sl.call(),
        deleteTransportationUsecase: sl.call(),
        updateTransportationUsecase: sl.call(),
        getTransportationForClientUsecase: sl.call(),
        getTransportationForOwnerUsecase: sl.call(),
      ));

  sl.registerFactory(() => VideographyCubit(
        addVideographyUsecase: sl.call(),
        deleteVideographyUsecase: sl.call(),
        updateVideographyUsecase: sl.call(),
        getVideographyForClientUsecase: sl.call(),
        getVideographyForOwnerUsecase: sl.call(),
      ));

  sl.registerFactory(() => ChatCubit(
      getChatsForClientUsecase: sl.call(), getChatsForAdminUsecase: sl.call()));

  sl.registerFactory(() => MessagesCubit(
        getMessagesUsecase: sl.call(),
        sendMessageUsecase: sl.call(),
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

// Bridalmakeupandhair

  sl.registerLazySingleton(
    () => AddBridalMakeupAndHairUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => DeleteBridalMakeupAndHairUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => UpdateBridalMakeupAndHairUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetBridalMakeupAndHairForClientUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetBridalMakeupAndHairForOwnerUsecase(firebaseRepository: sl.call()),
  );

// Clothing
  sl.registerLazySingleton(
    () => AddClothingUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => DeleteClothingUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => UpdateClothingUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetClothingForClientUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetClothingForOwnerUsecase(firebaseRepository: sl.call()),
  );
// Decorations

  sl.registerLazySingleton(
    () => AddDecorationsUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => DeleteDecorationsUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => UpdateDecorationsUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetDecorationsForClientUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetDecorationsForOwnerUsecase(firebaseRepository: sl.call()),
  );

// Entertainment
  sl.registerLazySingleton(
    () => AddEntertainmentUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => DeleteEntertainmentUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => UpdateEntertainmentUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetEntertainmentForClientUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetEntertainmentForOwnerUsecase(firebaseRepository: sl.call()),
  );

// InvitationDesign
  sl.registerLazySingleton(
    () => AddInvitationDesignUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => DeleteInvitationDesignUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => UpdateInvitationDesignUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetInvitationDesignForClientUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetInvitationDesignForOwnerUsecase(firebaseRepository: sl.call()),
  );

// Photography

  sl.registerLazySingleton(
    () => AddPhotographyUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => DeletePhotographyUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => UpdatePhotographyUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetPhotographyForClientUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetPhotographyForOwnerUsecase(firebaseRepository: sl.call()),
  );
// Sweets

  sl.registerLazySingleton(
    () => AddSweetsUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => DeleteSweetsUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => UpdateSweetsUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetSweetsForClientUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetSweetsForOwnerUsecase(firebaseRepository: sl.call()),
  );
// Transportation
  sl.registerLazySingleton(
    () => AddTransportationUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => DeleteTransportationUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => UpdateTransportationUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetTransportationForClientUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetTransportationForOwnerUsecase(firebaseRepository: sl.call()),
  );
// Videography
  sl.registerLazySingleton(
    () => AddVideographyUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => DeleteVideographyUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => UpdateVideographyUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetVideographyForClientUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetVideographyForOwnerUsecase(firebaseRepository: sl.call()),
  );
// Messages
  sl.registerLazySingleton(
    () => GetMessagesUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => SendMessageUsecase(firebaseRepository: sl.call()),
  );
// Chat
  sl.registerLazySingleton(
    () => GetChatsForClientUsecase(firebaseRepository: sl.call()),
  );
  sl.registerLazySingleton(
    () => GetChatsForAdminUsecase(firebaseRepository: sl.call()),
  );

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
