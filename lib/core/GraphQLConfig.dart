/*
 * Reference source: https://murainoyakubu.medium.com/simplified-graphql-implementations-for-query-and-mutation-in-flutter-9bce1deda792
 */

import 'package:flutter/cupertino.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:graphql_flutter/graphql_flutter.dart';


class GraphQLConfig {
  static HttpLink httpLink = HttpLink(cnf.httpLink_cnf);

  static ValueNotifier<GraphQLClient> graphInit() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(
          store: HiveStore()
        )
      ),
    );
    return client;
  }

  GraphQLClient clientToQuery()
  {
    return GraphQLClient(
      cache: GraphQLCache(
        store: HiveStore()
      ),
      link: httpLink
    );
  }
}