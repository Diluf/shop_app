import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';
import '../providers/orders_provider.dart' show OrdersProvider;

class OrdersScreen extends StatelessWidget {
  static const routeName = 'orders-screen';

  @override
  Widget build(BuildContext context) {
    // var ordersData = Provider.of<OrdersProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<OrdersProvider>(context, listen: false)
              .fetchAndSetOrders(),
          builder: (context, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapShot.error != null) {
                return Center(
                  child: Text('An error occured!'),
                );
              } else {
                return Consumer<OrdersProvider>(
                  builder: (context, orderData, child) => ListView.builder(
                    itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                    itemCount: orderData.orders.length,
                  ),
                );
              }
            }
          },
        )
        //  _isLoading
        //     ? Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : ListView.builder(
        //         itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i]),
        //         itemCount: ordersData.orders.length,
        //       ),
        );
  }
}
