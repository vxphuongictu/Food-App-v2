
class Login{
  String ? userID;
  String ? email;
  String ? firstname;
  String ? displayname;
  String ? authToken;


  Login({
    this.userID,
    this.email,
    this.firstname,
    this.displayname,
    this.authToken
  });

  factory Login.formJson(Map<String, dynamic> json)
  {
    return Login(
      userID: json['login']['user']['id'],
      email: json['login']['customer']['email'],
      firstname: json['login']['customer']['firstName'],
      displayname: json['login']['customer']['displayName'],
      authToken: json['login']['authToken']
    );
  }
}