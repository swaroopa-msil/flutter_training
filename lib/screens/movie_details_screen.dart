import 'package:flutter/material.dart';
import 'package:march09/bloc/bloc_provider.dart';
import 'package:march09/bloc/movie_bloc.dart';

class DetailedMovieScreen extends StatelessWidget {
  const DetailedMovieScreen({super.key,required this.index });

  final index ;
  @override
  Widget build(BuildContext context) {
    MovieBloc counterBloc = BlocProvider.of<MovieBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Movie Details Screen ')
        ),
        body: StreamBuilder(
          stream: counterBloc.listenEvent,
          initialData: counterBloc.value,
          builder: (context,snapshot){
            return Center(
              child: Column(
                children: [
              Text('${snapshot.data?[index].movieName}'),
                  const SizedBox(height: 5),
                  Text('${snapshot.data?[index].movieDes}'),
                  const SizedBox(height: 5),
                  Text('${snapshot.data?[index].rating}')
            ],
              ),
            );
           },
        ),
      );
  }
}
