import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_database_client/src/models/models.dart';

void main() {
  group('SupabaseUser', () {
    test('supports value equality', () {
      const supabaseUserA =
          SupabaseUser(id: 'id', userName: 'A', companyName: 'B');
      const secondSupabaseUserA =
          SupabaseUser(id: 'id', userName: 'A', companyName: 'B');
      const supabaseUserB =
          SupabaseUser(id: '', userName: 'B', companyName: 'C');

      expect(supabaseUserA, equals(secondSupabaseUserA));
      expect(supabaseUserA, isNot(equals(supabaseUserB)));
    });

    test('can be (de)serialized', () {
      const supabaseUser = SupabaseUser(
        id: 'id',
        userName: 'user name',
        companyName: 'company name',
      );
      final json = {
        'id': 'id',
        'username': 'user name',
        'companyname': 'company name'
      };

      expect(SupabaseUser.fromJson(json), equals(supabaseUser));
    });

    test('can be serialized', () {
      const supabaseUser = SupabaseUser(
        id: 'id',
        userName: 'user name',
        companyName: 'company name',
      );
      final json = {
        'id': 'id',
        'username': 'user name',
        'companyname': 'company name'
      };

      expect(supabaseUser.toJson(), equals(json));
    });
  });
}
