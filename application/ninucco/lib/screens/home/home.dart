import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/bg/bg.png'),
          fit: BoxFit.cover,
        )),
        padding: const EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 64,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 2,
              forceElevated: true,
              backgroundColor: Colors.white,
              leading: const Padding(
                padding: EdgeInsets.all(12.0),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xffFE9BB3),
                ),
              ),
              title: const Text(
                "안녕하세요, 송승현님!",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  "나의 닮은꼴 찾기",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SliverGrid.builder(
              itemCount: 6,
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  const QuiltedGridTile(2, 1),
                  const QuiltedGridTile(1, 1),
                  const QuiltedGridTile(1, 1),
                ],
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/FaceScan',
                      arguments: index,
                    );
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/scan_items/${index + 1}.png',
                        scale: 0.1,
                        fit: BoxFit.cover,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "나와",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "닮은 직업상 찾기",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(bottom: 12, top: 36),
                child: const Text(
                  "오늘의 배틀",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  for (var i in [1, 2, 3, 4, 5])
                    Column(
                      children: [
                        Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwVVfi9a81AcdLJQCiVitDydwOnDDiRLpcbw&usqp=CAU',
                                      scale: 0.1,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRky4seZyCNJWW8Wu3pt6AoaMMTsIZ203_xtQ&usqp=CAU',
                                      scale: 0.1,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Positioned.fill(
                                bottom: 0,
                                left: 0,
                                child: Icon(
                                  Icons.brightness_auto_outlined,
                                  color: Colors.purpleAccent,
                                  size: 64,
                                )),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text("34명이 배팅했어요"),
                        const Divider(
                          height: 24,
                          color: Color(0x88000000),
                        )
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


  // Container(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 16,
  //                 vertical: 20,
  //               ),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(12),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.grey.withOpacity(0.3),
  //                     blurRadius: 5.0,
  //                     spreadRadius: 0.0,
  //                     offset: const Offset(0, 7),
  //                   )
  //                 ],
  //               ),
  //               child: const Row(
  //                 children: [
                    // CircleAvatar(
                    //   radius: 16,
                    //   backgroundColor: Color(0xffFE9BB3),
                    // ),
  //                   SizedBox(width: 12),
  //                   Text(
  //                     "안녕하세요, 승송현님!",
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
