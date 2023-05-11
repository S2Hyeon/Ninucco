import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ninucco/models/user_detail_model.dart';
import 'package:ninucco/providers/auth_provider.dart';
import 'package:ninucco/screens/profile/profile_scan_result.dart';
import 'package:ninucco/services/user_service.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

/// Todo
/// [] settings에서 받아온 유저 데이터로 연결하기
/// [] settings에서 받아온 유저와 provider의 유저와 비교해서 본인인지 확인
/// [] 내가 아닌경우 친구신청
/// [] 나인 경우 can edit
///

class _MyProfileScreenState extends State<MyProfileScreen>
    with TickerProviderStateMixin {
  final List<String> tabs = <String>['검사결과', '배틀이력', '아이템'];
  bool inited = false;
  late TabController _tabController = TabController(length: 3, vsync: this);
  late String userId;
  late bool canGoBack;

  UserDetailData? _userDetailData;
  Future<void>? _initUserDetail;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Future<void> _initDatas(String id) async {
    final data = await UserService.getUserDetailById(id);
    _userDetailData = data;
  }

  Future<void> _refreshData(String id) async {
    final data = await UserService.getUserDetailById(id);
    setState(() {
      _userDetailData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var me = authProvider.member;
    if (inited == false && me?.id != null) {
      _initUserDetail = _initDatas(me!.id);
      inited = true;
    }

    var myTabBar = TabBar(
      controller: _tabController,
      indicatorColor: Colors.teal,
      labelColor: Colors.teal,
      unselectedLabelColor: Colors.black54,
      isScrollable: true,
      tabs: tabs
          .map(
            (e) => SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Tab(
                text: e,
              ),
            ),
          )
          .toList(),
    );

    return DefaultTabController(
      length: tabs.length, // This is the number of tabs.
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: FutureBuilder(
                    future: _initUserDetail,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        return SliverPersistentHeader(
                          pinned: true,
                          delegate: HomeSliverAppBar(
                            expandedHeight: 450.0,
                            height: 96,
                            tabbar: myTabBar,
                            userData: null,
                          ),
                        );
                      }
                      return SliverPersistentHeader(
                        pinned: true,
                        delegate: HomeSliverAppBar(
                          expandedHeight: 450.0,
                          height: 96,
                          tabbar: myTabBar,
                          userData: _userDetailData,
                        ),
                      );
                    }),
              ),
            ],
            body: TabBarView(
                controller: _tabController,
                children: tabs
                    .map((name) => SafeArea(
                          top: false,
                          bottom: false,
                          child: FutureBuilder(
                            future: _initUserDetail,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.active ||
                                  _userDetailData == null) {
                                return const Text("LOADING...");
                              }
                              return RefreshIndicator(
                                onRefresh: () =>
                                    _refreshData(me?.id ?? "linga"),
                                child: CustomScrollView(
                                  key: PageStorageKey<String>(tabs[0]),
                                  slivers: [
                                    SliverOverlapInjector(
                                      handle: NestedScrollView
                                          .sliverOverlapAbsorberHandleFor(
                                              context),
                                    ),
                                    name == '검사결과'
                                        ? GridItems(
                                            name: name,
                                            userData: _userDetailData!,
                                          )
                                        : const SliverToBoxAdapter(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 32),
                                                Text("준비중입니다"),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ))
                    .toList()),
          ),
        ),
      ),
    );
  }
}

class GridItems extends StatelessWidget {
  final String name;
  final UserDetailData userData;
  const GridItems({
    super.key,
    required this.name,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: Builder(builder: (context) {
        return SliverGrid.count(
            crossAxisCount: 3,
            children: name == '검사결과'
                ? userData.scanResultList
                    .asMap()
                    .entries
                    .map(
                      (data) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/ProfileScanList",
                              arguments: ProfileScanResultsArgs(
                                selectedId: data.key,
                                data: userData.scanResultList,
                              ));
                        },
                        child: Image.network(data.value.imgUrl),
                      ),
                    )
                    .toList()
                : name == '아이템'
                    ? userData.itemList
                        .map(
                          (e) => GestureDetector(
                            onTap: () {},
                            child: Image.network(e.imgUrl),
                          ),
                        )
                        .toList()
                    : userData.prevBattleList
                        .map(
                          (e) => GestureDetector(
                            onTap: () {},
                            child: Image.network(e.imgUrl),
                          ),
                        )
                        .toList());
      }),
    );
  }
}

class HomeSliverAppBar extends SliverPersistentHeaderDelegate {
  final UserDetailData? userData;
  final double expandedHeight;
  final double height;
  final TabBar tabbar;

  HomeSliverAppBar({
    required this.userData,
    required this.expandedHeight,
    required this.tabbar,
    required this.height,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double percentage = shrinkOffset / (expandedHeight - height);
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          height: 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            image: DecorationImage(
              image: AssetImage('assets/images/bg/bg2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          height: expandedHeight / 2.5 -
              (expandedHeight / 2.5 - height) * percentage,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/bg/bg2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        // 스크롤 후 appbar
        Builder(builder: (context) {
          if (userData != null) {
            return Positioned(
              top: 16,
              child: Opacity(
                opacity: percentage,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    CircleAvatar(
                      radius: 16,
                      backgroundImage:
                          NetworkImage(userData!.user.profileImage),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      userData!.user.nickname,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Positioned(
            top: 16,
            child: Opacity(
              opacity: percentage,
              child: const Row(
                children: [
                  SizedBox(width: 16),
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage('assets/images/anonymous.png'),
                  ),
                  SizedBox(width: 16),
                  Text(
                    '--- Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        // scroll이전
        Builder(
          builder: (context) {
            return Positioned(
              top: 16 - shrinkOffset,
              right: 0,
              child: Opacity(
                opacity: (1 - percentage),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        userData != null ? userData!.user.nickname : "---",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          height: 1.6,
                        ),
                      ),
                      // SizedBox(height: 32.0),
                      const SizedBox(height: 16.0),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(
                              userData != null
                                  ? userData!.user.profileImage
                                  : "https://image.bugsm.co.kr/artist/images/1000/802570/80257085.jpg",
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: -6,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(8),
                                backgroundColor:
                                    Colors.white, // <-- Button color
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/friends.png',
                                  color: Colors.black,
                                  fit: BoxFit.fitWidth,
                                  width: 48,
                                  height: 48,
                                ),
                                const SizedBox(height: 6),
                                Builder(builder: (context) {
                                  return Text(
                                    userData != null
                                        ? userData!.friendList.length.toString()
                                        : '-',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  );
                                }),
                                const SizedBox(height: 6),
                                const Text('친구목록'),
                              ],
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 124,
                            color: Colors.black.withOpacity(0.2),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/icons/battle_bubble.png',
                                  color: Colors.black,
                                  fit: BoxFit.fitWidth,
                                  width: 48,
                                  height: 48,
                                ),
                                Builder(builder: (context) {
                                  return Text(
                                    userData != null
                                        ? userData!.curBattleList.length
                                            .toString()
                                        : '-',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  );
                                }),
                                const SizedBox(height: 12),
                                const Text('진행중인 배틀'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        // bottom tabbar
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(child: tabbar),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_sharp),
            color: Colors.black,
            iconSize: 24,
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
