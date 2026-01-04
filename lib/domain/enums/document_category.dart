enum DocumentCategory {
  manual,
  warranty,
  receipt,
  invoice,
  permit,
  inspection,
  contract,
  insurance,
  closingDocument,
  survey,
  photo,
  other;

  String get displayName {
    switch (this) {
      case DocumentCategory.manual:
        return 'Manual';
      case DocumentCategory.warranty:
        return 'Warranty';
      case DocumentCategory.receipt:
        return 'Receipt';
      case DocumentCategory.invoice:
        return 'Invoice';
      case DocumentCategory.permit:
        return 'Permit';
      case DocumentCategory.inspection:
        return 'Inspection Report';
      case DocumentCategory.contract:
        return 'Contract';
      case DocumentCategory.insurance:
        return 'Insurance';
      case DocumentCategory.closingDocument:
        return 'Closing Document';
      case DocumentCategory.survey:
        return 'Survey';
      case DocumentCategory.photo:
        return 'Photo';
      case DocumentCategory.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case DocumentCategory.manual:
        return 'menu_book';
      case DocumentCategory.warranty:
        return 'verified_user';
      case DocumentCategory.receipt:
        return 'receipt_long';
      case DocumentCategory.invoice:
        return 'request_quote';
      case DocumentCategory.permit:
        return 'badge';
      case DocumentCategory.inspection:
        return 'fact_check';
      case DocumentCategory.contract:
        return 'description';
      case DocumentCategory.insurance:
        return 'security';
      case DocumentCategory.closingDocument:
        return 'home_work';
      case DocumentCategory.survey:
        return 'architecture';
      case DocumentCategory.photo:
        return 'photo';
      case DocumentCategory.other:
        return 'attach_file';
    }
  }
}
