import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffemate/constants.dart';
import 'package:coffemate/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool state = false;
  String _name = "";
  int _azucar = 0;
  int _stevia = 0;
  int _selectedCoffee = 0;
  late Coffe mycoffee;

  final String _email = FirebaseAuth.instance.currentUser!.email ?? "default0";

  final coffeRef =
      FirebaseFirestore.instance.collection('coffes').withConverter<Coffe>(
            fromFirestore: (snapshots, _) => Coffe.fromJson(snapshots.data()!),
            toFirestore: (coffe, _) => coffe.toJson(),
          );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            //backgroundColor: secondaryColor,
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.eject,
                color: secondaryColor,
              ),
              onPressed: () {},
            ),
            middle: const Text(
              "coffemate",
              style: TextStyle(
                color: primaryColor,
              ),
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.settings,
                color: secondaryColor,
              ),
              onPressed: () => showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) => Container(
                  height: 216,
                  padding: const EdgeInsets.only(top: 6.0),
                  // The Bottom margin is provided to align the popup above the system navigation bar.
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  // Provide a background color for the popup.
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  // Use a SafeArea widget to avoid system overlaps.
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: const Text(
                            "Name",
                            style: tsH1Black,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CupertinoTextField(
                            padding: const EdgeInsets.all(12.0),
                            onChanged: (value) => _name = value,
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.number,
                            placeholder: "",
                            prefix: Container(
                                height: 20.0,
                                margin: const EdgeInsets.only(left: 12.0),
                                child: const Icon(CupertinoIcons.mail)),
                            // placeholder: "Usuario",
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: greyLightColor),
                            ),
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 1,
                          child: CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 24.0,
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                                _selectedCoffee = selectedItem;
                              });
                            },
                            children: List<Widget>.generate(12, (int index) {
                              return Center(
                                child: Image.asset(
                                    "assets/${index.toString()}.png"),
                              );
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CupertinoPicker(
                                itemExtent: 10.0,
                                onSelectedItemChanged: (int selectedItem) {
                                  setState(() {
                                    _azucar = selectedItem;
                                  });
                                },
                                children: List<Widget>.generate(4, (int index) {
                                  return Center(
                                    child: Text(index.toString(),
                                        style: tsH3Black),
                                  );
                                }),
                              ),
                              const Icon(CupertinoIcons.wand_rays,
                                  color: Color(0xFF54BAB9)),
                              const Text("Azucar", style: tsH4Black),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CupertinoPicker(
                                itemExtent: 10.0,
                                onSelectedItemChanged: (int selectedItem) {
                                  setState(() {
                                    _stevia = selectedItem;
                                  });
                                },
                                children: List<Widget>.generate(4, (int index) {
                                  return Center(
                                    child: Text(index.toString(),
                                        style: tsH3Black),
                                  );
                                }),
                              ),
                              const Icon(CupertinoIcons.leaf_arrow_circlepath,
                                  color: Color(0xFF6ECB63)),
                              const Text("Azucar", style: tsH4Black),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoButton.filled(
                              onPressed: _updateData,
                              child: const Text("Update info")),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            largeTitle: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Tu compañero de café",
                style:
                    CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
              ),
            ),
            //previousPageTitle: "Back",
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Expanded(
              child: StreamBuilder<QuerySnapshot<Coffe>>(
                stream: coffeRef.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CupertinoActivityIndicator());
                  }

                  final data = snapshot.requireData;

                  return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return CoffeItem(
                        data.docs[index].data(),
                        data.docs[index].reference,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateData() async {
    mycoffee = Coffe(
        name: _name,
        coffee: _selectedCoffee,
        azucar: _azucar,
        stevia: _stevia,
        email: _email);
    coffeRef
        .doc(_email)
        .set(mycoffee)
        .onError((e, _) => print("Error writing document: $e"));
  }
}

class CoffeItem extends StatelessWidget {
  const CoffeItem(this.coffe, this.reference, {Key? key}) : super(key: key);

  final Coffe coffe;
  final DocumentReference<Coffe> reference;

  @override
  Widget build(BuildContext context) {
    double heighty = MediaQuery.of(context).size.width * 0.6180333;
    return SizedBox(
      width: double.infinity,
      height: heighty,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Positioned(
                left: -24,
                child: Container(
                  width: heighty * 1.2,
                  height: heighty * 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48.0),
                    color: brownDark.withOpacity(1 / coffe.coffee),
                  ),
                  child: Positioned(
                      right: 24,
                      child: Image.asset("assets/${coffe.coffee}.png")),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(coffe.name, style: tsH2Black),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(coffe.azucar.toString(), style: tsH4Black),
                  const Icon(CupertinoIcons.wand_rays,
                      color: Color(0xFF54BAB9)),
                  const SizedBox(width: 12.0),
                  Text(coffe.stevia.toString(), style: tsH4Black),
                  const Icon(CupertinoIcons.leaf_arrow_circlepath,
                      color: Color(0xFF6ECB63)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
