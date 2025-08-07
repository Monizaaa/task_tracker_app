import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_tracker_app/core/services/auth_service.dart';
import 'package:task_tracker_app/core/utils/app_translate.dart';
import 'package:task_tracker_app/core/api/api_client.dart';
import 'package:task_tracker_app/core/services/setting_service.dart';
import 'package:task_tracker_app/core/theme/app_theme.dart';
import 'package:task_tracker_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:task_tracker_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:task_tracker_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:task_tracker_app/features/auth/domain/usecases/create_user_usecase.dart';
import 'package:task_tracker_app/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:task_tracker_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:task_tracker_app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:task_tracker_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:task_tracker_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:task_tracker_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:task_tracker_app/features/chat/presentation/controllers/chat_controller.dart';
import 'package:task_tracker_app/features/home/presentation/controllers/task_controller.dart';
import 'package:task_tracker_app/features/project/data/datasources/project_remote_datasource.dart';
import 'package:task_tracker_app/features/project/presentation/controllers/project_controller.dart';
import 'package:task_tracker_app/features/project/data/repositories/project_repository_impl.dart';
import 'package:task_tracker_app/features/project/domain/repositories/project_repository.dart';

import 'package:task_tracker_app/features/project/domain/usecases/search_project_usecase.dart';
import 'package:task_tracker_app/features/home/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // --- Dependency Injection Setup ---
  // 1. Core Services
  Get.put(AuthService());
  Get.put(ApiClient());
  Get.put(SettingService());

  // 2. Data Layer
  Get.put<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
  Get.put<ProjectRemoteDataSource>(ProjectRemoteDataSourceImpl());

  // 3. Domain Layer (Repositories and Use Cases)
  // Auth
  Get.put<AuthRepository>(
    AuthRepositoryImpl(remoteDataSource: Get.find<AuthRemoteDataSource>()),
  );
  Get.put(SignInUseCase(Get.find<AuthRepository>()));
  Get.put(CreateUserUseCase(Get.find<AuthRepository>()));
  Get.put(SignOutUseCase(Get.find<AuthRepository>()));
  Get.put(GetProfileUseCase(Get.find<AuthRepository>()));

  // Project
  Get.put<ProjectRepository>(
    ProjectRepositoryImpl(
      remoteDataSource: Get.find<ProjectRemoteDataSource>(),
    ),
  );
  Get.put(SearchProjectUsecase(Get.find<ProjectRepository>()));

  // 4. Presentation Layer (Controllers)
  Get.put(
    AuthController(
      signInUseCase: Get.find<SignInUseCase>(),
      createUserUseCase: Get.find<CreateUserUseCase>(),
      signOutUseCase: Get.find<SignOutUseCase>(),
      getProfileUseCase: Get.find<GetProfileUseCase>(),
      authService: Get.find<AuthService>(),
    ),
  );
  Get.put(
    ProjectController(searchProjectUsecase: Get.find<SearchProjectUsecase>()),
  );
  Get.put(ChatController());
  Get.put(TaskController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingService = Get.find<SettingService>();
    return ScreenUtilInit(
      enableScaleText: () => false,
      enableScaleWH: () => false,
      child: GetMaterialApp(
        title: 'Task Tracker',
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: settingService.themeMode,
        home: Obx(() {
          return Get.find<AuthService>().isLoggedIn.value
              ? const HomeScreen()
              : SignInScreen();
        }),
        getPages: routes,
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

var routes = [
  GetPage(name: '/sign_in', page: () => SignInScreen()),
  GetPage(name: '/sign_up', page: () => SignUpScreen()),
  GetPage(name: '/home', page: () => HomeScreen()),
];
