import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_for_fintech/core/cubit/user_cubit.dart';
import 'package:lesson_for_fintech/widgets/user_card.dart';

import '../boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myCubit = UserCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<UserCubit, UserState>(
          bloc: myCubit,
          listener: (context, state) {
            // print(" listener $state");
            if (state is UserNotConnection) {
              CherryToast.info(
                title: const Text("No InterNet"),
                action: const Text("Device hasn't connect internet"),
                animationType: AnimationType.fromTop,
                toastDuration: const Duration(seconds: 2),
                enableIconAnimation: true,
                displayCloseButton: false,
                toastPosition: Position.top,
                displayIcon: true,
              ).show(context);
            }
          },
          builder: (context, state) {
            var boxList = Boxes.hiveList;
            var res = context.watch<UserCubit>().response;
            if (state is UserNotConnection) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: true,
                      itemCount: boxList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return userCard(
                          context: context,
                          snap: boxList[index],
                        );
                      }),
                ],
              );
            } else if (state is UserLoading || res.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 2),
                  const Center(
                    child: CupertinoActivityIndicator(
                      animating: true,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    primary: true,
                    itemCount: res.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return userCard(
                        context: context,
                        snap: res[index],
                      );
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}
