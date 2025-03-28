import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partnext/app/l10n/l10n.dart';
import 'package:partnext/app/style/app_text_styles.dart';
import 'package:partnext/features/questionnaire/presentation/questionnaire_screen_vm.dart';
import 'package:partnext/features/questionnaire/presentation/widgets/photo_item.dart';
import 'package:partnext/features/questionnaire/presentation/widgets/photo_item_view.dart';
import 'package:provider/provider.dart';

class QuestionnaireSixthPage extends StatefulWidget {
  const QuestionnaireSixthPage({super.key});

  @override
  State<QuestionnaireSixthPage> createState() => _QuestionnaireSixthPageState();
}

class _QuestionnaireSixthPageState extends State<QuestionnaireSixthPage>
    with AutomaticKeepAliveClientMixin<QuestionnaireSixthPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final vm = context.read<QuestionnaireScreenVm>();

    return Column(
      children: [
        Container(
          height: 64.h,
          alignment: Alignment.center,
          child: Text(
            context.l10n.add_photos,
            style: AppTextStyles.s20w700,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 24.h),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8).r,
            child: ValueListenableBuilder(
              valueListenable: vm.photos,
              builder: (context, photos, _) {
                return Column(
                  children: [
                    Text(
                      context.l10n.first_image_will_be,
                      style: AppTextStyles.s14w400,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 19.h),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: vm.currentPhotoIndex,
                        builder: (context, currentPhotoIndex, _) {
                          return PhotoItemView(
                            imageUrl: photos[currentPhotoIndex]?.url ?? '',
                            onDelete: () => vm.removeImage(currentPhotoIndex),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 21.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        photos.length,
                        (index) {
                          return ValueListenableBuilder(
                            valueListenable: vm.loadingPhoto,
                            builder: (context, loadingPhoto, _) {
                              return PhotoItem(
                                imageUrl: photos[index]?.url ?? '',
                                onTap: () => vm.onTapImage(index),
                                loading: loadingPhoto[index],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 21.h),
                    Text(
                      context.l10n.add_least_2_photos_to_continue,
                      style: AppTextStyles.s14w400,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
