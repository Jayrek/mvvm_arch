import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_arch/models/character.dart';
import 'package:mvvm_arch/viewmodels/product/product_bloc.dart';

class CharactterScreen extends StatelessWidget {
  const CharactterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: 6th call the event from your bloc here,
    // and handle the UI accordingly.
    context.read<ProductBloc>().add(const FetchCharacterById());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Character'),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          final character = state.character;
          if (character != Character.defaultValue) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    character.imageUrl,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const CircularProgressIndicator();
                    },
                    errorBuilder: (_, error, __) {
                      return const Icon(Icons.error);
                    },
                  ),
                  Text(
                    '${character.firstName} ${character.lastName}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
}
