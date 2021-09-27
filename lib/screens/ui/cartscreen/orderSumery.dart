import 'package:flutter/material.dart';
import 'package:myshop/models/cartitem.dart';
import 'package:myshop/providers/cart.dart';
import 'package:provider/provider.dart';

class OrderSummery extends StatefulWidget {
  final CartItem product;
  final Key key;
  OrderSummery(this.product, this.key) : super(key: key);

  @override
  _OrderSummeryState createState() => _OrderSummeryState();
}

class _OrderSummeryState extends State<OrderSummery> {
  int _prquantity;

  String _selectedquantity;
  List<String> _quanties = ['1', '2', '3', '4', "more"];
  final qunatitycontroller = TextEditingController();
  @override
  void didChangeDependencies() {
    _prquantity = widget.product.quantity;
    setState(() {
      _selectedquantity = _prquantity.toString();
    });

    super.didChangeDependencies();
  }

  void _openModal(context) {
    showDialog(
      context: context,
      builder: (ctxt) => new AlertDialog(
        title: Text(
          "Enter Quantity",
          style: TextStyle(fontSize: 12),
        ),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(hintText: 'Quantity'),
                keyboardType: TextInputType.number,
                controller: qunatitycontroller,
              ),
            )
          ],
        ),
        actions: <Widget>[
          new TextButton(
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          new TextButton(
              child: const Text('Apply'),
              onPressed: () {
                setState(() {
                  _selectedquantity = qunatitycontroller.text;
                });
                Provider.of<Cart>(context, listen: false)
                    .increaseProductQuantity(
                        widget.product.id, int.parse(_selectedquantity));
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void _addproduct(qty) {
      Provider.of<Cart>(context, listen: false)
          .increaseProductQuantity(widget.product.id, qty);
    }

    return Card(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            child: Row(
              children: [
                Image.network(
                  '${widget.product.imageUrl}',
                  width: 100,
                  height: 110,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          '${widget.product.title}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rs:- ${widget.product.price}",
                          ),
                          new DropdownButton<String>(
                              items: _quanties.map((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: new Text(val),
                                );
                              }).toList(),
                              hint: Text('Qty:$_selectedquantity'),
                              onChanged: (String val) {
                                _selectedquantity = val;

                                if (val == 'more') {
                                  _openModal(context);
                                  return;
                                } else {
                                  _addproduct(int.parse(val));
                                }
                                setState(() {});
                              })
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total:- ${(widget.product.price * int.parse(_selectedquantity))}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Provider.of<Cart>(context, listen: false)
                                        .removeItem(widget.product.id);
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
