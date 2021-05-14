abstract class FileUploadRepository {
  Future<List<String>?>? uploadFile(List<dynamic> files, String productName,
      {bool isStoreImage = false}) async {}
}
