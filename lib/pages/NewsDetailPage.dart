import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class NewsDetailPage extends StatefulWidget {
  final String id;

  NewsDetailPage({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NewsDetailPageState(id: this.id);
}

class NewsDetailPageState extends State<NewsDetailPage> {
  String id;
  bool loaded = false;
  String detailDataStr;
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  NewsDetailPageState({Key key, this.id});

  @override
  void initState() {
    super.initState();
    // 监听WebView的加载事件
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        // 加载完成
        setState(() {
          loaded = true;
        });

        flutterWebViewPlugin.evalJavascript(
            'document.getElementsByClassName("am-navbar am-navbar-light")[0].style = "display: none;"');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(Text(
      "Deal Details",
      style: TextStyle(color: Colors.white),
    ));
    if (!loaded) {
      titleContent.add(CupertinoActivityIndicator());
    }
    titleContent.add(Container(width: 50.0));
    return WebviewScaffold(
      url: 'https://m.vipon.com/#/product/' + this.id,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => {
              Share.share('https://m.vipon.com/#/product/' + this.id)
            },
          )
        ],
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}
