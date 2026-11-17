abstract class BaseRepository<T, ID> {
  Future<List<T>> getAll();

  Future<T?> getById(ID id);

  Future<void> add(T item);

  Future<void> update(T item);

  Future<void> delete(ID id);
}
