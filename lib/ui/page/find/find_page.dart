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
}
