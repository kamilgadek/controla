import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controla/app/cubit/root_cubit.dart';
import 'package:controla/app/features/home//contrahents/cubit/contrahents_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContrahentsPageContent extends StatelessWidget {
  const ContrahentsPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContrahentsCubit()..start(),
      child: BlocBuilder<ContrahentsCubit, ContrahentsState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text('Something went wrong : ${state.errorMessage}'),
            );
          }
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final documents = state.documents;

          return ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            children: [
              for (final document in documents)
                Dismissible(
                  key: ValueKey(document.id),
                  background: const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 32.0),
                      child: Icon(
                        Icons.delete
                      ),
                    ),
                  ),
                ),
                confirmDismiss: (direction) async {
                  return direction == DismissDirection.endToStart;
                },
                onDismissed: (direction) {
                  context.read<ContrahentsCubit>().remove(documentID: document);
                },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(document['name']),
                      Text(document['material']),
                      Text(document['value'].toString()),
                  
                    ],
                  ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
