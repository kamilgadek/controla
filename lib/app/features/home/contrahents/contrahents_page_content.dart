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
            children: [
              for (final document in documents) ...[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 60,
                    child: Dismissible(
                      key: ValueKey(document.id),
                      background: const DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 23, 23, 23),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 30.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      confirmDismiss: (direction) async{
                        return direction == DismissDirection.endToStart;
                      },
                      onDismissed: (_) {
                        context
                            .read<RootCubit>()
                            .remove(documentID: document.id);
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(document['name']),
                            Text(document['material']),
                            Text(document['value'].toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
