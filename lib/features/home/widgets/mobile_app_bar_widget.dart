import 'package:flutter/material.dart';
import 'search_bar_widget.dart';
import 'login_dropdown_button.dart';

class MobileAppBarWidget extends StatelessWidget {
  final bool bgTrans;
  final bool enableSearch;

  const MobileAppBarWidget({
    super.key,
    this.bgTrans = false,
    this.enableSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      color: bgTrans ? Colors.transparent : Theme.of(context).primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  // TODO: Open drawer or menu
                },
              ),
              Expanded(
                child: enableSearch
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SearchBarWidget(
                          onSubmitted: (val) {
                             // Handle search
                             print('Search for: $val');
                          },
                        ),
                      )
                    : const Center(
                        child: Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
               const SizedBox(width: 8),
               // Replaced Notification Icon with Login Button
               const LoginDropdownButton(),
            ],
          ),
        ),
      ),
    );
  }
}
