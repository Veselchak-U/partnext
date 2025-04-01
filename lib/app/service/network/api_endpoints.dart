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
  // +

  /// Request OTP
  ///
  /// Request: POST api/v1/member/auth/registration
  /// body: {
  ///   "phone": String, // "0123456789"
  /// },
  /// Response:
  /// statusCode: 200
  static const requestOtp = 'api/v1/member/auth/request_otp';
  // +

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
  ///   "image_url": String, // "https://partnext.bitango.co.il/files/04b319ed-127a-4dac-a1db-951ef5c770ae"
  ///   "pricing_plan": PricingPlanApiModel?, // nullable
  ///   "token": String, // "..."
  /// }

  /// PricingPlanApiModel: {
  ///     "id": int, // 1
  ///     "name": String, // "3 Month"
  ///     "price": double, // 69.00
  ///     "price_total": double, // 207.00
  ///     "discount_percent": int, // 30
  ///     "is_default": bool, // false
  /// }
  static const checkOtp = 'api/v1/member/auth/check_otp';
  // +

  // Questionnaire

  /// Get current user questionnaire.
  ///
  /// Request: GET api/v1/member/questionnaire
  /// Response:
  /// body: QuestionnaireApiModel?, // nullable

  /// QuestionnaireApiModel: {
  ///   "my_partnership_types": List<String>, // PartnershipType = ["ideaHolder", "startupOwner", "businessOwner", "strategicPartner", "activePartner", "other"]
  ///   "partner_partnership_types": List<String>, // PartnershipType
  ///   "my_interests": List<String>, // InterestType = ["artAndEntertainment", "music", "banking", "finance", "consulting", "creatives", "fashion", "mediaAndJournalism", "sales", "governmentAndPolitics", "vCAndInvestment", "education", "medicine", "marketing", "publicRelations", "tech", "advertising", "insurance", "realEstate", "lawPolicy", "travelHospitality", "policeMilitary", "constructions", "manufacturing", "foodAndBeverage", "counseling", "other"]
  ///   "partner_interests": List<String>, // InterestType
  ///   "date_of_birth": String? in ISO 8601 format, // "2002-02-27T19:00:00Z", nullable
  ///   "position": String?, // "Co-founder and CEO", nullable
  ///   "bio": String?, // "Some info about person", nullable
  ///   "experience": String?, // One item of ExperienceDuration = ["from0To2", "from3To5", "from6To10", "from10", "from20"], nullable
  ///   "profile_url": String?, // "https://www.linkedin.com/company/microsoft/", nullable
  ///   "photos": List<FileApiModel>, //
  /// }

  /// Update current user questionnaire.
  ///
  /// Request: POST api/v1/member/questionnaire
  /// body: QuestionnaireApiModel,
  /// Response:
  /// statusCode: 201
  static const questionnaire = 'api/v1/member/questionnaire';
  // +

  // Parnters

  /// Get recommendations about possible partners.
  ///
  /// Request: GET api/v1/member/recommendations
  /// Response:
  /// body: List<PartnerApiModel>?, // nullable

  /// PartnerApiModel: {
  ///   "user_id": int, // 1
  ///   "full_name": String, // "John Doe"
  ///   "questionnaire": QuestionnaireApiModel,
  /// }
  static const recommendations = 'api/v1/member/recommendations';
  // +

  /// Confirm or reject partner's recommendation.
  ///
  /// Request: POST api/v1/member/handle_recommendation
  /// body: {
  ///   "user_id": int, // 1
  ///   "confirm": bool, // true
  /// },
  /// Response:
  /// statusCode: 200
  static const handleRecommendation = 'api/v1/member/handle_recommendation';
  // +

  /// Get matched partners.
  ///
  /// Request: GET api/v1/member/partners
  /// Response:
  /// body: List<PartnerApiModel>?, // nullable
  static const partners = 'api/v1/member/partners';
  // +

  /// Confirm or reject matched partner.
  ///
  /// Request: POST api/v1/member/handle_partner
  /// body: {
  ///   "user_id": int, // 1
  ///   "confirm": bool, // true
  /// },
  /// Response:
  /// statusCode: 200
  static const handlePartner = 'api/v1/member/handle_partner';

  // Chats

  /// Get chats.
  ///
  /// Request: GET api/v1/member/chats
  /// Response:
  /// body: List<ChatApiModel>? // nullable

  /// ChatApiModel: {
  ///   "id": int, // 1
  ///   "member": MemberApiModel, // MemberApiModel
  ///   "unread_message_index": int?, // 1, nullable
  ///   "last_message": MessageApiModel?, // nullable
  /// }

  /// MemberApiModel: {
  ///   "user_id": int, // 1
  ///   "full_name": String , // "John Doe"
  ///   "photo_url": String , // "https://partnext.bitango.co.il/files/04b319ed-127a-4dac-a1db-951ef5c770ae"
  ///   "is_current_user": bool?, // false, nullable
  /// }

  /// MessageApiModel: {
  ///   "id": int, // 1
  ///   "index": int , // 1
  ///   "created_at": String in ISO 8601 format, // "2002-02-27T19:00:00Z"
  ///   "creator": MemberApiModel,
  ///   "text": String?, // "Text of message", nullable
  ///   "attachment": // FileApiModel?, nullable
  /// }

  /// FileApiModel: {
  ///   "id": int, // 1
  ///   "type": String, // One item of AttachmentType = ["image", "document"]
  ///   "name": String, // "business_plan.pdf"
  ///   "url": String, // "https://partnext.bitango.co.il/files/04b319ed-127a-4dac-a1db-951ef5c770ae"
  ///   "size": int, // 4096
  /// }
  static const chats = 'api/v1/member/chats';

  /// Create new chat with partner OR return existing chat.
  ///
  /// Request: POST api/v1/member/create_chat
  /// body: {
  ///   "user_id": int, // 1
  /// },
  /// Response:
  /// body: ChatApiModel
  static const createChat = 'api/v1/member/create_chat';
  // -

  /// Send new message to chat.
  ///
  /// Request: POST api/v1/member/send_message
  /// body: {
  ///   "chat_id": int, // 1
  ///   "text": String?, // "Text of message", nullable
  ///   "attachment": FileApiModel // nullable
  /// },
  /// Response:
  /// body: MessageApiModel
  static const sendMessage = 'api/v1/member/send_message';

  /// Get chat message page with an "index".
  /// If "index" == null returns a page with the first unread message for current user.
  ///
  /// Messages from the server are requested page by page.
  /// The number of messages per page is determined by the server.
  ///
  /// Request: POST api/v1/member/chat_page
  /// body: {
  ///   "chat_id": int, // 1
  ///   "page_index": int?, // 0, nullable
  /// },
  /// Response:
  /// body: ChatPageApiModel

  /// ChatPageApiModel: {
  ///   "page_index": int, // 0
  ///   "last_page_index": int, // 10
  ///   "messages": List<MessageApiModel>,
  /// }
  static const chatPage = 'api/v1/member/chat_page';

  /// Mark a message as read.
  ///
  /// Request: POST api/v1/member/mark_message_as_read
  /// body: {
  ///   "chat_id": int, // 1
  ///   "message_id": int, // 2
  /// },
  /// Response:
  /// statusCode: 200
  static const markMessageAsRead = 'api/v1/member/mark_message_as_read';

  /// Report about some violation in the message.
  ///
  /// Request: POST api/v1/member/report_message
  /// body: {
  ///   "chat_id": int, // 1
  ///   "message_id": int, // 2
  ///   "description": String, // "Description of some violations"
  /// },
  /// Response:
  /// statusCode: 200
  static const reportMessage = 'api/v1/member/report_message';

  // Files

  /// Upload image or document to server.
  ///
  /// Request: POST api/v1/member/upload_file
  /// body: FormData {
  ///   "file": MultipartFile,
  ///   "type": String, // One item of AttachmentType = ["image", "document"]
  ///   "name": String, // "business_plan.pdf"
  /// },
  /// Response:
  /// statusCode: 201
  /// body: FileApiModel
  static const uploadFile = 'api/v1/member/upload_file';
  // +

  // Profile

  /// Get current user profile.
  ///
  /// Request: GET api/v1/member/user_profile
  /// Response:
  /// body: UserApiModel,

  /// Update current user main photo.
  ///
  /// Request: POST api/v1/member/user_profile
  /// body: {
  ///   "image_url": imageUrl, // "https://partnext.bitango.co.il/files/04b319ed-127a-4dac-a1db-951ef5c770ae"
  /// },
  /// Response:
  /// body: statusCode: 200
  static const userProfile = 'api/v1/member/user_profile';
  // -

  /// Send some feedback about the app.
  ///
  /// Request: POST api/v1/member/send_feedback
  /// body: {
  ///   "message": String, // "Some feedback"
  /// },
  /// Response:
  /// body: statusCode: 201
  static const sendFeedback = 'api/v1/member/send_feedback';
  // -

  /// Get available pricing plans.
  ///
  /// Request: GET api/v1/member/pricing_plans
  /// Response:
  /// body: List<PricingPlanApiModel>,
  static const pricingPlans = 'api/v1/member/pricing_plans';
  // +

  /// Update current user pricing plan.
  ///
  /// Request: POST api/v1/member/update_plan
  /// body: {
  ///   "plan_id": int, // 1
  /// },
  /// Response:
  /// body: {"iframe_url": "https://gateway20.pelecard.biz/PaymentGW?transactionId=2bc88a5e-88c7-4d1a-ba44-2fd8757c6a25"}
  static const updatePlan = 'api/v1/member/update_plan';
  // -

  /// Cancel current user pricing plan.
  ///
  /// Request: POST api/v1/member/cancel_plan
  /// Response:
  /// body: statusCode: 200
  static const cancelPlan = 'api/v1/member/cancel_plan';
}
