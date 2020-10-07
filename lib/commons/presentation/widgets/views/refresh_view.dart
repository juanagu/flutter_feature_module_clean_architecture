import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshView extends StatelessWidget {
  final VoidCallback onLoad;
  final VoidCallback onRefresh;
  final Widget child;
  final RefreshViewController controller = RefreshViewController();
  final Function(RefreshViewController) onRefreshControllerCreated;

  RefreshView({
    Key key,
    this.onLoad,
    this.onRefresh,
    this.child,
    this.onRefreshControllerCreated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onRefreshControllerCreated != null) {
      onRefreshControllerCreated(controller);
    }

    return SmartRefresher(
      header: WaterDropHeader(),
      enablePullDown: onRefresh != null,
      controller: controller.refreshController,
      child: child,
      onRefresh: onRefresh,
      onLoading: onLoad,
    );
  }
}

class RefreshViewController {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void refreshCompleted() {
    refreshController.refreshCompleted();
  }

  void loadComplete() {
    refreshController.loadComplete();
  }

  void loadNoData() {
    refreshController.loadNoData();
  }
}
