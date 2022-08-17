// ignore_for_file: avoid_print

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:no_signal/utils/api.dart';

//// Function to setup User Collection
/// Just run this function setting your endpoint, ProjectID and APIKey
void main() async {
  Client client = Client()
      .setEndpoint(ApiInfo.url) // Replace with the endpoint
      .setProject(ApiInfo.projectId) // Replace with your Project ID
      .setKey(ApiInfo.secretKey) // Replace with your API Key
      .setSelfSigned(status: true);

  Databases db = Databases(client, databaseId: 'unique()');

  db.create(name: ApiInfo.databaseId);

  Storage storage = Storage(client);
  await db.createCollection(
    collectionId: 'users',
    name: 'Users',
    permission: 'document',
    read: ["role:all"],
    write: [],
  );
  await db.createStringAttribute(
      collectionId: 'users', key: 'name', size: 256, xrequired: true);
  await db.createStringAttribute(
      collectionId: 'users', key: 'bio', size: 256, xrequired: false);
  await db.createStringAttribute(
      collectionId: 'users', key: 'imgId', size: 256, xrequired: false);
  await db.createEmailAttribute(
      collectionId: 'users', key: 'email', xrequired: true);
  await db.createStringAttribute(
      collectionId: 'users', key: 'id', size: 256, xrequired: true);
  print("Collection created");

  // Creating a new Bucket to store Profile Photos
  await storage.createBucket(
      bucketId: 'default', name: 'Profile Photos', permission: 'file');
  print('Bucket Created');
}
