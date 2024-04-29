import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:march09/bloc/movie_bloc.dart';
import 'package:march09/bloc/bloc_provider.dart';
import 'package:march09/model/movie_model.dart';

import 'movie_details_screen.dart';

class MovieHomeScreen extends StatelessWidget {
  const MovieHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MovieBloc movieBloc = BlocProvider.of<MovieBloc>(context);
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final decController = TextEditingController();
    final rateController = TextEditingController();

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
         Expanded(
           child:
               StreamBuilder(
                stream: movieBloc.listenEvent,
                initialData: movieBloc.value,
                builder: (context, snapshot) {
                  return   ListView.builder(
                  itemCount: movieBloc.value.length,
                 itemBuilder: (context,index) {
                  return Container(
                    decoration: const BoxDecoration(
                    color: Colors.grey,
                    ),
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return DetailedMovieScreen(index: index) ;
                        }));
                      },
                        contentPadding: const EdgeInsets.all(4),
                        title: Text('Movie Name: ${snapshot.data?[index].movieName}',style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
                        subtitle: Text('Movie Description: ${snapshot.data?[index].movieDes}',style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
                        trailing: Text('Movie Rate: ${snapshot.data?[index].rating}',style: TextStyle(color: Theme.of(context).colorScheme.onBackground))
                      ),
                  );
                  }
                  );
                }),
         ),
          Container(
            decoration:  const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.rectangle
            ),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          labelText: 'Enter Movie Name'
                      ),
                      validator: (value){
                        if(value?.isEmpty == true){
                          return 'enter valid Movie name';
                        }
                        return null;
                      }
                    ),
                    TextFormField(
                      controller: decController,
                      decoration: const InputDecoration(
                          labelText: 'Enter Movie Description'
                      ),
                      validator: (value){
                        if(value?.isEmpty == true){
                          return 'enter valid Movie description';
                        }
                        return null;
                      }
                    ),
                    TextFormField(
                     controller: rateController,
                      decoration: const InputDecoration(
                          labelText: 'Enter Movie Rating'
                      ),
                      validator: (value){
                        if(value?.isEmpty == true){
                          return 'enter valid Movie rate';
                        }
                        return null;
                      }
                    )
                  ],
                ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FloatingActionButton(onPressed: (){
                        movieBloc.addToList(MovieModel(rating: rateController.text,
                            movieName: nameController.text, movieDes: decController.text));
                      rateController.clear();
                      decController.clear();
                      nameController.clear();
                    },child: const Text('Add to list')),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
