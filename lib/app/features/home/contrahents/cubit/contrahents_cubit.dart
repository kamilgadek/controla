import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'contrahents_state.dart';

class ContrahentsCubit extends Cubit<ContrahentsState> {
  ContrahentsCubit()
      : super(
          const ContrahentsState(
            documents: [],
            errorMessage: '',
            isLoading: false,
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const ContrahentsState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection("contrahents")
        .snapshots()
        .listen((data) {
      emit(
        ContrahentsState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          ContrahentsState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }
@override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  void remove({required QueryDocumentSnapshot<Map<String, dynamic>> documentID}) {}
}
