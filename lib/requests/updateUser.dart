import 'package:food_e/core/GraphQLConfig.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:food_e/functions/queries.dart' as queries;


updateUser({required String id, String ? firstName, String ? lastName, String ? email}) async
{
  Map<String, dynamic> _result = {"status": false, "message": ""};
  GraphQLConfig _graphCnf = GraphQLConfig();
  GraphQLClient _client = _graphCnf.clientToQuery();
  QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(queries.query_updateUser(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName
        )),
      )
  );

  if (result.data != null) {
    _result["status"] = true;
  } else {
    _result["status"] = false;
    _result["message"] = result.exception!.graphqlErrors[0].message;
  }
  return _result;
}