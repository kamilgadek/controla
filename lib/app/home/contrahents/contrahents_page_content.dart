import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controla/app/home/contrahents/cubit/contrahents_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContrahentsPageContent extends StatelessWidget {
  const ContrahentsPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContrahentsCubit(),
      child: BlocBuilder<ContrahentsCubit, ContrahentsState>(
        builder: (context, state) {
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("contrahents")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text('Loading'));
                }

                final documents = snapshot.data!.docs;

                return ListView(
                  children: [
                    for (final document in documents) ...[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Dismissible(
                          key: ValueKey(document.id),
                          onDismissed: (_) {
                            FirebaseFirestore.instance
                                .collection('contrahents')
                                .doc(document.id)
                                .delete();
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
                      ),
                    ],
                  ],
                );
              });
        },
      ),
    );
  }
}
