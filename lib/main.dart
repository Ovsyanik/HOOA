import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hooa/bloc/CardBloc.dart';
import 'package:hooa/bloc/UserBloc.dart';
import 'package:hooa/page/callback.dart';
import 'package:hooa/bloc/salesBloc.dart';
import 'package:hooa/bloc/staffBloc.dart';
import 'package:hooa/bloc/signUpBloc.dart';
import 'package:hooa/bloc/serviceBloc.dart';
import 'package:hooa/bloc/statisticBloc.dart';
import 'package:hooa/page/mainContainer.dart';
import 'package:hooa/bloc/InstitutionBloc.dart';
import 'package:hooa/page/mainContainerUser.dart';
import 'package:hooa/page/records/addRecord.dart';
import 'package:hooa/page/service/ChangeService.dart';
import 'package:hooa/page/signUpAndSignIn/signIn.dart';
import 'package:hooa/page/service/AddServicePage.dart';
import 'package:hooa/page/signUpAndSignIn/signUp.dart';
import 'package:hooa/page/user/personal/AddNewCard.dart';
import 'package:hooa/page/user/personal/SelectAction.dart';
import 'package:hooa/page/user/personal/PaymentMethods.dart';
import 'package:hooa/page/profile/ChangeProfileInstitution.dart';
import 'package:hooa/page/signUpAndSignIn/passwordRecovery.dart';
import 'package:hooa/page/service/service.dart';
import 'package:hooa/page/signUpAndSignIn/signInOrSignUp.dart';
import 'package:hooa/page/signUpAndSignIn/signUpSecondInstitution.dart';
import 'package:hooa/page/signUpAndSignIn/signUpSecondUser.dart';
import 'package:hooa/page/staff/addStaff.dart';
import 'package:hooa/page/staff/changeStaff.dart';
import 'package:hooa/page/staff/selectedStaff.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SignUpBloc>(
          create: (BuildContext context) => SignUpBloc(),
          dispose: (_, SignUpBloc signUpBloc) => signUpBloc.dispose(),
        ),
        Provider<StaffBloc>(
          create: (BuildContext context) => StaffBloc(),
          // dispose: (_, StaffBloc staffBloc) => staffBloc.(),
        ),
        Provider<SalesBloc>(
          create: (BuildContext context) => SalesBloc(),
          // dispose: (_, StaffBloc staffBloc) => staffBloc.(),
        ),
        Provider<StatisticBloc>(
          create: (BuildContext context) => StatisticBloc(),
          dispose: (_, StatisticBloc statisticBloc) => statisticBloc.dispose(),
        ),
        Provider<ServicesBloc>(
          create: (BuildContext context) => ServicesBloc(),
          // dispose: (_, ServicesBloc servicesBloc) => servicesBloc.dispose(),
        ),
        Provider<InstitutionBloc>(
          create: (BuildContext context) => InstitutionBloc(),
          // dispose: (_, ServicesBloc servicesBloc) => servicesBloc.dispose(),
        ),
        Provider<UserBloc>(
          create: (BuildContext context) => UserBloc(),
          // dispose: (_, ServicesBloc servicesBloc) => servicesBloc.dispose(),
        ),
        Provider<CardBloc>(
          create: (BuildContext context) => CardBloc(),
          // dispose: (_, ServicesBloc servicesBloc) => servicesBloc.dispose(),
        ),
      ],
      child: MaterialApp(
        title: 'HOOA',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Proxima Nova',
          scaffoldBackgroundColor: HexColor('#F2F2F2'),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SignInOrSignUpPage(),
          '/signIn': (context) => SignInPage(),
          '/signUp': (context) => SignUpPage(),
          '/signUpInstitution': (context) => SignUpSecondInstitutionPage(),
          '/signUpUser': (context) => SignUpSecondUserPage(),
          '/recoveryPassword': (context) => PasswordRecoveryPage(),
          '/mainContainer': (context) => MainContainerPage(),
          '/mainContainerUser': (context) => MainContainerUserPage(),
          '/addStaff': (context) => AddStaffPage(),
          '/selectedStaff': (context) => SelectedStaffPage(),
          '/changeStaff': (context) => ChangeStaff(),
          '/services': (context) => ServicesPage(),
          '/addService': (context) => AddServicePage(),
          '/changeService': (context) => ChangeServicePage(context: context),
          '/callback': (context) => CallbackPage(),
          '/addRecord': (context) => AddRecordPage(),
          '/changeProfileInstitution': (context) => ChangeProfileInstitution(),
          '/addNewCard': (context) => AddNewCardPage(),
          '/selectActionUser': (context) => SelectActionPage(),
          '/paymentMethods': (context) => PaymentMethods(),
        },
      ),
    );
  }
}
