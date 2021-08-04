// import 'package:assignments/src/components/my_loading_overlay.dart';
// import 'package:assignments/src/cubits/login_cubit/login_cubit.dart';
// import 'package:division/division.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginScreen extends StatelessWidget {
//   static const routeName = '/login';

//   LoginScreen({
//     Key key,
//   }) : super(key: key);

//   final formKey = GlobalKey<FormState>();
//   final credentials = <String, dynamic>{};

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<LoginCubit, LoginState>(
//       listener: (context, state) {
//         state.maybeWhen(
//           failure: (message) {}, //=> Helpers.showErrorDialog(context, error: S.of(context).wrong_username_or_password),
//           success: () {},
//           orElse: () {},
//         );
//       },
//       builder: (context, state) {
//         final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);

//         return MyLoadingOverLay(
//           isLoading: isLoading,
//           child: Scaffold(
//             body: Parent(
//               style: ParentStyle()..background.image(path: 'assets/images/rgbg.jpg', fit: BoxFit.cover),
//               child: Parent(
//                 style: ParentStyle()
//                   // ..linearGradient(
//                   //   // colors: [kAppOrange.withOpacity(.7), kAppGrey.withOpacity(.7)],
//                   //   begin: Alignment.topRight,
//                   //   end: Alignment.bottomLeft,
//                   // ),
//                 child: Center(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: kAppSizes.appHorizontalPadding(10)),
//                     child: Form(
//                       key: formKey,
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Center(child: Logo()),
//                             const SizedBox(height: 10),
//                             const Center(
//                               child: Text.rich(
//                                 TextSpan(
//                                   children: [
//                                     TextSpan(text: 'Keep '),
//                                     TextSpan(text: 'UP', style: TextStyle(color: kAppOrange)),
//                                     TextSpan(text: ' With The Sports!'),
//                                   ],
//                                 ),
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             const LanguageSwitcher(),
//                             const SizedBox(height: 5),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: kAppSizes.appHorizontalPadding(20)),
//                               child: const Divider(thickness: 2, height: 5, color: Colors.white),
//                             ),
//                             const SizedBox(height: 10),
//                             FormHelper.buildTextInput(context, credentials, const FormFieldType.username(), enabled: !isLoading),
//                             // _buildTextFiled(type: const FormFieldType.email(), mution: const FormFieldType.username(), enabled: !isLoading),
//                             const SizedBox(height: 20),
//                             // _buildTextFiled(type: const FormFieldType.password(), mution: const FormFieldType.password(), enabled: !isLoading, obscureText: true),
//                             StatefulBuilder(builder: (context, setState) {
//                               return FormHelper.buildTextInput(
//                                 context,
//                                 credentials,
//                                 const FormFieldType.password(),
//                                 obscureText: _hidePassword,
//                                 enabled: !isLoading,
//                                 suffixIcon: IconButton(
//                                   onPressed: () => setState(() => _hidePassword = !_hidePassword),
//                                   color: Theme.of(context).focusColor,
//                                   icon: Icon(_hidePassword ? Icons.visibility : Icons.visibility_off, color: Colors.white),
//                                 ),
//                               );
//                             }),
//                             const SizedBox(height: 10),
//                             _buildRow(context, label: S.of(context).forgot_your_password, helpText: 'Help with Forgot Your Password', onPressed: () {
//                               AppRouter.sailor.navigate(ForgetPasswordScreen.routeName, params: {'usingDRC': false});
//                             }),
//                             _buildRow(context, label: S.of(context).have_data_recovery_code, helpText: 'Help with Have Data Recovery Code', onPressed: () {
//                               AppRouter.sailor.navigate(ForgetPasswordScreen.routeName, params: {'usingDRC': true});
//                             }),
//                             const SizedBox(height: 10),
//                             if (isLoading)
//                               const Center(child: CircularProgressIndicator())
//                             else
//                               TextButton(
//                                 onPressed: () async {
//                                   Helpers.dismissFauces(context);
//                                   if (formKey.currentState.validate()) {
//                                     formKey.currentState.save();
//                                     context.read<LoginCubit>().login(credentials);
//                                   }
//                                 },
//                                 style: TextButton.styleFrom(
//                                   backgroundColor: kAppOrange,
//                                   shape: const RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(25),
//                                     ),
//                                   ),
//                                 ),
//                                 child: Txt(
//                                   S.current.sign_in,
//                                   style: TxtStyle()
//                                     ..bold()
//                                     ..fontSize(22)
//                                     ..textColor(Colors.white),
//                                 ),
//                               ),
//                             const SizedBox(height: 10),
//                             _buildRow(context, label: S.of(context).dont_have_an_account, helpText: 'Help with Dont Have An Account', onPressed: () {
//                               AppRouter.sailor.navigate(SignUpScreen.routeName);
//                             }),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Row _buildRow(BuildContext context, {@required String label, @required String helpText, @required VoidCallback onPressed}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: () {
//             Helpers.showMessageDialog(context, message: helpText);
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(3),
//             child: SvgPicture.asset('assets/icons/q.svg', height: 15, width: 15),
//           ),
//         ),
//         const SizedBox(width: 5),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 12, color: Colors.white),
//         ),
//         GestureDetector(
//           onTap: onPressed,
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Text(
//               S.of(context).click_here,
//               style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildUnderButtons(String img, String title, Function() onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Image.asset('assets/icons/$img'),
//           Txt(
//             title,
//             style: TxtStyle()..textColor(Colors.white),
//           )
//         ],
//       ),
//     );
//   }

//   // Widget _buildTextFiled({
//   //   @required FormFieldType type,
//   //   FormFieldType mution,
//   //   bool enabled = true,
//   //   bool obscureText = false,
//   // }) {
//   //   final _model = FormFieldModel.mapType(type, credentials);
//   //   final _mution = FormFieldModel.mapType(mution, credentials);

//   //   return Parent(
//   //     // style: ParentStyle()..margin(horizontal: 69),
//   //     child: InputLayout(
//   //       endChild: Parent(
//   //         style: ParentStyle()
//   //           ..scale(.5)
//   //           ..height(10),
//   //         child: SvgPicture.asset(
//   //           'assets/icons/${_mution.iconAsSvg}',
//   //         ),
//   //       ),
//   //       hint: _mution.hintText,
//   //       // validator: _model.validator,
//   //       isSecure: obscureText,
//   //       onSaved: _model.onSave,
//   //       inputType: _model.keyboardType,
//   //       enabled: enabled,
//   //     ),
//   //   );
//   // }

// }
