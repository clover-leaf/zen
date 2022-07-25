import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/message/message.dart';
import 'package:intl/intl.dart';
import 'package:iot_repository/iot_repository.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  static PageRoute route() {
    return MaterialPageRoute<void>(
      builder: (context) => const MessagePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MessageBloc(
        repository: context.read<IotRepository>(),
      )..add(const GetAllMessages()),
      child: const MessageView(),
    );
  }
}

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((MessageBloc bloc) => bloc.state.status);
    final messages = context.select((MessageBloc bloc) => bloc.state.messages);
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: const NavBar(),
      body: Column(
        children: [
          Header(
            title: 'Messages',
            subtitle: '${messages.length} messages',
            hasBackButton: false,
          ),
          if (status == MessageStatus.loading)
            const LoadingCircle()
          else if (status == MessageStatus.failure)
            const Text('Failure')
          else if (status == MessageStatus.success)
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 32,
                    ),
                    alignment: Alignment.center,
                    color: const Color(0xffffffff),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.title,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              DateFormat('hh:mm a MMMM d, y')
                                  .format(message.createAt),
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (!message.isReaded)
                          Container(
                            height: 12,
                            width: 12,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffF04243),
                            ),
                          )
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, __) => Container(
                  color: const Color(0xffe5e5e5),
                  height: 2,
                ),
                itemCount: messages.length,
              ),
            ),
        ],
      ),
    );
  }
}
