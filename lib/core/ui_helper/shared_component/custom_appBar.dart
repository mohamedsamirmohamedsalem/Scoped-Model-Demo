import 'package:scoped_model_demo/core/logic_helper/import_all.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool ableToBack;
  final bool showNotification;
  const CustomAppBar({
    super.key,
    this.title = "",
    this.ableToBack = true,
    this.showNotification = false,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: appTheme.gray300, height: 0.3)),
      centerTitle: true,
      title: Text(widget.title, style: CustomTextStyles.blackBold18),
      leading: widget.ableToBack
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: context.router.back,
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.onSecondaryColor,
                ),
              ),
            )
          : const SizedBox(),
      actions: [
        // widget.showNotification
        //     ? context.watch<NotificationProvider>().notificationCount == 0
        //         ? GestureDetector(
        //             onTap: () => context.router.push(const NotificationRoute()),
        //             child: const Padding(
        //               padding: EdgeInsets.symmetric(horizontal: 20),
        //               child: Icon(
        //                 Icons.notifications_none_rounded,
        //                 color: Colors.black,
        //               ),
        //             ),
        //           )
        //         : GestureDetector(
        //             onTap: () => context.router.push(const NotificationRoute()),
        //             child: Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 20),
        //               child: Badge(
        //                 label: Text(context
        //                     .watch<NotificationProvider>()
        //                     .notificationCount
        //                     .toString()),
        //                 largeSize: 15,
        //                 textStyle: const TextStyle(fontSize: 12),
        //                 child: const Icon(
        //                   Icons.notifications_none_rounded,
        //                   color: Colors.black,
        //                 ),
        //               ),
        //             ),
        //           )
        //     : const SizedBox()
      ],
    );
  }
}
