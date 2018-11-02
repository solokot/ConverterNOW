import 'package:converter_pro/ConversionPage.dart';
import 'package:converter_pro/Localization.dart';
import 'package:converter_pro/ReorderPage.dart';
import 'package:converter_pro/SettingsPage.dart';
import 'package:converter_pro/Utils.dart';
import 'package:converter_pro/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversionManager extends StatefulWidget{
  @override
  _ConversionManager createState() => new _ConversionManager();

}

class _ConversionManager extends State<ConversionManager>{

  static final MAX_CONVERSION_UNITS =10;
  List listaConversioni;
  List listaColori;
  List listaTitoli;
  int _currentPage=0;
  static List orderLunghezza=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
  static List orderSuperficie=[0,1,2,3,4,5,6,7,8,9];
  static List orderVolume=[0,1,2,3,4,5,6,7,8,9,10,11,12,13];
  static List orderTempo=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14];
  static List orderTemperatura=[0,1,2];
  static List orderVelocita=[0,1,2,3,4];
  static List orderPrefissi=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
  static List orderMassa=[0,1,2,3,4,5,6,7];
  static List orderPressione=[0,1,2,3,4,5];
  static List orderEnergia=[0,1,2,3];
  static List listaOrder=[orderLunghezza,orderSuperficie, orderVolume,orderTempo,orderTemperatura,orderVelocita,orderPrefissi,orderMassa,orderPressione,orderEnergia];

  @override
  void initState() {
    super.initState();
    _getOrders();
  }


  _onSelectItem(int index) {
    if(_currentPage!=index) {
      setState(() {
        _currentPage = index;
        Navigator.of(context).pop();
      });
    }
  }


  _saveOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> toConvertList=new List();
    for(int item in listaOrder[_currentPage])
      toConvertList.add(item.toString());
    prefs.setStringList("conversion_$_currentPage", toConvertList);
  }
  _getOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for(int i=0;i<MAX_CONVERSION_UNITS;i++){
      List StringList=prefs.getStringList("conversion_$i");

      if(StringList!=null){
        List intList=new List();
        for(int j=0;j<StringList.length;j++){
          intList.add(int.parse(StringList[j]));
        }
        if(i==_currentPage){
          setState(() {
            listaOrder[i]=intList;
          });
        }
        else
          listaOrder[i]=intList;

      }
    }
  }



  _navigateChangeOrder(BuildContext context,String title, Node nodo, Color color) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReorderPage(
            title: title,
            fatherNode: nodo,
            color:color
        ),));
    //
    List arrayCopia=new List(listaOrder[_currentPage].length);
    for(int i=0;i<listaOrder[_currentPage].length;i++)
      arrayCopia[i]=listaOrder[_currentPage][i];
    setState(() {
      for(int i=0;i<listaOrder[_currentPage].length;i++)
        listaOrder[_currentPage][i]=result.indexOf(arrayCopia[i]);
    });
    _saveOrders();
  }

  @override
  Widget build(BuildContext context) {

    Node metro=Node(name: MyLocalizations.of(context).trans('metro',),order: listaOrder[0][0],
        leafNodes: [
          Node(isMultiplication: false, coefficientPer: 100.0, name: MyLocalizations.of(context).trans('centimetro'),order: listaOrder[0][1], leafNodes: [
            Node(isMultiplication: true, coefficientPer: 2.54, name: MyLocalizations.of(context).trans('pollice'),order: listaOrder[0][2], leafNodes: [
              Node(isMultiplication: true, coefficientPer: 12.0, name: MyLocalizations.of(context).trans('piede'),order: listaOrder[0][3]),
            ]),
          ]),
          Node(isMultiplication: true, coefficientPer: 1852.0, name: MyLocalizations.of(context).trans('miglio_marino'),order: listaOrder[0][4],),
          Node(isMultiplication: true, coefficientPer: 0.9144, name: MyLocalizations.of(context).trans('yard'),order: listaOrder[0][5], leafNodes: [
            Node(isMultiplication: true, coefficientPer: 1760.0, name: MyLocalizations.of(context).trans('miglio_terrestre'),order: listaOrder[0][6],),
          ]),
          Node(isMultiplication: false, coefficientPer: 1000.0, name: MyLocalizations.of(context).trans('millimetro'),order: listaOrder[0][7],),
          Node(isMultiplication: false, coefficientPer: 1000000.0, name: MyLocalizations.of(context).trans('micrometro'), order: listaOrder[0][8],),
          Node(isMultiplication: false, coefficientPer: 1000000000.0, name: MyLocalizations.of(context).trans('nanometro'),order: listaOrder[0][9],),
          Node(isMultiplication: false, coefficientPer: 10000000000.0, name: MyLocalizations.of(context).trans('angstrom'),order: listaOrder[0][10],),
          Node(isMultiplication: false, coefficientPer: 1000000000000.0, name: MyLocalizations.of(context).trans('picometro'),order: listaOrder[0][11],),
          Node(isMultiplication: true, coefficientPer: 1000.0, name: MyLocalizations.of(context).trans('chilometro'),order: listaOrder[0][12],leafNodes: [
            Node(isMultiplication: true, coefficientPer: 149597870.7, name: MyLocalizations.of(context).trans('unita_astronomica'),order: listaOrder[0][13],leafNodes: [
              Node(isMultiplication: true, coefficientPer: 63241.1, name: MyLocalizations.of(context).trans('anno_luce'),order: listaOrder[0][14],leafNodes: [
                Node(isMultiplication: true, coefficientPer: 3.26, name: MyLocalizations.of(context).trans('parsec'),order: listaOrder[0][15],),
              ]),
            ]),
          ]),
        ]);

    Node metroq=Node(name: MyLocalizations.of(context).trans('metro_quadrato'),order: listaOrder[1][0],leafNodes: [
      Node(isMultiplication: false, coefficientPer: 10000.0, name: MyLocalizations.of(context).trans('centimetro_quadrato'),order: listaOrder[1][1], leafNodes: [
        Node(isMultiplication: true, coefficientPer: 6.4516, name: MyLocalizations.of(context).trans('pollice_quadrato'),order: listaOrder[1][2], leafNodes: [
          Node(isMultiplication: true, coefficientPer: 144.0, name: MyLocalizations.of(context).trans('piede_quadrato'),order: listaOrder[1][3]),
        ]),
      ]),
      Node(isMultiplication: false, coefficientPer: 1000000.0, name: MyLocalizations.of(context).trans('millimetro_quadrato'),order: listaOrder[1][4],),
      Node(isMultiplication: true, coefficientPer: 10000.0, name: MyLocalizations.of(context).trans('ettaro'),order: listaOrder[1][5],),
      Node(isMultiplication: true, coefficientPer: 1000000.0, name: MyLocalizations.of(context).trans('chilometro_quadrato'),order: listaOrder[1][6],),
      Node(isMultiplication: true, coefficientPer: 0.83612736, name: MyLocalizations.of(context).trans('yard_quadrato'),order: listaOrder[1][7], leafNodes: [
        Node(isMultiplication: true, coefficientPer: 3097600.0, name: MyLocalizations.of(context).trans('miglio_quadrato'),order: listaOrder[1][8]),
        Node(isMultiplication: true, coefficientPer: 4840.0, name: MyLocalizations.of(context).trans('acri'),order: listaOrder[1][9],),
      ]),
    ]);

    Node metroc=Node(name: MyLocalizations.of(context).trans('metro_cubo'),order: listaOrder[2][0],leafNodes: [
      Node(isMultiplication: false, coefficientPer: 1000.0, name: MyLocalizations.of(context).trans('litro'),order: listaOrder[2][1],leafNodes: [
        Node(isMultiplication: true, coefficientPer: 4.54609, name: MyLocalizations.of(context).trans('gallone_imperiale'),order: listaOrder[2][2],),
        Node(isMultiplication: true, coefficientPer: 3.785411784, name: MyLocalizations.of(context).trans('gallone_us'),order: listaOrder[2][3],),
        Node(isMultiplication: true, coefficientPer: 0.56826125, name: MyLocalizations.of(context).trans('pinta_imperiale'),order: listaOrder[2][4],),
        Node(isMultiplication: true, coefficientPer: 0.473176473, name: MyLocalizations.of(context).trans('pinta_us'),order: listaOrder[2][5],),
        Node(isMultiplication: false, coefficientPer: 1000.0, name: MyLocalizations.of(context).trans('millilitro'),order: listaOrder[2][6], leafNodes: [
          Node(isMultiplication: true, coefficientPer: 14.8, name: MyLocalizations.of(context).trans('tablespoon_us'),order: listaOrder[2][7],),
          Node(isMultiplication: true, coefficientPer: 20.0, name: MyLocalizations.of(context).trans('tablespoon_australian'),order:listaOrder[2][8],),
          Node(isMultiplication: true, coefficientPer: 240.0, name: MyLocalizations.of(context).trans('cup_us'),order: listaOrder[2][9],),
        ]),
      ]),
      Node(isMultiplication: false, coefficientPer: 1000000.0, name: MyLocalizations.of(context).trans('centimetro_cubo'),order: listaOrder[2][10], leafNodes: [
        Node(isMultiplication: true, coefficientPer: 16.387064, name: MyLocalizations.of(context).trans('pollice_cubo'),order: listaOrder[2][11], leafNodes: [
          Node(isMultiplication: true, coefficientPer: 1728.0, name: MyLocalizations.of(context).trans('piede_cubo'),order: listaOrder[2][12],),
        ]),
      ]),
      Node(isMultiplication: false, coefficientPer: 1000000000.0, name: MyLocalizations.of(context).trans('millimetro_cubo'),order: listaOrder[2][13],),
    ]);

    Node secondo=Node(name: MyLocalizations.of(context).trans('secondo'),order: listaOrder[3][0],
        leafNodes: [
          Node(isMultiplication: false, coefficientPer: 10.0, name: MyLocalizations.of(context).trans('decimo_secondo'),order: listaOrder[3][1],),
          Node(isMultiplication: false, coefficientPer: 100.0, name: MyLocalizations.of(context).trans('centesimo_secondo'), order: listaOrder[3][2],),
          Node(isMultiplication: false, coefficientPer: 1000.0, name: MyLocalizations.of(context).trans('millisecondo'),order: listaOrder[3][3],),
          Node(isMultiplication: false, coefficientPer: 1000000.0, name: MyLocalizations.of(context).trans('microsecondo'),order: listaOrder[3][4],),
          Node(isMultiplication: false, coefficientPer: 1000000000.0, name: MyLocalizations.of(context).trans('nanosecondo'),order: listaOrder[3][5],),
          Node(isMultiplication: true, coefficientPer: 60.0, name: MyLocalizations.of(context).trans('minuti'),order: listaOrder[3][6],leafNodes: [
            Node(isMultiplication: true, coefficientPer: 60.0, name: MyLocalizations.of(context).trans('ore'),order: listaOrder[3][7],leafNodes: [
              Node(isMultiplication: true, coefficientPer: 24.0, name: MyLocalizations.of(context).trans('giorni'),order: listaOrder[3][8],leafNodes: [
                Node(isMultiplication: true, coefficientPer: 7.0, name: MyLocalizations.of(context).trans('settimane'),order: listaOrder[3][9],),
                Node(isMultiplication: true, coefficientPer: 365.0, name: MyLocalizations.of(context).trans('anno'),order: listaOrder[3][10],leafNodes: [
                  Node(isMultiplication: true, coefficientPer: 5.0, name: MyLocalizations.of(context).trans('lustro'),order: listaOrder[3][11],),
                  Node(isMultiplication: true, coefficientPer: 10.0, name: MyLocalizations.of(context).trans('decade'),order: listaOrder[3][12],),
                  Node(isMultiplication: true, coefficientPer: 100.0, name: MyLocalizations.of(context).trans('secolo'),order: listaOrder[3][13],),
                  Node(isMultiplication: true, coefficientPer: 1000.0, name: MyLocalizations.of(context).trans('millennio'),order: listaOrder[3][14],),
                ]),
              ]),
            ]),
          ]),
        ]);

    Node celsius=Node(name: MyLocalizations.of(context).trans('fahrenheit'),order: listaOrder[4][0],leafNodes:[
      Node(isMultiplication: true, coefficientPer: 1.8, isSum: true, coefficientPlus: 32.0, name: MyLocalizations.of(context).trans('celsius'),order: listaOrder[4][1],leafNodes: [
        Node(isSum: false, coefficientPlus: 273.15, name: MyLocalizations.of(context).trans('kelvin'),order: listaOrder[4][2],),
      ]),
    ]);

    Node metri_secondo=Node(name: MyLocalizations.of(context).trans('metri_secondo'), order: listaOrder[5][0], leafNodes: [
      Node(isMultiplication: false, coefficientPer: 3.6, name: MyLocalizations.of(context).trans('chilometri_ora'),order: listaOrder[5][1], leafNodes:[
        Node(isMultiplication: true, coefficientPer: 1.609344, name: MyLocalizations.of(context).trans('miglia_ora'),order: listaOrder[5][2],),
        Node(isMultiplication: true, coefficientPer: 1.852, name: MyLocalizations.of(context).trans('nodi'),order: listaOrder[5][3],),
      ]),
      Node(isMultiplication: true, coefficientPer: 0.3048, name: MyLocalizations.of(context).trans('piedi_secondo'),order: listaOrder[5][4],),
    ]);

    Node SI=Node(name: "Base",order: listaOrder[6][0],
        leafNodes: [
          Node(isMultiplication: true, coefficientPer: 10.0, name: "Deca [da]",order: listaOrder[6][1],),
          Node(isMultiplication: true, coefficientPer: 100.0, name: "Hecto [h]",order: listaOrder[6][2],),
          Node(isMultiplication: true, coefficientPer: 1000.0, name: "Kilo [k]",order: listaOrder[6][3],),
          Node(isMultiplication: true, coefficientPer: 1000000.0, name: "Mega [M]",order: listaOrder[6][4],),
          Node(isMultiplication: true, coefficientPer: 1000000000.0, name: "Giga [G]",order: listaOrder[6][5],),
          Node(isMultiplication: true, coefficientPer: 1000000000000.0, name: "Tera [T]",order: listaOrder[6][6],),
          Node(isMultiplication: true, coefficientPer: 1000000000000000.0, name: "Peta [P]",order: listaOrder[6][7],),
          Node(isMultiplication: true, coefficientPer: 1000000000000000000.0, name: "Exa [E]",order: listaOrder[6][8],),
          Node(isMultiplication: true, coefficientPer: 1000000000000000000000.0, name: "Zetta [Z]",order: listaOrder[6][9],),
          Node(isMultiplication: true, coefficientPer: 1000000000000000000000000.0, name: "Yotta [Y]",order: listaOrder[6][10],),
          Node(isMultiplication: false, coefficientPer: 10.0, name: "Deci [d]",order: listaOrder[6][11],),
          Node(isMultiplication: false, coefficientPer: 100.0, name: "Centi [c]",order: listaOrder[6][12],),
          Node(isMultiplication: false, coefficientPer: 1000.0, name: "Milli [m]",order: listaOrder[6][13],),
          Node(isMultiplication: false, coefficientPer: 1000000.0, name: "Micro [µ]",order: listaOrder[6][14],),
          Node(isMultiplication: false, coefficientPer: 1000000000.0, name: "Nano [n]",order: listaOrder[6][15],),
          Node(isMultiplication: false, coefficientPer: 1000000000000.0, name: "Pico [p]",order: listaOrder[6][16],),
          Node(isMultiplication: false, coefficientPer: 1000000000000000.0, name: "Femto [f]",order: listaOrder[6][17],),
          Node(isMultiplication: false, coefficientPer: 1000000000000000000.0, name: "Atto  [a]",order: listaOrder[6][18],),
          Node(isMultiplication: false, coefficientPer: 1000000000000000000000.0, name: "Zepto [z]",order: listaOrder[6][19],),
          Node(isMultiplication: false, coefficientPer: 1000000000000000000000000.0, name: "Yocto [y]",order: listaOrder[6][20],),
        ]
    );

    //da sistemare ordinamento e nome
    Node grammo=Node(name: MyLocalizations.of(context).trans('grammo'),order: listaOrder[7][0],
      leafNodes: [
      Node(isMultiplication: true, coefficientPer: 100.0, name: MyLocalizations.of(context).trans('ettogrammo'),order: listaOrder[7][1],),
      Node(isMultiplication: true, coefficientPer: 1000.0, name: MyLocalizations.of(context).trans('chilogrammo'),order: listaOrder[7][2],leafNodes:[
        Node(isMultiplication: true, coefficientPer: 0.45359237, name: MyLocalizations.of(context).trans('libbra'),order: listaOrder[7][3],),
      ]),
      Node(isMultiplication: true, coefficientPer: 100000.0, name: MyLocalizations.of(context).trans('quintale'),order: listaOrder[7][4],),
      Node(isMultiplication: true, coefficientPer: 1000000.0, name: MyLocalizations.of(context).trans('tonnellata'),order: listaOrder[7][5],),
      Node(isMultiplication: false, coefficientPer: 1000.0, name: MyLocalizations.of(context).trans('milligrammo'),order: listaOrder[7][6],),
      Node(isMultiplication: true, coefficientPer: 1.660539e-24, name: MyLocalizations.of(context).trans('uma'),order: listaOrder[7][7],),
    ]);

    Node pascal=Node(name: MyLocalizations.of(context).trans('pascal'),order: listaOrder[8][0],
        leafNodes: [
          Node(isMultiplication: true, coefficientPer: 101325.0, name: MyLocalizations.of(context).trans('atmosfere'),order: listaOrder[8][1],leafNodes:[
            Node(isMultiplication: true, coefficientPer: 0.987, name: MyLocalizations.of(context).trans('bar'),order: listaOrder[8][2],leafNodes:[
              Node(isMultiplication: false, coefficientPer: 1000.0, name: MyLocalizations.of(context).trans('millibar'),order: listaOrder[8][3],),
            ]),
          ]),
          Node(isMultiplication: true, coefficientPer: 6894.757293168, name: MyLocalizations.of(context).trans('psi'),order: listaOrder[8][4],),
          Node(isMultiplication: true, coefficientPer: 133.322368421, name: MyLocalizations.of(context).trans('torr'),order: listaOrder[8][5],),
    ]);

    Node joule=Node(name: MyLocalizations.of(context).trans('joule'),order: listaOrder[9][0],
        leafNodes: [
          Node(isMultiplication: true, coefficientPer: 4.1867999409, name: MyLocalizations.of(context).trans('calorie'),order: listaOrder[9][1]),
          Node(isMultiplication: true, coefficientPer: 3600000.0, name: MyLocalizations.of(context).trans('kilowattora'),order: listaOrder[9][2],),
          Node(isMultiplication: true, coefficientPer: 1.60217646e-19, name: MyLocalizations.of(context).trans('elettronvolt'),order: listaOrder[9][3],),
        ]);


    listaConversioni=[metro,metroq, metroc,secondo, celsius, metri_secondo,SI,grammo,pascal,joule];
    listaColori=[Colors.red,Colors.deepOrange,Colors.amber,
    Colors.cyan, Colors.indigo, Colors.purple,
    Colors.blueGrey,Colors.green,Colors.pinkAccent,
    Colors.teal];
    listaTitoli=[MyLocalizations.of(context).trans('lunghezza'),MyLocalizations.of(context).trans('superficie'),MyLocalizations.of(context).trans('volume'),
    MyLocalizations.of(context).trans('tempo'),MyLocalizations.of(context).trans('temperatura'),MyLocalizations.of(context).trans('velocita'),
    MyLocalizations.of(context).trans('prefissi_si'),MyLocalizations.of(context).trans('massa'),MyLocalizations.of(context).trans('pressione'),
    MyLocalizations.of(context).trans('energia')];

    List<Choice> choices = <Choice>[
      Choice(title: MyLocalizations.of(context).trans('riordina'), icon: Icons.reorder),
    ];

    return Scaffold(
      appBar: AppBar(
        title: new Text(listaTitoli[_currentPage]),
        backgroundColor: listaColori[_currentPage],
        actions: <Widget>[
          IconButton(icon: Icon(Icons.clear,color: Colors.white,semanticLabel: 'Clear all',),
            onPressed: () {
              setState(() {
                listaConversioni[_currentPage].ClearAllValues();
              });
            },),
          PopupMenuButton<Choice>(
            onSelected: (Choice choice){
              _navigateChangeOrder(context, MyLocalizations.of(context).trans('mio_ordinamento'), listaConversioni[_currentPage], listaColori[_currentPage]);
            },
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Stack(
              children: <Widget>[
                DrawerHeader(
                  child: Container(
                    child: Image.asset("resources/images/logo.png"),
                  ),
                  decoration: BoxDecoration(color: listaColori[_currentPage],),
                ),
                Container(
                    child:IconButton(
                      icon:Icon(Icons.settings),
                      color: Colors.white,
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsPage()),
                        );
                      },
                    ),
                  height: 190.0,
                  alignment: FractionalOffset.bottomRight,
                )

              ],
              fit: StackFit.passthrough,
            ),

            ListTileTheme(
              child:ListTile(
                  title: Row(children: <Widget>[
                    Image.asset("resources/images/lunghezza.png",width: 30.0,height: 30.0, color: _currentPage==0 ? listaColori[_currentPage] : Colors.black54,),
                    SizedBox(width: 20.0,),
                    Text(listaTitoli[0],)
                  ],),
                  selected: _currentPage==0,
                  onTap: (){
                    _onSelectItem(0);
                  }
              ),
              selectedColor: listaColori[_currentPage],
            ),
            ListTileTheme(
              child: ListTile(title: Row(children: <Widget>[
                Image.asset("resources/images/area.png",width: 30.0,height: 30.0, color:  _currentPage==1 ? listaColori[_currentPage] :Colors.black54,),
                SizedBox(width: 20.0,),
                Text(listaTitoli[1])
              ],),
                selected: _currentPage==1,
                  onTap:(){
                    _onSelectItem(1);
                  }
              ),
              selectedColor: listaColori[_currentPage],
            ),

            ListTileTheme(
              child:ListTile(
                title: Row(children: <Widget>[
                  Image.asset("resources/images/volume.png",width: 30.0,height: 30.0, color:  _currentPage==2 ? listaColori[_currentPage] :Colors.black54,),
                  SizedBox(width: 20.0,),
                  Text(listaTitoli[2])
                ],),
                selected: _currentPage==2,
                onTap: () {
                  _onSelectItem(2);
                },
              ),
              selectedColor: listaColori[_currentPage],
            ),
            ListTileTheme(
                child:ListTile(
                  title: Row(children: <Widget>[
                    Icon(Icons.access_time, color:  _currentPage==3 ? listaColori[_currentPage] :Colors.black54,size: 30.0,),
                    SizedBox(width: 20.0,),
                    Text(listaTitoli[3])
                  ],),
                  selected: _currentPage==3,
                  onTap: () {
                    _onSelectItem(3);
                  },
                ),
              selectedColor: listaColori[_currentPage],
            ),
            ListTileTheme(
                child:ListTile(
                  title: Row(children: <Widget>[
                    Image.asset("resources/images/temperatura.png",width: 30.0,height: 30.0, color:  _currentPage==4 ? listaColori[_currentPage] :Colors.black54,),
                    SizedBox(width: 20.0,),
                    Text(listaTitoli[4])
                  ],),
                  selected: _currentPage==4,
                  onTap: () {
                    _onSelectItem(4);
                  },
                ),
              selectedColor: listaColori[_currentPage],
            ),
            ListTileTheme(
                child:ListTile(
                  title: Row(children: <Widget>[
                    Image.asset("resources/images/speed.png",width: 30.0,height: 30.0, color:  _currentPage==5 ? listaColori[_currentPage] :Colors.black54,),
                    SizedBox(width: 20.0,),
                    Text(listaTitoli[5])
                  ],),
                  selected: _currentPage==5,
                  onTap: () {
                    _onSelectItem(5);
                  },
                ),
              selectedColor: listaColori[_currentPage],
            ),
            ListTileTheme(
                child:ListTile(
                  title: Row(children: <Widget>[
                    Image.asset("resources/images/prefissi.png",width: 30.0,height: 30.0, color:  _currentPage==6 ? listaColori[_currentPage] :Colors.black54,),
                    SizedBox(width: 20.0,),
                    Text(listaTitoli[6])
                  ],),
                  selected: _currentPage==6,
                  onTap: () {
                    _onSelectItem(6);
                  },
                ),
              selectedColor: listaColori[_currentPage],
            ),
            ListTileTheme(
                child:ListTile(
                  title: Row(children: <Widget>[
                    Image.asset("resources/images/massa.png",width: 30.0,height: 30.0, color:  _currentPage==7 ? listaColori[_currentPage] :Colors.black54,),
                    SizedBox(width: 20.0,),
                    Text(listaTitoli[7])
                  ],),
                  selected: _currentPage==7,
                  onTap: () {
                    _onSelectItem(7);
                  },
                ),
              selectedColor: listaColori[_currentPage],
            ),
            ListTileTheme(
                child:ListTile(
                  title: Row(children: <Widget>[
                    Image.asset("resources/images/pressione.png",width: 30.0,height: 30.0, color:  _currentPage==8 ? listaColori[_currentPage] :Colors.black54,),
                    SizedBox(width: 20.0,),
                    Text(listaTitoli[8])
                  ],),
                  selected: _currentPage==8,
                  onTap: () {
                    _onSelectItem(8);
                  },
                ),
              selectedColor: listaColori[_currentPage],
            ),
            ListTileTheme(
                child:ListTile(
                  title: Row(children: <Widget>[
                    Image.asset("resources/images/energia.png",width: 30.0,height: 30.0, color:  _currentPage==9 ? listaColori[_currentPage] :Colors.black54,),
                    SizedBox(width: 20.0,),
                    Text(listaTitoli[9])
                  ],),
                  selected: _currentPage==9,
                  onTap: () {
                    _onSelectItem(9);
                  },
                ),
              selectedColor: listaColori[_currentPage],
            ),
            SizedBox(height: AD_SIZE,)
          ],
      ),
      ),
      body: ConversionPage(listaConversioni[_currentPage]),

    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
