import 'package:food_e/core/GraphQLConfig.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:food_e/functions/queries.dart' as queries;
import 'package:food_e/models/Categories.dart';


Future<List<Categories>> fetch_categories() async
{

  List<Categories> allCategories = [];

  GraphQLConfig _graphCnf = GraphQLConfig();
  GraphQLClient _client = _graphCnf.clientToQuery();
  QueryResult result = await _client.query(
      QueryOptions(
        document: gql(queries.query_fetchCategories()),
      )
  );
  if (result.data != null) {
    final dynamic data = Map<String, dynamic>.from(result.data!);
    for (var item in data['productCategories']['edges']){
      allCategories.add(Categories.formJson(item['node']));
    }
    return allCategories;
  }
  return allCategories;
}