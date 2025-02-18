class ApiEndpoints {
  // Auth

  /// Registration
  ///
  /// Request: POST api/v1/member/auth/registration
  /// body: {
  ///   "full_name": String, // "John Doe"
  ///   "phone": String, // "123456789"
  /// },
  /// Response:
  /// statusCode: 201
  static const registration = 'api/v1/member/auth/registration';

  /// Request OTP
  ///
  /// Request: POST api/v1/member/auth/registration
  /// body: {
  ///   "phone": String, // "0123456789"
  /// },
  /// Response:
  /// statusCode: 200
  static const requestOtp = 'api/v1/member/auth/request_otp';

  /// Login
  ///
  /// Request: POST api/v1/member/auth/check_otp
  /// body: {
  ///   "phone": String, // "123456789"
  ///   "code": String, // "123456"
  /// },
  /// Response:
  /// body: { // UserApiModel
  ///   "user_id": int, // 1
  ///   "full_name": String, // "John Doe"
  ///   "position": String, // "Co-founder and CEO"
  ///   "phone": String, // "+972123456789"
  ///   "image_url": String, // "https://partnext.bitango.co.il/files/04b319ed-127a-4dac-a1db-951ef5c770ae.png"
  ///   "token": String, // "..."
  ///   "pricing_plan": Map<String, dynamic>, // PricingPlanApiModel
  /// }

  /// PricingPlanApiModel: {
  ///     "id": int, // 1
  ///     "name": String, // "3 Month"
  ///     "price": int, // 69
  ///     "price_total": int, // 207
  ///     "discount_percent": int, // 30
  ///     "is_default": bool, // true OR false
  /// }
  static const checkOtp = 'api/v1/member/auth/check_otp';

  // Questionnaire

  /// Get current questionnaire.
  ///
  /// Request: GET api/v1/member/questionnaire
  /// Response:
  /// body: Map<String, dynamic>?, // QuestionnaireApiModel OR null

  /// QuestionnaireApiModel: {
  ///   "my_partnership_types": List<String>, // PartnershipType = ["ideaHolder", "startupOwner", "businessOwner", "strategicPartner", "activePartner", "other"]
  ///   "partner_partnership_types": List<String>, // PartnershipType
  ///   "my_interests": List<String>, // InterestType = ["artAndEntertainment", "music", "banking", "finance", "consulting", "creatives", "fashion", "mediaAndJournalism", "sales", "governmentAndPolitics", "vCAndInvestment", "education", "medicine", "marketing", "publicRelations", "tech", "advertising", "insurance", "realEstate", "lawPolicy", "travelHospitality", "policeMilitary", "constructions", "manufacturing", "foodAndBeverage", "counseling", "other"]
  ///   "partner_interests": List<String>, // InterestType
  ///   "date_of_birth": String in ISO 8601 format, // "2002-02-27T19:00:00Z"
  ///   "position": String, // "Co-founder and CEO"
  ///   "bio": String, // "Some info about person"
  ///   "experience": String, // One item of ExperienceDuration = ["from0To2", "from3To5", "from6To10", "from10", "from20"]
  ///   "profile_url": String, // "https://www.linkedin.com/company/microsoft/"
  ///   "photos": List<String>, // ["https://partnext.bitango.co.il/files/04b319ed-127a-4dac-a1db-951ef5c770ae.png"]
  /// }

  /// Update current questionnaire.
  ///
  /// Request: POST api/v1/member/questionnaire
  /// body: Map<String, dynamic>, // QuestionnaireApiModel
  /// Response:
  /// statusCode: 201
  static const questionnaire = 'api/v1/member/questionnaire';

  // Parnters

  /// Get recommendations about possible partners.
  ///
  /// Request: GET api/v1/member/recommendations
  /// Response:
  /// body: List<Map<String, dynamic>>?, // List<PartnerApiModel> OR null

  /// PartnerApiModel: {
  ///   "user_id": int, // 1
  ///   "full_name": String, // "John Doe"
  ///   "questionnaire": Map<String, dynamic>, // QuestionnaireApiModel
  /// }
  static const recommendations = 'api/v1/member/recommendations';

  /// Confirm or reject partner's recommendation.
  ///
  /// Request: POST api/v1/member/handle_recommendation
  /// body: {
  ///   "user_id": int, // 1
  ///   "confirm": bool, // true OR false
  /// },
  /// Response:
  /// statusCode: 200
  static const handleRecommendation = 'api/v1/member/handle_recommendation';

  /// Get matched partners.
  ///
  /// Request: GET api/v1/member/partners
  /// Response:
  /// body: List<Map<String, dynamic>>?, // List<PartnerApiModel> OR null
  static const partners = 'api/v1/member/partners';

  /// Confirm or reject matched partner.
  ///
  /// Request: POST api/v1/member/handle_partner
  /// body: {
  ///   "user_id": int, // 1
  ///   "confirm": bool, // true OR false
  /// },
  /// Response:
  /// statusCode: 200
  static const handlePartner = 'api/v1/member/handle_partner';

  // Chats

  /// Get chats.
  ///
  /// Request: GET api/v1/member/chats
  /// Response:
  /// body: List<Map<String, dynamic>>? // List<ChatApiModel> OR null

  /// ChatApiModel: {
  ///   "id": int, // 1
  ///   "member": Map<String, dynamic> , // MemberApiModel
  ///   "unread_message_index": int? , // 1 OR null
  ///   "last_message": Map<String, dynamic>?, // MessageApiModel OR null
  /// }

  /// MemberApiModel: {
  ///   "user_id": int, // 1
  ///   "full_name": String , // "John Doe"
  ///   "photo_url": String , // "https://partnext.bitango.co.il/files/04b319ed-127a-4dac-a1db-951ef5c770ae.png"
  ///   "is_current_user": bool?, // true OR false OR null
  /// }

  /// MessageApiModel: {
  ///   "id": int, // 1
  ///   "index": int , // 1
  ///   "created_at": String in ISO 8601 format, // "2002-02-27T19:00:00Z"
  ///   "creator": Map<String, dynamic>, // MemberApiModel
  ///   "text": String?, // "Text of message" OR null
  ///   "attachment": Map<String, dynamic>?, // AttachmentApiModel OR null
  /// }

  /// AttachmentApiModel: {
  ///   "id": int, // 1
  ///   "type": String, // AttachmentType = ["image", "document"]
  ///   "name": String?, // "business_plan.pdf" OR null
  ///   "url": String?, // "https://partnext.bitango.co.il/files/04b319ed-127a-4dac-a1db-951ef5c770ae.pdf" OR null
  ///   "size": int?, // 4096 OR null
  /// }
  static const chats = 'api/v1/member/chats';

  /// Create new chat with partner OR return existing chat.
  ///
  /// Request: POST api/v1/member/create_chat
  /// body: {
  ///   "user_id": int, // 1
  /// },
  /// Response:
  /// body: List<Map<String, dynamic>> // ChatApiModel
  static const createChat = 'api/v1/member/create_chat';

  /// Send new message to chat.
  ///
  /// Request: POST api/v1/member/send_message
  /// body: {
  ///   "chat_id": int, // 1
  ///   "text": String?, // "Text of message" OR null
  ///   "attachment": AttachmentApiModel?, // Map<String, dynamic> OR null
  /// },
  /// Response:
  /// body: List<Map<String, dynamic>> // MessageApiModel
  static const sendMessage = 'api/v1/member/send_message';
  static const chatPage = 'api/v1/member/chat_page';
  static const markMessageAsRead = 'api/v1/member/mark_message_as_read';
  static const reportMessage = 'api/v1/member/report_message';

  // Files
  static const uploadFile = 'api/v1/member/upload_file';
  static const uploadImage = 'api/v1/member/upload_image';

  // Profile
  static const userProfile = 'api/v1/member/user_profile';
  static const sendFeedback = 'api/v1/member/send_feedback';
  static const pricingPlans = 'api/v1/member/pricing_plans';
  static const updatePlan = 'api/v1/member/update_plan';
  static const cancelPlan = 'api/v1/member/cancel_plan';
}
