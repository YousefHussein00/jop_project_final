import 'package:flutter/material.dart';
import 'package:jop_project/Providers/Searchers/searchers_provider.dart';
import 'package:jop_project/Providers/SignUp/company_signin_login_provider.dart';
import 'package:jop_project/Providers/SignUp/searcher_signin_login_provider.dart';
import 'package:jop_project/Screens/ChatScreen/chat_screen.dart';
import 'package:jop_project/components/background.dart';
import 'package:jop_project/l10n/l10n.dart';
import 'package:jop_project/responsive.dart';
import 'package:provider/provider.dart';

import '../../Models/chat/chat_model.dart';
import '../../Providers/Caht-firebase_database/chat_provider_firebase_database.dart';
import '../../size_config.dart';

class CompanyChatsScreen extends StatelessWidget {
  final String companyId;

  const CompanyChatsScreen({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final l10n = AppLocalizations.of(context);

    return Background(
      height: SizeConfig.screenH! / 6,
      userImage: context
              .read<CompanySigninLoginProvider>()
              .currentCompany
              ?.img ??
          context.read<SearcherSigninLoginProvider>().currentSearcher?.img ??
          '',
      userName: context
              .read<CompanySigninLoginProvider>()
              .currentCompany
              ?.nameCompany ??
          context.read<SearcherSigninLoginProvider>().currentSearcher?.img ??
          '',
      isCompany:
          context.read<SearcherSigninLoginProvider>().currentSearcher?.img ==
                  null
              ? true
              : false,
      showListNotiv: true,
      title: l10n.chats,
      child: Responsive(
        mobile: StreamBuilder<List<ChatModel>>(
          stream: chatProvider.getChatsByCompanyId(companyId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No chats available'));
            } else {
              List<ChatModel> chats = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  ChatModel chat = chats[index];
                  return Card(
                    color: Colors.white,
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                    context
                                            .watch<SearchersProvider>()
                                            .getSearcherById(
                                                int.parse(chat.searcherId!))!
                                            .img ??
                                        '',
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;

                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(loadingProgress.expectedTotalBytes !=
                                              null
                                          ? (loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!)
                                              .toStringAsFixed(2)
                                          : ''),
                                      const CircularProgressIndicator(),
                                    ],
                                  );
                                }, errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 50,
                                  );
                                })
                                // : const Icon(
                                //     Icons.person,
                                //     size: 50,
                                //   ),
                                ),
                          ),
                          if ('${chat.messages?.last.isRead!['']}' == 'false')
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                      title: Text(context
                          .watch<SearchersProvider>()
                          .getSearcherById(int.parse(chat.searcherId!))!
                          .fullName!),
                      subtitle: Text('${chat.messages?.last.text}...'),
                      onTap: () {
                        var searcherId = chat.chatId?.split('_');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              chatId: chat.chatId!,
                              readerId: chat.companyId!,
                              searchersModel: context
                                  .watch<SearchersProvider>()
                                  .searchers
                                  .where(
                                    (element) =>
                                        element.id.toString() == searcherId![0],
                                  )
                                  .first,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
        desktop: StreamBuilder<List<ChatModel>>(
          stream: chatProvider.getChatsByCompanyId(companyId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No chats available'));
            } else {
              List<ChatModel> chats = snapshot.data!;
              return ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  ChatModel chat = chats[index];
                  return ListTile(
                    title: Text('Chat with Searcher ${chat.searcherId}'),
                    subtitle: Text('Last message: ${chat.messages!.last.text}'),
                    onTap: () {
                      var searcherId = chat.chatId?.split('_');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            chatId: chat.chatId!,
                            readerId: chat.companyId!,
                            searchersModel: context
                                .watch<SearchersProvider>()
                                .searchers
                                .where(
                                  (element) =>
                                      element.id.toString() == searcherId![0],
                                )
                                .first,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
