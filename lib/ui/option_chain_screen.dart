import 'package:flutter/material.dart';
import 'package:march09/bloc/options_bloc.dart';
import 'package:march09/ui/widgets/header_bar.dart';
import 'package:march09/ui/widgets/option_chain_parent_scroll.dart';
import 'package:march09/ui/widgets/searching_bar.dart';


class OptionChainScreen extends StatefulWidget {
  const OptionChainScreen({super.key});

  @override
  State<OptionChainScreen> createState() => _OptionChainScreenState();
}

class _OptionChainScreenState extends State<OptionChainScreen> {

  OptionsBloc bloc = OptionsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            color: Colors.black,
          child: Column(
            children: [
              SearchingBar(bloc: bloc),
              const HeaderBar(),
              Flexible(child:
                OptionChainParentScroll(bloc: bloc)
              )
            ],
          ),
        ),
      )
    );
  }
}
