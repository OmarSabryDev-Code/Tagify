import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagify/auth/log_in.dart';
import 'package:tagify/auth/sign_up.dart';
import 'package:tagify/cart/items_provider.dart';
import 'package:tagify/categories/Beauty.dart';
import 'package:tagify/categories/Electronics.dart';
import 'package:tagify/categories/Fashion.dart';
import 'package:tagify/categories/Pets.dart';
import 'package:tagify/categories/Sports.dart';
import 'package:tagify/content/content_screen.dart';
import 'package:tagify/content/home_tab.dart';
import 'package:tagify/content/item_detaile.dart';
import 'package:tagify/orders/order_details.dart';
import 'package:tagify/orders/orders_provider.dart';
import 'package:tagify/payment/card_provider.dart';
import 'package:tagify/payment/confirm_payment1.dart';
import 'package:tagify/payment/payment_cards.dart';
import 'package:tagify/profile/customer_support.dart';
import 'package:tagify/profile/personalize.dart';
import 'package:tagify/profile/profile_provider.dart';
import 'package:tagify/settings/accessibility.dart';
import 'package:tagify/settings/account.dart';
import 'package:tagify/settings/account_security.dart';
import 'package:tagify/settings/linking.dart';
import 'package:tagify/settings/privacy_security.dart';
import 'package:tagify/settings/settings_screen.dart';
import 'app_theme.dart';
import 'auth/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => OrdersProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ProfileProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CardsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ItemsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
    ],
        child: const Tagify(),
    ),
  );
}

class Tagify extends StatelessWidget {
  const Tagify({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SignUp.routeName: (_) => SignUp(),
        Linking.routeName: (_) => Linking(),
        SettingsScreen.routeName: (_) => SettingsScreen(),
        Account.routeName: (_) => Account(),
        AccountSecurity.routeName: (_) => AccountSecurity(),
        PrivacySecurity.routeName: (_) => PrivacySecurity(),
        Accessibility.routeName: (_) => Accessibility(),
        LoginScreen.routeName: (_) => LoginScreen(),
        ContentPage.routeName: (_) => ContentPage(),
        ItemDetails.routeName: (_) => ItemDetails(),
        ConfirmPayment1.routeName: (_) => ConfirmPayment1(),
        PaymentCards.routeName:(_) => PaymentCards(),
        Personalize.routeName:(_) => Personalize(),
        CustomerSupport.routeName: (_) => CustomerSupport(),
        OrderDetails.routeName: (_) => OrderDetails(),
        Beauty.routeName: (_) =>Beauty(),
        Fashion.routeName: (_) =>Fashion(),
        Electronics.routeName: (_) =>Electronics(),
        Sports.routeName: (_) =>Sports(),
        Pets.routeName: (_) =>Pets(),

      },
      initialRoute: LoginScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      //themeMode: AppTheme.lightTheme,
    );
  }
}

