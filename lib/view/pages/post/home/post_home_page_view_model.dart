import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_riverpod_app/model/post/post.dart';

// 창고 관리자 (Provider)
final postHomePageProvider = StateNotifierProvider<PostHomePageViewModel, PostHomePageModel?>((ref) {
  return PostHomePageViewModel(null);
});

// 창고 (Store)
class PostHomePageViewModel extends StateNotifier<PostHomePageModel?>{
  PostHomePageViewModel(super.state);

  void init(List<Post> postDtoList) {
    state = PostHomePageModel(posts: postDtoList);
  }

  void add(Post post) {
    List<Post> posts = state!.posts;
    List<Post> newPosts = [...posts, post]; // 추가, 삭제, 수정, 검색
    // state 기존 값에 값을 추가한다고 변경감지를 할 수 없다. 새로 new 된 객체가 들어가, 레퍼런스 주소가 바뀌어야 변경감지를 할 수 있다.
    // 즉, 깊은 복사가 이루어져야 한다.
    state = PostHomePageModel(posts: newPosts);
  }

  void remove(int id) {
    List<Post> posts = state!.posts;
    // where은 검색과 삭제에 자주 쓰인다.
    List<Post> newPosts = posts.where((e) => e.id != id).toList();
    state = PostHomePageModel(posts: newPosts);
  }

  void update(Post post) {
    List<Post> posts = state!.posts;
    List<Post> newPosts = posts.map((e) => e.id == post.id ? post : e).toList();
    state = PostHomePageModel(posts: newPosts);
  }
}

// 창고 데이터
class PostHomePageModel {
  List<Post> posts;
  PostHomePageModel({required this.posts});
}