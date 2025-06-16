import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:example/custom/title_child_card.dart';
import 'package:example/pages/splitter_demo.dart';
import 'package:flutter/material.dart';
import 'package:kurban_custom_widgets/kurban_custom_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Intl Ui Demo", home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String jsonString = '''
  {"Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjQxM2VlNmRlOGY4YTBhNjNkNGI3ZDAwZjI0YmZlYzdlOTY1N2IyNmY4ODdhNTc0YWExNjA0NzhjZDE5NDM3NmE5ZTI1Nzk2YzRlMTM2NzEyIn0.eyJhdWQiOiIxIiwianRpIjoiNDEzZWU2ZGU4ZjhhMGE2M2Q0YjdkMDBmMjRiZmVjN2U5NjU3YjI2Zjg4N2E1NzRhYTE2MDQ3OGNkMTk0Mzc2YTllMjU3OTZjNGUxMzY3MTIiLCJpYXQiOjE3NDcyMTMzOTUsIm5iZiI6MTc0NzIxMzM5NSwiZXhwIjoxNzc4NzQ5Mzk1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.yp1uD7CXbgOGojdBMhsmFMLX5mL4c3KBlGIC6ldjV6ADK14NOR8JKfE1fyzN3QnAqx2ymQHqRuphwkg2P0lAY_FVaOLuXWqZUeqh5pZVrslyYL3mtSoGJ2GTNIStAvns7AbDO5vbQd0TtBqS09XVV3o8c1az0yc4Piu_i2o1no6UAqxYQBaE3NuhmoljtPUJIVA1-8n3kaR2uAw48c48EeTDVa-MLjBIQnxeMT7Hw26HDdqnoqi6jQanh_peC_j3xztCZ7hv9Ks-sUAsOHABQ_InWmjboTXaQaCylFT8SmBI4UgybueLb7aiN3rR92Al_0xy9xpReJXpkWdvhpNqixN1c4XVJEhLLJWlJ7xXPM8pGKQ1xjs4vKKASFuzhkRdl9Kr-A9J6wejwuKOegYhOw5wkO2QrVKTDPOKU7_NIEhBr81u0pU6TkdXpIF2odoA7xXTEG9ghM0BrTYCrUQ0591v3X49OvtOaJp03liBObH9vDNHKWBG0HBtDnhloHy54nh5nWI07YqLvW1Dq0Qz_ZePdTnjoZMrfhFUuT1xxTWoHLRjduXuam_nW5Cid3I4jMQtV0obuOSODGewUTlHjUyhVy2G_2aejDRmvO3lGXcMbgKGwNGdPM5ulouu-97LaYqtd4tN1dgOamMOkNGCPcFBIoQ05pbDnn615SWBLSo","Accept":"application/json","jpushId":"170976fa8bb82c37411","searialNumber":"feabda84c64bb5f4","terminalId":1,"lang":2,"content-type":"application/json"}
  ''';

  final List<String> itemList = ["one", "two", "three", "four", "five", "six"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Intl UI Demo')),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          TitleChildCard(
            title: 'ToggleButtonGroup',
            child: KurbanToggleButton(labels: itemList, onSelected: (index) {}),
          ),
          TitleChildCard(
            title: 'ToggleButtonGroupBuilder',
            child: KurbanToggleButton(
              labels: itemList,
              size: 64,
              itemBuilder: (context, index, isSelect) {
                return Card(
                  color: isSelect ? Colors.blue : Colors.grey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 100,
                    ),
                    child: Center(child: Text(itemList[index])),
                  ),
                );
              },
              onSelected: (index) {},
            ),
          ),
          TitleChildCard(
            title: 'DottedDividerWidget',
            child: DottedDividerWidget(
              color: Colors.blue,
              strokeWidth: 6,
              dashSpace: 10,
            ),
          ),

          TitleChildCard(
            title: 'RadiusImage',
            child: KurbanRadiusImage(
              width: 300,
              height: 300,
              radius: 30,
              image: NetworkImage("https://picsum.photos/300"),
            ),
          ),

          TitleChildCard(
            title: 'JsonViewer',
            child: KurbanJsonViewer(jsonData: jsonDecode(jsonString)),
          ),
          TitleChildCard(
            title: 'DioLoggerScreen',
            child: ElevatedButton(
              onPressed: () {
                Dio dio = Dio();
                dio.interceptors.add(DioLoggerInterceptors());
                dio
                    .get('https://xxx.xxxx.com/api/v1/test')
                    .then((response) {
                      debugPrint(response.data.toString());
                    })
                    .catchError((error) {
                      debugPrint(error.toString());
                    });
              },
              child: Text('发送Dio请求'),
            ),
          ),
          TitleChildCard(
            title: 'DioLoggerNavButton',
            child: DioLoggerNavButton(),
          ),
          ListTile(
            title: Text("Splitter"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SplitterDemo()),
              );
            },
          ),
        ],
      ),
    );
  }
}
