import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final name;
  final company;
  final price;
  final quantity;
  final date;
  final caliberData;
  final comName;

  const Details({
    super.key,
    this.name,
    this.company,
    this.price,
    this.quantity,
    this.date,
    this.caliberData,
    this.comName,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(children: [
      Expanded(
          child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Image.asset(
                "images/1703057726807.png",
                height: 200,
                width: 200,
              ),
            ),
            Text("DrugSwift",
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: "Lobster",
                    color: Color.fromARGB(229, 139, 139, 139))),
          ],
        ),
      )),
      Expanded(
        flex: 3,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(15),
                child: Text(
                  "Details",
                  style: TextStyle(
                      color: Color.fromARGB(255, 48, 38, 135),
                      fontWeight: FontWeight.w900,
                      fontSize: 40),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: Color.fromARGB(255, 183, 151, 240),
                child: Text(
                  "${widget.comName}" "${widget.caliberData}",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                height: 60,
              ),
              Expanded(
                child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 48, 38, 135),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Card(
                            color: Color.fromARGB(255, 183, 151, 240),
                            margin: EdgeInsets.all(10),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Container(
                                height: 35,
                                child: ListTile(
                                  leading: Text(
                                    "Scientific Name: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  title: Text(
                                    widget.name.toString(),
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 48, 38, 135),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          // color: Color.fromARGB(255, 252, 212, 242),
                        ),
                        child: Card(
                            color: Color.fromARGB(255, 183, 151, 240),
                            margin: EdgeInsets.all(10),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Container(
                                height: 35,
                                child: ListTile(
                                  leading: Text("Company: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  title: Text(widget.company.toString(),
                                      style: TextStyle(fontSize: 25)),
                                ),
                              ),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 48, 38, 135),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Card(
                            color: Color.fromARGB(255, 183, 151, 240),
                            margin: EdgeInsets.all(10),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Container(
                                height: 35,
                                child: ListTile(
                                  leading: Text("Price: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  title: Text(widget.price.toString(),
                                      style: TextStyle(fontSize: 25)),
                                ),
                              ),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 48, 38, 135),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Card(
                            color: Color.fromARGB(255, 183, 151, 240),
                            margin: EdgeInsets.all(10),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Container(
                                height: 35,
                                child: ListTile(
                                  leading: Text("Quantity: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  title: Text(widget.quantity.toString(),
                                      style: TextStyle(fontSize: 25)),
                                ),
                              ),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 48, 38, 135),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Card(
                            color: Color.fromARGB(255, 183, 151, 240),
                            margin: EdgeInsets.all(10),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Container(
                                height: 35,
                                child: ListTile(
                                  leading: Text("Expiration Date: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  title: Text(widget.date.toString(),
                                      style: TextStyle(fontSize: 25)),
                                ),
                              ),
                            )),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
