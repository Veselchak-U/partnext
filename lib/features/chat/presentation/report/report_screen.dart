import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/generated/assets.gen.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/common/buttons/common_button.dart';
import 'package:partnext/common/form_fields/app_text_field.dart';
import 'package:partnext/common/layouts/simple_layout.dart';
import 'package:partnext/common/utils/input_validators.dart';
import 'package:partnext/features/chat/presentation/report/report_screen_vm.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ReportScreenVm>();

    return SimpleLayout(
      body: SingleChildScrollView(
        child: Form(
          key: vm.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32).w,
            child: Column(
              children: [
                SizedBox(height: 9.h),
                Text(
                  context.l10n.report_user,
                  style: AppTextStyles.s20w700,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 48.h),
                AppTextField(
                  label: context.l10n.details,
                  autofocus: true,
                  minLines: 6,
                  maxLines: 6,
                  validator: InputValidators.feedbackLengthValidator,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  onChanged: (value) => vm.description = value,
                ),
                SizedBox(height: 32.h),
                ValueListenableBuilder(
                  valueListenable: vm.loading,
                  builder: (context, loading, _) {
                    return CommonButton(
                      label: context.l10n.send,
                      iconPath: Assets.icons.send.path,
                      onTap: vm.sendReport,
                      loading: loading,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
