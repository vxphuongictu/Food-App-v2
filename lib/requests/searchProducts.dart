import 'package:food_e/core/GraphQLConfig.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:food_e/functions/queries.dart' as queries;
import 'package:food_e/models/Products.dart';


Future<List<Products>> searchProduct({required String name}) async
{
  List<Products> allProducts = [];

  GraphQLConfig _graphCnf = GraphQLConfig();
  GraphQLClient _client = _graphCnf.clientToQuery();
  QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(queries.query_search_products(name: name)),
      )
  );

  if (result.data != null) {
    final dynamic data = Map<String, dynamic>.from(result.data!);
    for (var item in data['products']['edges']) {
      final data = Products.formJson(item['node']);
      allProducts.add(data);
    }
  }
  return allProducts;
}