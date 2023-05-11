import 'package:flutter/material.dart';
import 'package:ninucco/models/battle_info_model.dart';
import 'package:ninucco/services/battle_api_service.dart';
import 'package:ninucco/widgets/battle/battle_item_widget.dart';

class BattleAllScreen extends StatelessWidget {
  BattleAllScreen({super.key});

  final Future<List<BattleInfoModel>> battles = BattleApiService.getBattles();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        flexibleSpace: const Image(
          image: AssetImage('assets/images/bg/bg2.png'),
          fit: BoxFit.cover,
        ),
        title: const Text(
          '전체 배틀',
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg/bg2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: battles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [Expanded(child: makeList(snapshot))],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/BattleCreateScreen',
          );
        },
        backgroundColor: Colors.blue.shade600,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<BattleInfoModel>> snapshot) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var userRank = snapshot.data![index];
        return BattleItem(
          memberAId: 1,
          memberANickname: userRank.memberANickname,
          memberAImage: userRank.memberAImage,
          memberBId: 1,
          memberBNickname: userRank.memberBNickname,
          memberBImage: userRank.memberBImage,
          battleId: userRank.battleId,
          question: userRank.question,
          ratioA: userRank.ratioA,
          ratioB: userRank.ratioB,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
