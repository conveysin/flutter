import 'package:bloc/bloc.dart';
import 'package:getinforme/Model/PostModel.dart';
import 'package:getinforme/feature/post/cubit/post_state.dart';
import '../../../data/data_helper.dart';
class PostCubit extends Cubit<PostState> {
  PostCubit()
      : super(
    PostState(
      postData:<PostData>[],
       ),
  );

  final DataHelper _dataHelper = DataHelperImpl.instance;
  bool isFetching = false;
/*  Card? cardlist;
  String? slider;
  List<Card>? list = List.empty(growable: true);
  List<String>? sliderlist = List.empty(growable: true);*/



  Future<void> fetchPostData(String departmentID,String villageID,String userID, bool isLoad) async {
    emit(state.copyWith(isPostdataLoading: isLoad));
    final dailyQuoteResponse = await _dataHelper.apiHelper.getPostList(villageID,departmentID,userID);

    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(isPostdataLoading: false,isPostdataFailure: true,isPostdataSuccess: false,isLikeSuccess: false,errorMsg:l.errorMessage));
    }, (r) {
      if(r.status.toString() == '404'){
        emit(state.copyWith(isPostdataLoading: false,isLikeSuccess: false));
        print('ErrorrrrrMsg${r.msg}');
        emit(state.copyWith(isPostdataLoading: false,isPostdataFailure: true, isPostdataSuccess: true,isLikeSuccess: false,errorMsg:r.msg.toString(),postData: r.data));

      }else {
        emit(state.copyWith(isPostdataLoading: false, isLikeSuccess: false));
        print('ErrorrrrrMsg${r.msg}');
        emit(state.copyWith(isPostdataLoading: false,
            isPostdataFailure: false,
            isLikeSuccess: false,
            isPostdataSuccess: true,
            errorMsg: r.msg.toString(),
            postData: r.data));
      }
    });
  }

  Future<void> like_posts(String post_id,String user_id) async {
    emit(state.copyWith(isLikeLoading: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.like_posts(post_id,user_id);
    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(isLikeLoading: false,isLikeSuccess: false,isLikeFailure: true,errorMsg:l.errorMessage));
    }, (r) {
      emit(state.copyWith(isLikeLoading: false,isViewSuccess: false,isLikeFailure: false,isLikeSuccess: true));
    });
  }

  Future<void> view_posts(String post_id,String user_id) async {
    emit(state.copyWith(isViewLoading: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.post_view(post_id,user_id);
    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(isViewLoading: false,isLikeSuccess: false,isViewFailure :true,isLikeFailure : true,errorMsg:l.errorMessage));
    }, (r) {
      emit(state.copyWith(isViewLoading: false,isLikeFailure: false,isLikeSuccess: false,isViewSuccess: true));
    });
  }
}
