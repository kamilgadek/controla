import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'contrahents_state.dart';

class ContrahentsCubit extends Cubit<ContrahentsState> {
  ContrahentsCubit() : super(const ContrahentsState(
    documents: [],
    errorMessage: '',
    isLoading: false,
  ));
}
