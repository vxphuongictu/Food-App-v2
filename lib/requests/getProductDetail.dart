import 'package:food_e/core/GraphQLConfig.dart';
import 'package:food_e/models/ProductDetails.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:food_e/functions/queries.dart' as queries;


Future<ProductDetails> product_detail({required String id}) async
{
  GraphQLConfig _graphCnf = GraphQLConfig();
  GraphQLClient _client = _graphCnf.clientToQuery();
  QueryResult result = await _client.query(
      QueryOptions(
        document: gql(queries.query_productDetails(id: id)),
      )
  );
  if (result.data != null) {
    final dynamic data = Map<String, dynamic>.from(result.data!);
    return ProductDetails.fromJson(data['product']);
  }
  return ProductDetails();
}