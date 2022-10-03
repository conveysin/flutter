import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../Model/DepartmentModel.dart';
import '../../../Model/PostModel.dart';

@immutable
class PostState extends Equatable {
  final List<PostData> postData;
  final bool isPostdataFailure;
  final bool isPostdataLoading;
  final bool isPostdataSuccess;
  final bool isLikeLoading;
  final bool isLikeSuccess;
  final bool isLikeFailure;

  final bool isViewLoading;
  final bool isViewSuccess;
  final bool isViewFailure;

  final String errorMsg;

  PostState(
      {required this.postData,
      this.isPostdataFailure = false,
      this.isPostdataLoading = true,
      this.isPostdataSuccess = false,
      this.isLikeLoading = false,
      this.isLikeSuccess = false,
      this.isLikeFailure = false,

        this.isViewLoading = false,
        this.isViewSuccess = false,
        this.isViewFailure = false,
      this.errorMsg = ''});

  @override
  List<Object> get props {
    return [
      postData,
      isPostdataFailure,
      isPostdataLoading,
      isPostdataSuccess,
      isLikeLoading,
      isLikeSuccess,
      isLikeFailure,
      isViewLoading,
      isViewSuccess,
      isViewFailure,
      errorMsg
    ];
  }

  PostState copyWith({
    List<PostData>? postData,
    List<String>? slider,
    bool? isPostdataFailure,
    bool? isPostdataLoading,
    bool? isPostdataSuccess,
    bool? isLikeLoading,
    bool? isLikeSuccess,
    bool? isLikeFailure,

    bool? isViewLoading,
    bool? isViewSuccess,
    bool? isViewFailure,
    String? errorMsg,
  }) {
    return PostState(
      postData: postData ?? this.postData,
      isPostdataFailure: isPostdataFailure ?? this.isPostdataFailure,
      isPostdataLoading: isPostdataLoading ?? this.isPostdataLoading,
      isPostdataSuccess: isPostdataSuccess ?? this.isPostdataSuccess,
      isLikeLoading: isLikeLoading ?? this.isLikeLoading,
      isLikeSuccess: isLikeSuccess ?? this.isLikeSuccess,
      isLikeFailure: isLikeFailure ?? this.isLikeFailure,

      isViewLoading: isViewLoading ?? this.isViewLoading,
      isViewSuccess: isViewSuccess ?? this.isViewSuccess,
      isViewFailure: isViewFailure ?? this.isViewFailure,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  bool get stringify => true;
}
