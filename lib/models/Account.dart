/*
 * model of account in shared preferences
 */

class Account
{
  String ? userID;
  String ? email;
  String ? firstname;
  String ? displayname;
  String ? authToken;


  Account({
    this.userID,
    this.email,
    this.firstname,
    this.displayname,
    this.authToken
  });

  factory Account.formJson(Map<String, dynamic> json)
  {
    return Account(
        userID: json['userID'],
        email: json['email'],
        firstname: json['firstname'],
        displayname: json['displayname'],
        authToken: json['authToken'],
    );
  }
}