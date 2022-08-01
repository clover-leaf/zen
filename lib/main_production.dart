import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_firestore/app/app.dart';
import 'package:flutter_firestore/bootstrap.dart';
import 'package:http/http.dart' as http;
import 'package:iot_gateway/iot_gateway.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/.env');

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('ANON_KEY'),
  );

  final httpClient = http.Client();

  await bootstrap(() {
    final authClient = SupabaseAuthClient(
      auth: Supabase.instance.client.auth,
    );
    final databaseClient = SupabaseDatabaseClient(
      httpClient: httpClient,
      supabaseClient: Supabase.instance.client,
    );
    final iotGateway = IotGateway();
    final userRepository = UserRepository(
      authClient: authClient,
      databaseClient: databaseClient,
      iotGateway: iotGateway,
    );

    return App(userRepository: userRepository);
  });
}
