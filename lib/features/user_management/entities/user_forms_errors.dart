class UserFormsErrors {
  final String? field;
  final String message;

  UserFormsErrors({
     this.field,
    this.message = "",
  });

  @override
  // TODO: implement props
  List<Object?> get props => [field, message];
}
