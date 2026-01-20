class AppString {

  static const String loginTitle = 'Chào mừng quay trở lại';
  static const String loginSubTitle = 'Đăng nhập để tiếp tục đặt món';
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Mật khẩu';

  //exception
  static const String timeoutMessage = 'Kết nối quá lâu';
  static const String notResponseMessage = 'Server không phản hồi';
  static const String wrongPhoneOrPassword = 'Tài khoản hoặc mật khẩu không đúng';
  static const String undefinedMessage = 'Lỗi không xác định';
  //profilescreen
  static const String studyProfile = 'Hồ sơ học tập';
  static const String enterActiveCode = 'Nhập mã kích hoạt';
  static const String add = 'Thêm';
  //valid
  static const String doNotEmpty = 'Không được bỏ trống';
  static const String lengthFrom6To15 = 'Số điện thoại cần nhập 6 - 15 chữ số';
  //sign
  static const String phoneOrUsername = 'Số điện thoại/Tên đăng nhập';
  static const String password = 'Mật khẩu';
  static const String forgotPassword = 'Quên mật khẩu?';
  static const String signin = "Đăng nhập";
  static const String retry = "Thử lại";
  static const String wrongPasswordMessage = "Bạn đã nhập sai mật khẩu quá 5 lần.\nChọn \"Quên mật khẩu\" để khôi phục nhé.";
  static const String ifYouHaveActiveCode = "Nếu bạn có mã kích hoạt, ";
  static const String enterHere = "Nhập tại đây";
  static const String orSignInWith = "Hoặc đăng nhập với";
  static const String dontHaveAccount = "Bạn chưa có tài khoản? ";
  static const String signUp = "Đăng ký";
  static const String passwordAtleast6 = "Mật khẩu phải có ít nhất 6 ký tự";
  static const String passwordNotValid = "Mật khẩu không hợp lệ";
  //dialog
  static const String signInWithFbFail = "Đăng nhập bằng Facebook thất bại";
  static const String signInWithGgFail = "Đăng nhập bằng Google thất bại";
  static const String signInWithApFail = "Đăng nhập bằng Google thất bại";

  //signup
  static const String enterPhone = "Nhập số điện thoại";
  static const String phone = "Số điện thoại";
  static const String phoneAvailable = "Số điện thoại khả dụng";
  static const String phoneAlreadyRegisted = "Số điện thoại này đã được đăng ký với Monkey, ba mẹ hãy đăng nhập nhé.";
  static const String continu = "Tiếp tục";
  static const String cancel = "Huỷ";
  static const String orSignUpWith = "Hoặc đăng ký với";
  static const String alreadyHaveAccount = "Tôi đã có tài khoản. ";
  static String warningProfile(String id) => "Ba mẹ sẽ mất đi hồ sơ học $id, ba mẹ có muốn đăng nhập không?";
  static const String createPassword = "Tạo mật khẩu";
  static const String enterPassword = "Nhập mật khẩu";
  static const String reEnterPassword = "Nhập lại mật khẩu";
  static const String passwordValid = "Mật khẩu hợp lệ";
  static const String passwordNotMatch = "Mật khẩu không trùng khớp";
  static const String passwordMatch = "Mật khẩu trùng khớp";
  static const String canNotReconPhone = "Không thể nhận dạng số điện thoại";
  //birthStep
  static String birthYear(String name) => "$name sinh vào năm nào?";
  static const String bornBefore2010 = "Sinh trước năm 2010";
  static const String noti = "Thông báo";
  static const String gotIt = "Tôi đã hiểu";

  //profile
  static const String welcomeToMonkeyStory = "Chào mừng bạn đến Monkey Stories";
  static const String name = "Tên";
  static const String yourName = "Tên của bé là?";
  static const String updatingData = "Monkey đang cập nhật dữ liệu học tập của bé";
  static const String updateAccountInfo = "Cập nhật thông tin tài khoản sử dụng";
  static const String updateProfile = "Cập nhật hồ sơ học tập";
  static const String updateSubscription =  "Cập nhật thông tin gói học";
  static const String presentLevel =  "Khả năng tiếng Anh hiện tại của bé?";
  static const String level0Des =  "Bé chưa biết gì về tiếng Anh";
  static const String level1Des =  "Bé nhận biết được vài từ đơn giản";
  static const String level2Des =  "Bé hiểu được câu ngắn, đơn giản";
  static const String level3Des =  "Bé đọc hiểu đoạn văn ngắn";
  static String getImageLevel(int index) =>  "assets/icons/ic_level_$index.svg";

}