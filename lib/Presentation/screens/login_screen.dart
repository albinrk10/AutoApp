import 'package:flutter/material.dart';
import 'package:productos_app/Presentation/providers/login_form_provider.dart';

import 'package:productos_app/Presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../widgets/input_deco.dart';



class LoginScreen extends StatelessWidget {

  
  const LoginScreen({super.key});

   
  
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AuthBackground(
        child:SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 250,),

              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10,),

                    Text('Iniciar Sesion',style: Theme.of(context).textTheme.headline4,),

                    SizedBox(height: 30,),

                    ChangeNotifierProvider(
                      create:( _ )=> LoginFormProvider() ,
                      child: _LoginForm(),
                    ),
                    

                  ],
                )
              ),

              SizedBox(height: 50,),
              Text('Crear una nueva cuenta',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 50,),
            ],
          ),
        ) 
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});
  
  @override
  Widget build(BuildContext context) {
    final loginForm=Provider.of<LoginFormProvider>(context);
    return Container(
        child: Form(
          //TODO las referncias al key
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,



          child:Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'albin@gmail,com',
                  labelText: 'Correro electronico',
                  prefixIcon: Icons.alternate_email_sharp
                ),
                onChanged: (value) => loginForm.email=value ,
                validator: (value) {
                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = new RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                  ?null
                  :'El valor ingresado no luce como un correo ';
                },

              ),
              SizedBox(height: 30,),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '*******',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outlined
                ),
                onChanged: (value) => loginForm.password=value ,
                validator: (value) {
                  return (value != null && value.length >=6  ) 
                  ? null
                  :  'La contraseña deve de ser de 6 caracteres';
                },

              ),
              SizedBox(height: 30,),

              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80,vertical: 15),
                  child: Text(
                    loginForm.isLoading
                    ?'Espere.....'
                    :'Ingresar',
                    

                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed:loginForm.isLoading?null:()async {
                //TODO Login form
                FocusScope.of(context).unfocus();
                if (!loginForm.isValidForm())return;
                loginForm.isLoading=true;

                Future.delayed(Duration(seconds: 2));
                //TODO validadr si es correcto 
                loginForm.isLoading=false;


                  Navigator.pushNamed(context, 'home');
              },
               
               )


            ],
          )
           ),
    );
  }
}