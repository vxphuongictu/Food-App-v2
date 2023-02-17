
/*
 * Login query
 * Register query
 * Forgot pass query
 * Reset pass query
 * Products query
 */


// Login query
String query_login({required String email, required String password})
{
  return '''
  mutation userLogin {
    login(input: {username: "${email}", password: "${password}"}) {
      user {
        id
      }
      customer {
        email
        firstName
        displayName
      }
      authToken
    }
  }
  ''';
}

// Register query
String query_register({required String email, required String password, required String fullname})
{

  String firstName = '';
  String lastName = '';

  try {
    var splitName = fullname.split(' ');
    firstName = splitName[0];
    for (var iName = 1; iName < splitName.length; iName ++) {
      lastName = lastName + " ${splitName[iName]}";
    }
  } catch (e) {
    //
  }

  return '''
  mutation userRegister {
    registerUser(
      input: {username: "${email}", password: "${password}", email: "${email}", firstName: "${firstName}", lastName: "${lastName}"}
    ) {
      clientMutationId
    }
  }
  ''';
}

// Forgot query
String query_forgotPwd({required String email})
{
  return '''
  mutation MyMutation {
  sendPasswordResetEmail(input: {username: "${email}"}) {
    success
  }
}
  ''';
}

// Reset pass query
String query_resetPasswd({required String code, required String email, required String new_pass})
{
  return '''
  mutation MyMutation {
    resetUserPassword(input: {key: "${code}", login: "${email}", password: "${new_pass}"}) {
      clientMutationId
    }
  }
  ''';
}

// fetch all products
String query_fetchProducts()
{
  return '''
    query fetchProducts {
      products {
        edges {
          node {
            ... on  SimpleProduct{
                id
                title
                name
                description
                price
                image {
                  sourceUrl
                }
              galleryImages {
                nodes {
                  sourceUrl
                }
              }
            }
            ... on VariableProduct {
                id
                title
                name
                description
                price
                image {
                  sourceUrl
                }
              	galleryImages {
                nodes {
                  sourceUrl
                }
              }
            }
          }
        }
      }
    }
  ''';
}

// get product details
String query_productDetails({required String id})
{
  return '''
  query fetchDetailProduct {
    product(id: "${id}") {
      ... on SimpleProduct {
        id
        name
        title
        price
        content
        galleryImages {
          nodes {
            sourceUrl
          }
        }
      }
      ... on VariableProduct {
        id
        name
        title
        price
        content
        galleryImages {
          nodes {
            sourceUrl
          }
        }
      }
    }
  }
  ''';
}

// fetch all categories
String query_fetchCategories()
{
  return '''
  query fetchCategories {
    productCategories {
      edges {
        node {
          id
          name
        }
      }
    }
  }
  ''';
}

// update user
String query_updateUser({required String id, String ? firstName, String ? lastName, String ? email})
{
  return '''
    mutation {
      updateUser(input:{
        id: "${id}",
        firstName: "${firstName}",
        lastName: "${lastName}",
        email: "${email}"
      }) {
        clientMutationId
      }
    }
  ''';
}

// delete user
String query_deleteUser({required String id}) {
  return '''
  mutation {
    deleteUser(input: {
      id: "${id}"
    }) {
      clientMutationId
      deletedId
    }
  
  }
  ''';
}

// search products
String query_search_products({required String name})
{
  return '''
  query MyQuery2 {
    products(where: {search: "${name}"}) {
      edges {
        node {
           ... on SimpleProduct {
            id
            name
            title
            price
            content
            image {
              sourceUrl
            }
            galleryImages {
              nodes {
                sourceUrl
              }
            }
          }
          ... on VariableProduct {
            id
            name
            title
            price
            content
            image {
              sourceUrl
            }
            galleryImages {
              nodes {
                sourceUrl
              }
            }
          }
        }
      }
    }
  }
  ''';
}