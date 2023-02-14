import 'package:food_e/core/GraphQLConfig.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:food_e/functions/queries.dart' as queries;
import 'package:food_e/models/Login.dart';


Future<Login> login({required String email, required String password}) async
{
  GraphQLConfig _graphCnf = GraphQLConfig();
  GraphQLClient _client = _graphCnf.clientToQuery();
  QueryResult result = await _client.mutate(
    MutationOptions(
      document: gql(queries.query_login(email: email, password: password)),
    )
  );

  if (result.data != null) {
    final dynamic data = Map<String, dynamic>.from(result.data!);
    return Login.formJson(data);
  }
  return Login();
}