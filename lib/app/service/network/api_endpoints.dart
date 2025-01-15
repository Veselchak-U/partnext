class ApiEndpoints {
  // Auth
  static const registration = 'api/v1/member/auth/registration';
  static const requestOtp = 'api/v1/member/auth/request_otp';
  static const checkOtp = 'api/v1/member/auth/check_otp';

  // Questionnaire
  static const questionnaire = 'api/v1/member/questionnaire';
  static const uploadImage = 'api/v1/member/upload_image';

  // Parnters
  static const recommendations = 'api/v1/member/recommendations';

  // Profile
  static const user = 'api/v1/member/user';
  static const sendFeedback = 'api/v1/member/send_feedback';
  static const pricingPlans = 'api/v1/member/pricing_plans';
  static const updatePlan = 'api/v1/member/update_plan';
}
