part of 'contrahents_cubit.dart';

@immutable
class ContrahentsState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;

  const ContrahentsState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}
