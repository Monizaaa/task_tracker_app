import 'package:get/get.dart';
import 'package:task_tracker_app/core/errors/server_exception.dart';
import 'package:task_tracker_app/core/services/auth_service.dart';
import 'package:task_tracker_app/features/auth/domain/entities/user_entity.dart';
import 'package:task_tracker_app/features/auth/domain/usecases/create_user_usecase.dart';
import 'package:task_tracker_app/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:task_tracker_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:task_tracker_app/features/auth/domain/usecases/sign_out_usecase.dart';

class AuthController extends GetxController {
  // --- Service (Dependencies) ---
  final AuthService _authService;

  // --- Use Cases (Dependencies) ---
  final SignInUseCase _signInUseCase;
  final CreateUserUseCase _createUserUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetProfileUseCase _getProfileUseCase;

  // --- State ---
  final _user = Rx<UserEntity?>(null);
  final _isLoading = false.obs;
  final _errorMessage = Rx<String?>(null);

  // --- Getters for UI ---
  UserEntity? get user => _user.value;
  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage.value;

  AuthController({
    required SignInUseCase signInUseCase,
    required CreateUserUseCase createUserUseCase,
    required SignOutUseCase signOutUseCase,
    required GetProfileUseCase getProfileUseCase,
    required AuthService authService,
  }) : _signInUseCase = signInUseCase,
       _createUserUseCase = createUserUseCase,
       _signOutUseCase = signOutUseCase,
       _getProfileUseCase = getProfileUseCase,
       _authService = authService;

  @override
  void onInit() {
    super.onInit();
    if (_authService.isLoggedIn.value) {
      _getProfile();
    }
  }

  Future<void> login(String email, String password) async {
    _isLoading.value = true;
    _errorMessage.value = null;
    try {
      final response = await _signInUseCase(email: email, password: password);
      _user.value = response.user;
      await _authService.saveToken(response.token);
      _authService.isLoggedIn.value = true;
      Get.offAllNamed('/home');
    } on ServerException catch (e) {
      _errorMessage.value = e.message;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> register(
    String email,
    String password,
    String displayName,
  ) async {
    _isLoading.value = true;
    _errorMessage.value = null;
    try {
      final userEntity = await _createUserUseCase(
        email: email,
        password: password,
        displayName: displayName,
      );
      _user.value = userEntity;
    } on ServerException catch (e) {
      _errorMessage.value = e.message;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _signOutUseCase();
    _user.value = null;
    _authService.clearToken();
    _authService.isLoggedIn.value = false;

    Get.offAllNamed('/sign_in');
  }

  Future<void> _getProfile() async {
    _user.value = await _getProfileUseCase();
  }
}
