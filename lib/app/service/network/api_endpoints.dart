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
  static const handleRecommendation = 'api/v1/member/handle_recommendation';
  static const partners = 'api/v1/member/partners';
  static const handlePartner = 'api/v1/member/handle_partner';

  // Chats
  static const chats = 'api/v1/member/chats';
  static const createChat = 'api/v1/member/create_chat';
  static const sendMessage = 'api/v1/member/send_message';
  static const chatPage = 'api/v1/member/chat_page';

  // Files
  static const uploadFile = 'api/v1/member/upload_file';

  // Profile
  static const userProfile = 'api/v1/member/user_profile';
  static const sendFeedback = 'api/v1/member/send_feedback';
  static const pricingPlans = 'api/v1/member/pricing_plans';
  static const updatePlan = 'api/v1/member/update_plan';
  static const cancelPlan = 'api/v1/member/cancel_plan';
}
