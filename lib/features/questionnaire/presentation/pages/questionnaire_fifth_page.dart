import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/form_fields/app_date_field.dart';
import 'package:partnext/common/form_fields/app_dropdown_field.dart';
import 'package:partnext/common/form_fields/app_text_field.dart';
import 'package:partnext/common/utils/input_validators.dart';
import 'package:partnext/features/questionnaire/domain/model/experience_duration.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_vm.dart';
import 'package:provider/provider.dart';

class QuestionnaireFifthPage extends StatefulWidget {
  const QuestionnaireFifthPage({super.key});

  @override
  State<QuestionnaireFifthPage> createState() => _QuestionnaireFifthPageState();
}

class _QuestionnaireFifthPageState extends State<QuestionnaireFifthPage>
    with AutomaticKeepAliveClientMixin<QuestionnaireFifthPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final vm = context.read<QuestionnaireScreenVm>();

    return Form(
      key: vm.fifthFormKey,
      child: Column(
        children: [
          Container(
            height: 64.h,
            alignment: Alignment.center,
            child: Text(
              context.l10n.tell_us_about_yourself,
              style: AppTextStyles.s20w700,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8).r,
              child: Column(
                children: [
                  AppDateField(
                    label: context.l10n.date_of_birth,
                    initialDate: vm.questionnaire.dateOfBirth,
                    minDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
                    maxDate: DateTime.now().subtract(const Duration(days: 365 * 14)),
                    validator: InputValidators.emptyValidator,
                    onChanged: vm.onDateOfBirthChanged,
                  ),
                  SizedBox(height: 16.h),
                  AppDropdownField<ExperienceDuration>(
                    label: context.l10n.years_of_experience,
                    items: ExperienceDuration.values,
                    initialItem: vm.questionnaire.experience,
                    validator: InputValidators.emptyValidator,
                    onChanged: vm.onExperienceSelected,
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    label: context.l10n.your_current_position,
                    initialValue: vm.questionnaire.position,
                    minLines: 2,
                    maxLines: 2,
                    validator: InputValidators.emptyValidator,
                    onChanged: vm.onPositionChanged,
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    labelWidget: Text.rich(
                      style: AppTextStyles.s14w400,
                      TextSpan(
                        children: [
                          TextSpan(text: context.l10n.tell_us_about_yourself_second),
                        ],
                      ),
                    ),
                    initialValue: vm.questionnaire.bio,
                    minLines: 3,
                    maxLines: 3,
                    validator: InputValidators.emptyValidator,
                    onChanged: vm.onBioChanged,
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    label: context.l10n.linkedin_profile_url,
                    initialValue: vm.questionnaire.profileUrl,
                    onChanged: vm.onProfileUrlChanged,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
