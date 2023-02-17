import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_e/core/_config.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


Future<dynamic> createPaymentIntents({String ? id, int ? amount, String ? currency}) async {

  final response = await http.post(
    Uri.parse("https://$stripeSeretKey:@$payment_intents_url"),
    body: {
      'amount': "${amount}",
      'currency': "${currency}",
      'payment_method': "${id}",
      'payment_method_types[]': 'card'
    },
  );
  return jsonDecode(response.body);
}


Future<void> confirmIntents({String ? id, String ? payment_method}) async {
  await http.post(
      Uri.parse('https://${stripeSeretKey}:@${payment_intents_url}/${id}/confirm'),
      body: {
        'payment_method' : payment_method
      }
  );
}


Future<bool> handlePayPress({required String email, required String phone, required String city, required String country, required String postCode, required double total_price}) async {

  bool bank_status = true;

  final billingDetails = BillingDetails(
    email: email,
    phone: phone,
    address: Address(
      city: city,
      country: country,
      postalCode: postCode,
      line1: '',
      line2: '',
      state: '',
    ),
  ); // mocked data for tests

  // 2. Create payment method
  //
  // final paymentMethod = await Stripe.instance.createPaymentMethod(
  //     params: PaymentMethodParams.card(
  //       paymentMethodData: PaymentMethodData(
  //         billingDetails: billingDetails,
  //       ),
  //     ));
  //
  // // 3 Create payment intents
  // final payment_intents = await createPaymentIntents(id: paymentMethod.id ,amount: (total_price * 1000).round(), currency: 'usd');
  //
  // if (payment_intents['status'] == "requires_confirmation") {
  //   // 4 confirm intents
  //   await confirmIntents(id: payment_intents['id'], payment_method: (payment_test_mode == true) ? 'pm_card_visa' : paymentMethod.id);
  // }
  //
  // // 5 handle payment
  // final paymentHandle = await Stripe.instance.handleNextAction(payment_intents['client_secret']);
  //
  // if (paymentHandle.status.toString() == "PaymentIntentsStatus.Succeeded") {
  //   bank_status = true;
  // }

  return bank_status;
}