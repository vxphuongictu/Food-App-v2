/*
* Colors
* You can enter string color bellow in https://www.w3schools.com/colors/colors_picker.asp to view it
* Using function toColor() to convert string color to hex
*/

const String colorBlack = "#000000";
const String colorGray = "#a3a3a3";
const String colorOrange = "#f99928";
const String colorWhite = "#ffffff";
const String colorMainStreamBlue = "#2fdbbc";
const String colorLightBlack = "#2d2d2d";
const String colorLightGrayShadow = "#bfbfbf";
const String colorGrayInputBg = "#f4f4f4";
const String colorLightRed = "#ff8080";
const String colorGreen = "#4fe178";

/* global */
bool darkMode = false;
const String lightModeColorbg = colorWhite;
const String darkModeColorbg = colorLightBlack;
const double marginScreen = 20.0; // the distance between the content and the margin of the screen
const double leadingIconSize = 22.0;

/* config large button */
const double large_button_h = 60.0;
const double large_button_radius = 30.0;
const double large_button_font_size = 18.0;

/* config text */
const double text_size = 18.0;
const int text_max_lines = 2;

/* config title */
const double title_font_size = 36.0;
const double input_radius = 20.0;
const double input_text_fontSize = 16.0;
const double input_padding_left_text = 20.0;
const int input_time_duration = 400; // miliseconds

/* Welcome Screen */
const double wcLogoMarginTop = 50.0;
const double wcLogoMarginLeft = 20.0;
const String wcWhiteText = colorWhite;
const double wcDistanceButtonAndText = 70.0;

/* Box Item */
const double boxItemMaxSize = 157.0;
const double boxItemMRadius = 10.0;
const double boxItemThumbnailSize = 157.0;

/* Box restaurants */
const double boxRestaurantsSize = 80.0;

/* Search Config */
const double searchMaxCatInScreen = 5.0;
const double searchMaxHistory = 10.0;


/* Time to resend Mail */
const int ForgotPwdTimeToResend = 30;

/* graphql api */
const httpLink_cnf = "http://72.arrowhitech.net/tn3/mixy_server/graphql";

/* fetch countries in Viet Nam */
const String country_uri_api = "https://restcountries.com/v3.1/all";

/* Stripe config */
const stripePublishableKey= "pk_test_51LxN7XGJqKLBeEi3fUQfPStpw4vkGAt0Z1EruqdRWz1xFOpqLsuMAGnosRvbSaW4aK6SCIdhkLkzfiXiAzJwWVPy00HmU1z5VX";
const stripeSeretKey      = "sk_test_51LxN7XGJqKLBeEi3xrkicBrbKyqD0vDRkri353VbQgWgruqFQhMmW7uzbczYGX4DBhkbdTEiFz2wGeS15aAoFtmc007OJxtbLr";
const payment_intents_url = "api.stripe.com/v1/payment_intents";
const payment_test_mode   = true; // test mode or live mode payment