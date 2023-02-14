import 'package:food_e/core/GraphQLConfig.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:food_e/functions/queries.dart' as queries;
import 'package:food_e/models/ForgotPassword.dart';


Future<ForgotPassword> forgotPassword({required String email}) async
{
  GraphQLConfig _graphCnf = GraphQLConfig();
  GraphQLClient _client = _graphCnf.clientToQuery();
  QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(queries.query_forgotPwd(email: email)),
      )
  );
  if (result.data != null) {
    final dynamic data = Map<String, dynamic>.from(result.data!);
    return ForgotPassword.formJson(data);
  }
  return ForgotPassword();
}

Future<String> changePassword({required String code, required String email, required String password}) async
{

  GraphQLConfig _graphCnf = GraphQLConfig();
  GraphQLClient _client = _graphCnf.clientToQuery();
  QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(queries.query_resetPasswd(code: code, email: email, new_pass: password)),
      )
  );
  try {
    return result.exception!.graphqlErrors[0].message;
  } catch (e) {
    return '';
  }
}