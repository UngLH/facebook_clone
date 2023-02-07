import 'package:facebook/commons/app_colors.dart';
import 'package:facebook/commons/app_text_styles.dart';
import 'package:facebook/models/entities/search/search_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/router/application.dart';
import 'package:facebook/router/routers.dart';
import 'package:facebook/ui/page/find/find_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../profile/info.dart';

class FindPage extends StatefulWidget {
  const FindPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FindPageState();
  }
}

class _FindPageState extends State<FindPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FindPageCubit? _cubit;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    _cubit = BlocProvider.of<FindPageCubit>(context);
    _cubit!.getSavedSearch();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.background,
        appBar: AppBar(
          shape: const Border(
              bottom: BorderSide(
                  color: AppColors.commentBackgroundColor, width: 1)),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Container(
            height: 45,
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.search,
              onSubmitted: (String text) {
                Application.router?.navigateTo(context, Routes.searchResult,
                    routeSettings: RouteSettings(arguments: text));
              },
              cursorColor: Colors.black,
              cursorHeight: 20,
              cursorWidth: 1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  filled: true,
                  fillColor: AppColors.roundIconButtonBackground,
                  hintText: "Tìm kiếm",
                  contentPadding:
                      const EdgeInsets.only(bottom: 45 / 2, left: 15),
                  hintStyle:
                      const TextStyle(color: AppColors.grayText, fontSize: 16)),
            ),
          ),
        ),
        body: BlocBuilder<FindPageCubit, FindPageState>(
            bloc: _cubit,
            builder: (context, state) {
              if (state.loadingStatus == LoadStatus.LOADING) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.main,
                  ),
                );
              } else if (state.loadingStatus == LoadStatus.FAILURE) {
                return const Center(child: Text("Đã có lỗi xảy ra!"));
              } else if (state.loadingStatus == LoadStatus.EMPTY) {
                return const Center(child: Text("Không có lịch sử tìm kiếm"));
              } else {
                return state.listSavedSearch!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tìm kiếm gần đây",
                                  style: AppTextStyle.blackS20Bold,
                                ),
                                const Text(
                                  "Xem tất cả",
                                  style: TextStyle(
                                      color: AppColors.darkMain,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                                itemCount: state.listSavedSearch!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  SearchEntity? searchEntity =
                                      state.listSavedSearch![index];
                                  return searchItem(
                                      searchEntity: searchEntity,
                                      delete: () {
                                        _cubit!.delSavedSearch(
                                            searchEntity.id, '0');
                                      },
                                      onTap: () {
                                        Application.router?.navigateTo(
                                            context, Routes.searchResult,
                                            routeSettings: RouteSettings(
                                                arguments:
                                                    searchEntity.keyword));
                                      });
                                })
                          ],
                        ),
                      )
                    : const Center(child: Text("Không có lịch sử tìm kiếm"));
              }
            }));
  }

  Widget searchItem(
      {SearchEntity? searchEntity, VoidCallback? delete, VoidCallback? onTap}) {
    return Row(
      children: [
        const Icon(
          Icons.access_time,
          size: 30,
          color: AppColors.grayBackground,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: InkWell(
            onTap: onTap,
            child: Text(
              searchEntity!.keyword ?? "",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        IconButton(
            onPressed: delete,
            icon: const Icon(
              Icons.close,
              color: AppColors.grayIconButton,
            ))
      ],
    );
  }
  List<Info> info = [
    Info(
        icon: const Icon(
          Icons.work,
          color: Colors.white,
        ),
        normalText: 'Studying department of CSE at ',
        boldText: 'Begum Rokeya University, Rangpur'),
    Info(
        icon: const Icon(Icons.school, color: Colors.white),
        normalText: 'Studied at ',
        boldText: 'Cantonment Public School & College, Lalmonirhat'),
    Info(
        icon: const Icon(Icons.favorite, color: Colors.white),
        normalText: 'Single',
        boldText: ''),
    Info(
        icon: const Icon(Icons.link, color: Colors.white),
        normalText: 'somewhereinblog.net/blog/Faisal2020',
        boldText: ''),
    Info(
        icon: const Icon(Icons.more_horiz, color: Colors.white),
        normalText: 'See your About info')
  ];

  Widget infoTemplate(infoItem, context) {
    return Row(
      children: [
        infoItem.icon,
        const SizedBox(
          width: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 50.0,
          padding: const EdgeInsets.all(5),
          child: RichText(
              text: TextSpan(style: const TextStyle(fontSize: 18), children: [
            TextSpan(
                text: infoItem.normalText,
                style: const TextStyle(color: Colors.white)),
            TextSpan(
                text: infoItem.boldText,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))
          ])),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        color: Color.fromARGB(242, 8, 5, 5),
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage('assets/images/ic_bg.png'),
                          fit: BoxFit.cover)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 80),
                  child: const CircleAvatar(
                    radius: 74.0,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundImage:
                          AssetImage('assets/images/ic_avatar.png'),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 190),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 55,
                        ),
                        const Icon(
                          Icons.shield,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Faisal Shohag',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'If you cannot do great things, do small things in a great way.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
                  child: Row(
                    children: const [
                      Icon(Icons.add_circle_rounded),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Add friend')
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(primary: Colors.grey[900]),
                  child: Row(
                    children: const [
                      Icon(Icons.edit),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Add to story')
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(primary: Colors.grey[900]),
                  child: const Icon(Icons.more_horiz),
                )
              ],
            ),
            Divider(
              thickness: 1,
              height: 10,
              color: Colors.grey[800],
            ),
            Column(
              children: info
                  .map<Widget>((infoList) => infoTemplate(infoList, context))
                  .toList(),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue.withOpacity(0.1)),
                  child: Text(
                    'Edit public details',
                    style: TextStyle(color: Colors.blue[900]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
