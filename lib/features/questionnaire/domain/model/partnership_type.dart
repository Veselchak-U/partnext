import 'package:partnext/app/l10n/l10n.dart';

enum PartnershipType {
  ideaHolder,
  startupOwner,
  businessOwner,
  strategicPartner,
  activePartner,
  other;

  @override
  String toString() => PartnershipTypeHelper.getIAmLookingForLabel(this);
}

class PartnershipTypeHelper {
  static String getWhoIAmLabel(PartnershipType type) => switch (type) {
        PartnershipType.ideaHolder => l10n?.i_have_idea ?? '',
        PartnershipType.startupOwner => l10n?.i_own_startup ?? '',
        PartnershipType.businessOwner => l10n?.i_own_business ?? '',
        PartnershipType.strategicPartner => l10n?.strategic_partner ?? '',
        PartnershipType.activePartner => l10n?.active_partner ?? '',
        PartnershipType.other => l10n?.other ?? '',
      };

  static String getIAmLookingForLabel(PartnershipType type) => switch (type) {
        PartnershipType.ideaHolder => l10n?.grow_idea ?? '',
        PartnershipType.startupOwner => l10n?.partnership_on_startup ?? '',
        PartnershipType.businessOwner => l10n?.partnership_on_business ?? '',
        PartnershipType.strategicPartner => l10n?.strategic_partner ?? '',
        PartnershipType.activePartner => l10n?.active_partner ?? '',
        PartnershipType.other => l10n?.other ?? '',
      };

  static String getWhoIAmDescription(PartnershipType type) => l10n?.partnership_type_description ?? '';

  static String getIAmLookingForDescription(PartnershipType type) => l10n?.partnership_type_description ?? '';
}
