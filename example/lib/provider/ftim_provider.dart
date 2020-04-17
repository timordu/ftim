import 'package:ftim_example/export.dart';

class FtimProvider extends FtimEventProvider {
  @override
  void timSystemAddFriend(List<String> list) {
    print('增加好友: ${json.encode(list)}');
    _loadfriendList();
    timFriendPendency.items.removeWhere((item) => list.contains(item.identifier));
    notifyListeners();
  }

  @override
  void timSystemDelFriend(List<String> list) {
    print('好友删除: ${json.encode(list)}');
    friendList.removeWhere((item) => list.contains(item.identifier));
    timFriendPendency.items.removeWhere((item) => list.contains(item.identifier));
    notifyListeners();
  }

  @override
  void timSystemAddFriendReq(List<TimFriendPendencyInfo> list) {
    print('新增未决申请: ${json.encode(list)}');
    _loadPendencyList();
  }

  @override
  void timSystemDelFriendReq(List<String> list) {
    print('删除未决申请: ${json.encode(list)}');
    timFriendPendency.items.removeWhere((item) => list.contains(item.identifier));
    notifyListeners();
  }

  @override
  void timSystemAddBlacklist(List<String> list) {
    print('加入黑名单: ${json.encode(list)}');
    _loadBlackList();
  }

  @override
  void timSystemDelBlacklist(List<String> list) {
    print('移除黑名单: ${json.encode(list)}');
    blackList.removeWhere((item) => list.contains(item.identifier));
    notifyListeners();
  }

  @override
  void timSystemPendencyReport() {
    print('未决已读上报完成');
    timFriendPendency.unreadCnt = 0;
  }

  @override
  void timSystemProfileChange(List<String> list) {
    print('好友资料变更: ${json.encode(list)}');
  }

  @override
  void timNewMessage(TimMessage message) {
    var conversation = conversationList.firstWhere((element) => element.peer == message.peer && element.type == message.type);
    if (conversation != null) conversation.lastMsg = message;
    if (currentConversation.peer == message.peer && currentConversation.type == message.type) {
      currentConversationMsgList.add(message);
      notifyListeners();
    }
  }

  TimUserProfile myProfile;

  /// 保存登录用户信息
  setMyProfile(TimUserProfile myProfile) {
    this.myProfile = myProfile;
    notifyListeners();
  }

  /// 加载数据
  void init() {
    _loadConversationList();
    _loadfriendList();
    _loadBlackList();
    _loadPendencyList();
  }

  List<TimConversation> conversationList = [];

  /// 获取会话列表
  void _loadConversationList() async {
    conversationList = await Ftim.get().getConversationList();
    notifyListeners();
  }

  List<TimFriend> friendList = [];

  /// 获取朋友列表
  void _loadfriendList() async {
    var list = await Ftim.get().getFriendList();
    friendList = list ?? [];
    notifyListeners();
  }

  /// 判断是否在好友列表中
  TimFriend isInFriendList(String identifier) {
    var list = friendList.where((item) => item.identifier == identifier).toList();
    return list.length > 0 ? list[0] : null;
  }

  List<TimFriend> blackList = [];

  /// 获取黑名单列表
  void _loadBlackList() async {
    var list = await Ftim.get().getBlackList();
    blackList = list ?? [];
    notifyListeners();
  }

  /// 判断是否在黑名单中
  bool isInBlackList(String identifier) {
    var list = blackList.where((it) => it.identifier == identifier);
    return list.length > 0;
  }

  TimFriendPendencyResponse timFriendPendency;

  /// 获取未决列表
  void _loadPendencyList() async {
    var seq = await SpUtil.getInt('tim_friend_pendency_seq', 0);
    var timestamp = await SpUtil.getInt('tim_friend_pendency_timestamp', 0);

    timFriendPendency = await Ftim.get().getPendencyList(seq: seq, timestamp: timestamp);

    SpUtil.setInt('tim_friend_pendency_seq', seq);
    SpUtil.setInt('tim_friend_pendency_timestamp', timestamp);

    notifyListeners();
  }

  /// 判断是否在未决列表中
  TimFriendPendencyItem isInFriendPendencyList(String identifier) {
    var list = timFriendPendency.items.where((item) => item.identifier == identifier).toList();
    return list.length > 0 ? list[0] : null;
  }

  TimConversation currentConversation;
  List<TimMessage> currentConversationMsgList = [];

  /// 进入会话
  void enterConversation(TimConversation conversation) async {
    currentConversation = conversation;
    currentConversationMsgList = await currentConversation.getLocalMessage();
    currentConversationMsgList.sort((left, right) => left.msgTime.compareTo(right.msgTime));
    notifyListeners();
  }

  /// 退出会话
  void exitConversation() async {
    currentConversation = null;
    currentConversationMsgList.clear();
  }
}
