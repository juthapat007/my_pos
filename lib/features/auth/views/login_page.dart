import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pos_02/core/constants/set_space.dart';
import 'package:pos_02/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_event.dart';
import 'package:pos_02/features/widget/app_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _usernameCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   // late final AuthBloc _authBloc;

//   @override
//   void initState() {
//     super.initState();

//     // try {
//     //   _authBloc = Modular.get<AuthBloc>();
//     // } catch (e) {
//     //   rethrow;
//     // }
//   }

//   @override
//   void dispose() {
//     _usernameCtrl.dispose();
//     _passwordCtrl.dispose();
//     super.dispose();
//   }
//   //dispose คือ

//   void _handleLogin() {
//     if (_formKey.currentState!.validate()) {
//       FocusScope.of(context).unfocus();

//       // _authBloc.add(
//       //   LoginRequested(
//       //     username: _usernameCtrl.text.trim(),
//       //     password: _passwordCtrl.text,
//       //   ),
//       // );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ReadContext(context).read<AuthBloc>().add(AuthReset());
//     });

//     return BlocListener<AuthBloc, AuthState>(
//       //navigate ที่พี่ตอมพูดถึง
//       listener: (context, state) {
//         if (state is AuthUnauthenticated) {
//           Modular.to.navigate('/products/');
//         } else if (state is AuthError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message), backgroundColor: Colors.red),
//             //เอาไว้บอกว่า login ไปผ่าน
//           );
//         }
//       },
//       child: Scaffold(
//         body: BlocBuilder<AuthBloc, AuthState>(
//           builder: (context, state) {
//             final isLoading = state is AuthLoading;

//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('LOGIN!'),
//                     SizedBox(height: space.m),
//                     AppTextFormField(
//                       controller: _usernameCtrl,
//                       label: 'Username',
//                       icon: Icons.person,
//                       enabled: !isLoading,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your username';
//                         }
//                         return null;
//                       },
//                     ),

//                     SizedBox(height: space.m),

//                     AppTextFormField(
//                       controller: _passwordCtrl,
//                       label: 'Password',
//                       icon: Icons.lock,
//                       obscureText: true,
//                       enabled: !isLoading,
//                       textInputAction: TextInputAction.done,
//                       onSubmitted: _handleLogin,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         }
//                         return null;
//                       },
//                     ),

//                     SizedBox(height: space.xl),

//                     SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: ElevatedButton(
//                         onPressed: isLoading
//                             ? null
//                             : () {
//                                 ReadContext(context).read<AuthBloc>().add(
//                                   LoginRequested(
//                                     username: _usernameCtrl.text,
//                                     password: _passwordCtrl.text,
//                                   ),
//                                 );
//                               },
//                         child: isLoading
//                             ? const SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Colors.white,
//                                 ),
//                               )
//                             : const Text(
//                                 'Login',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      ReadContext(context).read<AuthBloc>().add(
        LoginRequested(
          username: _usernameCtrl.text.trim(),
          password: _passwordCtrl.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          print('✅ Login Success - Navigating to /products/');
          Modular.to.navigate('/products');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'LOGIN!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: space.m),
                    AppTextFormField(
                      controller: _usernameCtrl,
                      label: 'Username',
                      icon: Icons.person,
                      enabled: !isLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: space.m),
                    AppTextFormField(
                      controller: _passwordCtrl,
                      label: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                      enabled: !isLoading,
                      textInputAction: TextInputAction.done,
                      onSubmitted: _handleLogin,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: space.xl),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _handleLogin,
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
