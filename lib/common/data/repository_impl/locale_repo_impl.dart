
import 'package:blockchain_mobile_app/common/data/data_source/local/locale_source.dart';
import 'package:blockchain_mobile_app/common/domain/repository/locale_repository.dart';
import 'package:flutter/material.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  final LocaleSource _localeSource;

  LocaleRepositoryImpl(this._localeSource);
  @override
  Locale readLocale() {
    return _localeSource.readLocale();
  }

  @override
  Future<bool> saveLocale(Locale locale) async {
    return await _localeSource.saveLocale(locale);
  }
}
