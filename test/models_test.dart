import 'package:coffemate/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Coffe', () {
    test('constructor assigns fields correctly', () {
      const coffe = Coffe(
        name: 'Test',
        email: 'test@example.com',
        azucar: 2,
        stevia: 1,
        coffee: 5,
      );

      expect(coffe.name, 'Test');
      expect(coffe.email, 'test@example.com');
      expect(coffe.azucar, 2);
      expect(coffe.stevia, 1);
      expect(coffe.coffee, 5);
    });

    test('toJson returns correct map', () {
      const coffe = Coffe(
        name: 'Alice',
        email: 'alice@example.com',
        azucar: 1,
        stevia: 0,
        coffee: 3,
      );

      final json = coffe.toJson();

      expect(json['name'], 'Alice');
      expect(json['email'], 'alice@example.com');
      expect(json['azucar'], 1);
      expect(json['stevia'], 0);
      expect(json['coffee'], 3);
    });

    test('fromJson creates Coffe from valid map', () {
      final json = <String, Object?>{
        'name': 'Bob',
        'email': 'bob@example.com',
        'azucar': 0,
        'stevia': 2,
        'coffee': 7,
      };

      final coffe = Coffe.fromJson(json);

      expect(coffe.name, 'Bob');
      expect(coffe.email, 'bob@example.com');
      expect(coffe.azucar, 0);
      expect(coffe.stevia, 2);
      expect(coffe.coffee, 7);
    });

    test('fromJson throws when keys are missing', () {
      expect(
        () => Coffe.fromJson(<String, Object?>{}),
        throwsA(isA<TypeError>()),
      );
    });

    test('toJson and fromJson are inverse', () {
      const original = Coffe(
        name: 'Charlie',
        email: 'charlie@example.com',
        azucar: 3,
        stevia: 1,
        coffee: 11,
      );

      final json = original.toJson();
      final restored = Coffe.fromJson(json);

      expect(restored.name, original.name);
      expect(restored.email, original.email);
      expect(restored.azucar, original.azucar);
      expect(restored.stevia, original.stevia);
      expect(restored.coffee, original.coffee);
    });
  });
}
