import 'dart:async';

import 'package:sembast/sembast.dart';

import 'debug_provider.dart';

abstract class SembastProvider {
  Future<int> insert<T extends BaseModel>(T item);
  Future<int> update<T extends BaseModel>(T item, Filter filter);
  Future<List<int>> insertAll<T extends BaseModel>(List<T> items);
  Future<Iterable<T>> getAll<T extends BaseModel>(
      T Function(Map<String, Object?> item) fromJson);
  Future<void> clear<T extends BaseModel>();
  Future<T?> getByFilter<T extends BaseModel>(
      Filter filter, T Function(Map<String, Object?>) fromJson);
  Future<void> clearByFilter<T extends BaseModel>(Filter filter);
}

class SembastProviderImpl implements SembastProvider {
  SembastProviderImpl({required this.db});
  final Database? db;

  @override
  Future<int> insert<T extends BaseModel>(T item) async {
    final String tableName = item.runtimeType.toString();
    final StoreRef<int, Map<String, Object?>> store =
        intMapStoreFactory.store(tableName);
    return store.add(db!, item.toJson());
  }

  @override
  Future<int> update<T extends BaseModel>(T item, Filter filter) async {
    final String tableName = item.runtimeType.toString();
    final StoreRef<int, Map<String, Object?>> store =
        intMapStoreFactory.store(tableName);
    return store.update(db!, item.toJson(), finder: Finder(filter: filter));
  }

  @override
  Future<List<int>> insertAll<T extends BaseModel>(List<T> items) async {
    final String tableName = T.toString();
    final StoreRef<int, Map<String, Object?>> store =
        intMapStoreFactory.store(tableName);
    final List<Map<String, dynamic>> values =
        // ignore: always_specify_types
        items.map((a) => a.toJson()).toList();
    DebugProvider.debugLog('inserting all in $tableName ');
    final List<int> result = await store.addAll(db!, values);
    DebugProvider.debugLog('inserted all in $tableName ');
    return result;
  }

  @override
  Future<Iterable<T>> getAll<T extends BaseModel>(
      T Function(Map<String, Object?>) fromJson) async {
    final String tableName = T.toString();
    final StoreRef<int, Map<String, Object?>> store =
        intMapStoreFactory.store(tableName);
    final List<RecordSnapshot<int, Map<String, Object?>>> records =
        await store.find(db!);
    return records.map(
        (RecordSnapshot<int, Map<String, Object?>> e) => fromJson(e.value));
  }

  @override
  Future<void> clear<T extends BaseModel>() async {
    final String tableName = T.toString();
    final StoreRef<int, Map<String, Object?>> store =
        intMapStoreFactory.store(tableName);
    DebugProvider.debugLog('droping table $tableName ');
    // ignore: always_specify_types
    final result = await store.drop(db!);
    DebugProvider.debugLog('droped table $tableName ');
    return result;
  }

  @override
  Future<T?> getByFilter<T extends BaseModel>(
      Filter filter, T Function(Map<String, Object?> p1) fromJson) async {
    final String tableName = T.toString();
    final StoreRef<int, Map<String, Object?>> tableCollection =
        intMapStoreFactory.store(tableName);
    final RecordSnapshot<int, Map<String, Object?>>? record =
        (await tableCollection.find(db!, finder: Finder(filter: filter)))
            .firstOrNull;
    return record != null ? fromJson(record.value) : null;
  }

  @override
  Future<void> clearByFilter<T extends BaseModel>(Filter filter) async {
    final String tableName = T.toString();
    final StoreRef<int, Map<String, Object?>> tableCollection =
        intMapStoreFactory.store(tableName);

    await tableCollection.delete(db!, finder: Finder(filter: filter));
  }
}

abstract class BaseModel {
  factory BaseModel.fromJson() {
    throw UnimplementedError();
  }
  Map<String, dynamic> toJson();
}
