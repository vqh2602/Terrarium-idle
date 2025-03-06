class Storages {
  /* biến local lưu data storage */
  /// chứa thông tin đối tượng user sau khi đăng nhập, hoặc đăng ký
  static const String dataUser = 'data_user';

  /// chứa tài khoản
  static const String dataEmail = 'data_email';
  static const String dataPassWord = 'data_password';

  /// lịch sử email đăng nhập trước đó
  static const String historyDataEmail = 'data_email';

  /// chứa thời gian đăng nhập
  static const String dataLoginTime = 'data_login_time';

  /// đăng nhập sinh trắc học
  static const String dataBiometric = 'data_biometric';

  /// list cài đặt hiển thị nhãn
  static const String dataSetting = 'data_setting_label';

  // data biến tự động làm mới giao dịch mua
  static const String dataRenewSub = 'data_renewSub';

  // data chứa theme đang set
  static const String dataTheme = 'data_theme';

  /// refresh_token imgur giúp lấy lại token khi đã hết hạn
  static const String dataRefreshTokenImgur = 'data_refresh_token_imgur';

  /// lưu token api imgur
  static const String dataTokenImgur = 'data_token_imgur';

  /// chứa thông tin đối tượng user data plant, pot... từ csdl
  static const String dataUserCloud = 'data_user_plant_pot';

  /// chứa thời gian đồng bộ, 5 phút đồng bộ và thiết lập lại
  static const String dataUserCloudTimeOut = 'data_user_plant_pot_time_out';

  /// Hiển thị bảng đánh giá
  static const String dataRateing = 'data_rateing';

  /// Bật chế độ hiển thị hiệu suất cao
  static const String graphicsOption = 'graphics_option';

  /// Bật chế độ hiển thị bảng hướng dẫn
  static const String tourialGuide = 'tourial_guide';

  /// Bật chế độ hiển thị bảng hướng dẫn
  static const String isCache = 'có dử dụng cache';

  /// Bật chế độ làm mờ phong cảnh hay k
  static const String isLandscapeFade = 'is_landscape_fade';
}

class Config {
  // thời gian buộc đăng xuất (giờ)
  static const int dataLoginTimeOut = 168;
}
