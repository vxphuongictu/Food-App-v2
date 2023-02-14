
class ForgotPassword{
  bool ? message;


  ForgotPassword({
    this.message,
  });

  factory ForgotPassword.formJson(Map<String, dynamic> json)
  {
    return ForgotPassword(
        message: json['sendPasswordResetEmail']['success'],
    );
  }
}