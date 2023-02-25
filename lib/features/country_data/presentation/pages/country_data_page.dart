import 'package:clean_architecture_tdd/features/country_data/domain/entities/country_data.dart';
import 'package:clean_architecture_tdd/features/country_data/presentation/bloc/country_data_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryDataPage extends StatefulWidget {
  const CountryDataPage({super.key});

  @override
  State<CountryDataPage> createState() => _CountryDataPageState();
}

class _CountryDataPageState extends State<CountryDataPage> {
  late TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Country Data App")),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black54),
            ),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: "Search Country",
                border: InputBorder.none,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    context.read<CountryDataBloc>().add(
                          ConcreteCountryDataEvent(countryName: textController.text),
                        );
                  }
                },
                child: const Text(
                  "Search Country",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              MaterialButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                onPressed: () {
                  context.read<CountryDataBloc>().add(
                        RandomCountryDataEvent(),
                      );
                },
                child: const Text(
                  "Random Country",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<CountryDataBloc, CountryDataState>(
              builder: (context, state) {
                if (state is Initial) {
                  return const Center(
                    child: Icon(CupertinoIcons.cube_box_fill),
                  );
                } else if (state is Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is Loaded) {
                  return ListView(
                    children: _countryData(state.countryData),
                  );
                } else {
                  return Center(child: Text((state as Error).message));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _countryData(CountryData countryData) {
    return <Widget>[
      DataItem(leading: "Capital", title: countryData.capital, isColored: true),
      DataItem(leading: "Region", title: countryData.region),
      DataItem(leading: "Forest area", title: countryData.forestedArea.toString(), isColored: true),
      DataItem(leading: "Population", title: countryData.population.toString()),
      DataItem(leading: "Tourists", title: countryData.tourists.toString(), isColored: true),
      DataItem(leading: "Unemployment", title: countryData.unemployment.toString()),
    ];
  }
}

// ignore: must_be_immutable
class DataItem extends StatelessWidget {
  DataItem({
    super.key,
    required this.leading,
    required this.title,
    this.isColored = false,
  });
  final String leading;
  final String title;
  bool isColored;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.maxFinite,
      padding: const EdgeInsets.only(left: 5),
      color: isColored ? Colors.black38 : Colors.white,
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(leading, style: const TextStyle(fontSize: 16))),
          Expanded(flex: 2, child: Text(title, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
