part of 'pages.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double listItemWidth =
        MediaQuery.of(context).size.width - 2 * defaultMargin;
    return ListView(
      children: <Widget>[
        Column(children: <Widget>[
          Container(
            ///HEADER
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            color: Colors.white,
            height: 100,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Maroong',
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.w600, color: mainColor)),
                      Text("Let's order your favorite food",
                          style: greyFontStyle.copyWith(
                              fontWeight: FontWeight.w300))
                    ]),
                GestureDetector(
                  onTap: () {
                    Get.to(ProfilePage());
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(
                                (context.watch<UserCubit>().state as UserLoaded)
                                    .user
                                    .picturePath),
                            fit: BoxFit.cover)),
                  ),
                )
              ],
            ),
          ),

          ///LIST OF FOOD
          ///ONLY ADMIN CAN VIEW THIS
          Container(
              height: 258,
              width: double.infinity,
              child: BlocBuilder<FoodCubit, FoodState>(
                builder: (_, state) => (state is FoodLoaded)
                    ? ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Row(
                            children: state.foods
                                .map((e) => Padding(
                                      padding: EdgeInsets.only(
                                          left: (e == state.foods.first)
                                              ? defaultMargin
                                              : 0,
                                          right: defaultMargin),
                                      child: GestureDetector(
                                          onTap: () {
                                            Get.to(FoodDetailPage(
                                              transaction: Transaction(
                                                  food: e,
                                                  user: (context
                                                          // ignore: deprecated_member_use
                                                          .bloc<UserCubit>()
                                                          .state as UserLoaded)
                                                      .user),
                                              onBackButtonPressed: () {
                                                Get.back();
                                              },
                                            ));
                                          },
                                          child: FoodCard(e)),
                                    ))
                                .toList(),
                          ),
                        ],
                      )
                    : Center(child: loadingIndicator),
              )),

          SizedBox(
              height: 140,
              width: MediaQuery.of(context).size.width - 2 * defaultMargin,
              child: Carousel(
                dotSize: 4.0,
                dotSpacing: 10,
                dotColor: Colors.green[600],
                indicatorBgPadding: 3.0,
                dotBgColor: Colors.transparent,
                dotVerticalPadding: 3.0,
                dotPosition: DotPosition.bottomRight,
                images: [
                  InkWell(
                      onTap: () {
                        print('item 1 clicked');
                      },
                      child:
                          Image.asset('assets/images.jpg', fit: BoxFit.cover)),
                  InkWell(
                      onTap: () {
                        print('item 2 clicked');
                      },
                      child:
                          Image.asset('assets/images2.jpg', fit: BoxFit.cover)),
                  InkWell(
                      onTap: () {
                        print('item 3 clicked');
                      },
                      child:
                          Image.asset('assets/images3.jpg', fit: BoxFit.cover))
                ],
              )),

          ///LIST OF FOOD (TAB)
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                CustomTabBar(
                  titles: ['New Taste', 'Popular', 'Recommend'],
                  selectedIndex: selectedIndex,
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
                SizedBox(height: 16),
                BlocBuilder<FoodCubit, FoodState>(builder: (_, state) {
                  if (state is FoodLoaded) {
                    List<Food> foods = state.foods
                        .where((element) => element.types.contains(
                            (selectedIndex == 0)
                                ? FoodType.new_food
                                : (selectedIndex == 1)
                                    ? FoodType.popular
                                    : FoodType.recommended))
                        .toList();

                    return Column(
                      children: foods
                          .map((e) => Padding(
                                padding: EdgeInsets.fromLTRB(
                                    defaultMargin, 0, defaultMargin, 16),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(FoodDetailPage(
                                      transaction: Transaction(
                                          food: e,
                                          user: (context
                                                  // ignore: deprecated_member_use
                                                  .bloc<UserCubit>()
                                                  .state as UserLoaded)
                                              .user),
                                      onBackButtonPressed: () {
                                        Get.back();
                                      },
                                    ));
                                  },
                                  child: FoodListItem(
                                      food: e, itemWidth: listItemWidth),
                                ),
                              ))
                          .toList(),
                    );
                  } else {
                    return Center(child: loadingIndicator);
                  }
                })
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
        ])
      ],
    );
  }
}
