import 'package:food_e/core/GraphQLConfig.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:food_e/functions/queries.dart' as queries;

register({required String email, required String password, required String fullname}) async
{
  GraphQLConfig _graphCnf = GraphQLConfig();
  GraphQLClient _client = _graphCnf.clientToQuery();
  QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(queries.query_register(email: email, password: password, fullname: fullname)),
      )
  );
  try {
    return result.exception!.graphqlErrors[0].message;
  } catch (e) {
    return '';
  }
}