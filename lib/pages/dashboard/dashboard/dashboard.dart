import 'package:flutter/material.dart';
import 'salesChart/pieChart.dart';
import 'progressChart/lineChart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electron',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.purple),
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),),
      body: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
      child: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15,),
            Container(
              width: 200,
              child: 
              Text('Total de Vendas', textAlign: TextAlign.center,),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.purpleAccent))),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: (BorderRadius.circular(10)), color: Colors.purple[100],),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                    Text('Total:', style: TextStyle(fontWeight: FontWeight.bold,)),
                    Text('NUM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.purple))
                  ],)
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: (BorderRadius.circular(10)), color: Colors.purple[100],),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                    Text('Ano:', style: TextStyle(fontWeight: FontWeight.bold,)),
                    Text('NUM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.purple))
                  ],)
                ),
              ],
            ),
            SizedBox(height: 15,),
            Container(
              decoration: BoxDecoration(borderRadius: (BorderRadius.circular(10)), color: Colors.purple[100],),
              padding: EdgeInsets.all(5),
              child: Column(children: [
                Text('Mês:', style: TextStyle(fontWeight: FontWeight.bold,)),
                Text('NUM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.purple)),
              ],)
            ),
            SizedBox(height: 15,),
            Container(
              width: 200,
              child: 
              Text('Receita', textAlign: TextAlign.center,),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.purpleAccent))),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: (BorderRadius.circular(10)), color: Colors.purple[100],),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                    Text('Total:', style: TextStyle(fontWeight: FontWeight.bold,)),
                    Text('NUM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.purple))
                  ],)
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: (BorderRadius.circular(10)), color: Colors.purple[100],),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                    Text('Ano:', style: TextStyle(fontWeight: FontWeight.bold,)),
                    Text('NUM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.purple))
                  ],)
                ),
              ],
            ),
            SizedBox(height: 15,),
            Container(
              decoration: BoxDecoration(borderRadius: (BorderRadius.circular(10)), color: Colors.purple[100],),
              padding: EdgeInsets.all(5),
              child: Column(children: [
                Text('Mês:', style: TextStyle(fontWeight: FontWeight.bold,)),
                Text('NUM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.purple)),
              ],)
            ),
            SizedBox(height: 15,),
            Container(
              width: 200,
              child: 
              Text('Gráficos', textAlign: TextAlign.center),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.purpleAccent))),
            ),
            SizedBox(height: 15,),
            Container(
              child: SalesPieChart(),
            ),
            Container(
              child: ProgressLineChart(),
            ),
        ],)
      ],),
    );
  }
}