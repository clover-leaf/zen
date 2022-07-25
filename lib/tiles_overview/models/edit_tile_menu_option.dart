
/// The enum option of edit tile dialog
enum EditTileMenuOption {
  edit,
  delete,
  duplicate,
}


/// helper
extension EditTileMenuOptionX on EditTileMenuOption {
  /// convert [EditTileMenuOption] to [String] to display
  String toTitle() {
    switch (this) {
      case EditTileMenuOption.edit:
        return 'Edit';
      case EditTileMenuOption.delete:
        return 'Delete';
      case EditTileMenuOption.duplicate:
        return 'Duplicate';
    }
  }
}
