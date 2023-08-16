import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' as developer;

class SecureStorage {
  static SecureStorage? _instance;

  factory SecureStorage() =>
      _instance ??= SecureStorage._(const FlutterSecureStorage());

  SecureStorage._(this._storage);

  final FlutterSecureStorage _storage;
  static const _accessToken = 'AccessTOKEN';
  static const _customerID = 'CustomerID';
  static const _email = 'Email';
  static const _customerName = 'CustomerName';
  static const _location = 'Location';
  static const _mobileNumber = 'MobileNumber';
  static const _isItCached = 'IsItCached';
  static const _profileImage = 'ProfileImage';

///////////////////////////////////////

  Future<void> saveAccessToken(String accessToken) async {
    await _storage.write(key: _accessToken, value: accessToken);
    developer.log('accessToken: $accessToken saved now in secure_storage');
  }

  Future<bool> hasAccessToken() async {
    var value = await _storage.read(key: _accessToken);
    return value != null;
  }

  Future<String?> getAccessToken() async => _storage.read(key: _accessToken);

///////////////////////////////////////

  Future<void> saveCustomerID(String customerID) async {
    await _storage.write(key: _customerID, value: customerID);
    developer.log('customerID: $customerID saved now in secure_storage');
  }

  Future<String?> getCustomerID() async => _storage.read(key: _customerID);

///////////////////////////////////////

  Future<void> saveEmail(String email) async {
    await _storage.write(key: _email, value: email);
    developer.log('email: $email saved now in secure_storage');
  }

  Future<String?> getEmail() async => _storage.read(key: _email);

///////////////////////////////////////

  Future<void> saveCustomerName(String customerName) async {
    await _storage.write(key: _customerName, value: customerName);
    developer.log('customerName: $customerName saved now in secure_storage');
  }

  Future<String?> getCustomerName() async => _storage.read(key: _customerName);

///////////////////////////////////////

  Future<void> saveLocation(String location) async {
    await _storage.write(key: _location, value: location);
    developer.log('location: $location saved now in secure_storage');
  }

  Future<String?> getLocation() async => _storage.read(key: _location);

///////////////////////////////////////

  Future<void> saveMobileNumber(String mobileNumber) async {
    await _storage.write(key: _mobileNumber, value: mobileNumber);
    developer.log('mobileNumber: $mobileNumber saved now in secure_storage');
  }

  Future<String?> getMobileNumber() async => _storage.read(key: _mobileNumber);

///////////////////////////////////////

  Future<void> saveProfileImage(String profileImage) async {
    await _storage.write(key: _profileImage, value: profileImage);
    developer.log('profileImage: $profileImage saved now in secure_storage');
  }

  Future<String?> getProfileImage() async => _storage.read(key: _profileImage);

///////////////////////////////////////
  Future<void> saveIsItCached(bool isItCached) async {
    await _storage.write(key: _isItCached, value: isItCached.toString());
    developer.log('getCache: $isItCached saved now in secure_storage');
  }

  Future<String?> getIsItCached() async => _storage.read(key: _isItCached);

///////////////////////////////////////
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
