import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/user_cubit.dart';
import 'cubit/user_state.dart';
import 'locator.dart';
import 'model/user_model.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubit + ValueNotifier + get_it Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userCubit = getIt<UserCubit>();


  @override
  void initState() {
    super.initState();

    userCubit.getUsers().then((_) {
      // gives flexibility to update UI when we want , it will not depends only on cubit state
      // also gives flexibility to update single item in list view after success state if we give value notifier to model itself
      userCubit.shouldUpdateUI.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return ValueListenableBuilder(
              valueListenable: userCubit.shouldUpdateUI,
              builder: (context, _, __) {
                return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final User user = state.users[index];
                    return ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
                      title: Text(user.firstName),
                      subtitle: Text(user.email),
                    );
                  },
                );
              },
            );
          } else if (state is UserError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
