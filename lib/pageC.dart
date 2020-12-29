import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize(getAppId());
  runApp(PageC());
}

String getAppId() => Platform.isIOS
    ? 'ca-app-pub-3940256099942544~1458002511'
    : 'ca-app-pub-1242245744438049~7193891989';

class PageC extends StatefulWidget {
  @override
  _PageCState createState() => _PageCState();
}

class _PageCState extends State<PageC> {
  String alcool, gasolina;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController gasolinaController = TextEditingController();
  TextEditingController alcoolController = TextEditingController();
  String _infoText = "";

  void _resetFields() {
    gasolinaController.text = "";
    alcoolController.text = "";
    setState(() {
      _formkey = GlobalKey<FormState>();
    });
  }

  void calcula() {
    setState(() {
      double gasolina = double.parse(gasolinaController.text);
      double alcool = double.parse(alcoolController.text);
      double resultado = (alcool / gasolina);

      if (resultado > 0.70) {
        _infoText =
            "Vale a pena abastecer com Gasolina \n\n Percentual: (${resultado.toStringAsPrecision(3)})";
      } else {
        _infoText =
            "Vale a pena abastecer com Álcool\n\n Percentual: (${resultado.toStringAsPrecision(3)})";
      }
    });
  }

  final bannerAdIdAndroid = "ca-app-pub-1242245744438049/2679931905";
  final bannerAdIdIos = "ca-app-pub-3940256099942544/2934735716";
  @override
  void initState() {
    super.initState();
  }

  String getBannerId() => Platform.isIOS ? bannerAdIdIos : bannerAdIdAndroid;

  AdmobBanner getBanner(AdmobBannerSize size) {
    return AdmobBanner(
      adUnitId: getBannerId(),
      adSize: size,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        handleEvent(event, args, 'Banner');
      },
    );
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('Novo $adType Ad carregado!');
        break;
      case AdmobAdEvent.opened:
        print('Admob $adType Ad aberto!');
        break;
      case AdmobAdEvent.closed:
        print('Admob $adType Ad fechado!');
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType falhou ao carregar. :(');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.amber, Colors.amber[900]]),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(Icons.local_gas_station,
                        size: 80, color: Colors.white),
                  ),
                ],
              )),
          SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  buildTextFormFieldGasolina(),
                  SizedBox(
                    height: 20,
                  ),
                  buildTextFormFieldAlcool(),
                  buildContainerButton(context),
                  buildTextInfo(),
                ],
              ),
            ),
          ),
          Center(
              child: Container(
                  child: IconButton(
                      icon: Icon(
                        Icons.refresh,
                        size: 30,
                        color: Colors.amber,
                      ),
                      onPressed: _resetFields))),
                      SizedBox(
                    height: 30,
                  ),
          getBanner(AdmobBannerSize.FULL_BANNER),
        ],
      ),
    );
  }

  Text buildTextInfo() {
    return Text(_infoText,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold));
  }

  Container buildContainerButton(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        height: 60.0,
        child: Center(
            child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white)),
          color: Colors.amber,
          textColor: Colors.white,
          onPressed: () {
            if (_formkey.currentState.validate()) {
              calcula();
              FocusScope.of(context).requestFocus(new FocusNode());
            }
          },
          child: Text("Calcular",
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
        )));
  }

  TextFormField buildTextFormFieldAlcool() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
        labelText: "Preço do Álcool",
        labelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
      ),
      controller: alcoolController,
      validator: _validarAlcool,
      onSaved: (String val) {
        alcool = val;
      },
    );
  }

  TextFormField buildTextFormFieldGasolina() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
        labelText: "Preço da Gasolina",
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
      controller: gasolinaController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Informe o valor da gasolina';
        }
        return null;
      },
    );
  }

  String _validarAlcool(String value) {
    if (value.isEmpty) {
      return 'Informe o valor da gasolina';
    }
    if (double.parse(value) > 8.0) {
      return 'Valor inválido';
    }
    return null;
  }
}
