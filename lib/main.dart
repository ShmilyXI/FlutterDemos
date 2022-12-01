import 'package:flutter/material.dart';
import 'package:flutter_demos/widget/scroll_listener_demo_page.dart'
    deferred as scroll_listener_demo_page;
import 'package:flutter_demos/widget/scroll_to_index_demo_page.dart'
    deferred as scroll_to_index_demo_page;
import 'package:flutter_demos/widget/scroll_to_index_demo_page2.dart'
    deferred as scroll_to_index_demo_page2;
import 'package:flutter_demos/widget/refrsh_demo_page.dart'
    deferred as refrsh_demo_page;
import 'package:flutter_demos/widget/refrsh_demo_page2.dart'
    deferred as refrsh_demo_page2;
import 'package:flutter_demos/widget/honor_demo_page.dart'
    deferred as honor_demo_page;
import 'package:flutter_demos/widget/silder_verify_page.dart'
    deferred as silder_verify_page;
import 'package:flutter_demos/widget/sliver_list_demo_page.dart'
    deferred as sliver_list_demo_page;
import 'package:flutter_demos/widget/animation_container_demo_page.dart'
    deferred as animation_container_demo_page;
import 'package:flutter_demos/widget/list_anim/list_anim_demo_page.dart'
    deferred as list_anim_demo_page;
import 'package:flutter_demos/widget/list_anim_2/list_anim_demo_page.dart'
    deferred as list_anim_demo_page2;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textButtonTheme: const TextButtonThemeData(
          // 去掉 TextButton 的水波纹效果
          style: ButtonStyle(splashFactory: NoSplash.splashFactory),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: routers,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var routeLists = routers.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(routeLists[index]);
              },
              child: Card(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  child: Text(routers.keys.toList()[index]),
                ),
              ),
            );
          },
          itemCount: routers.length,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ContainerAsyncRouterPage extends StatelessWidget {
  final Future libraryFuture;

  // 不能直接传widget，因为 release 打包时 dart2js 优化会导致时许不对
  // 稍后更新文章到掘金
  final WidgetBuilder child;

  const ContainerAsyncRouterPage(this.libraryFuture, this.child);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: libraryFuture,
        builder: (c, s) {
          if (s.connectionState == ConnectionState.done) {
            if (s.hasError) {
              return Scaffold(
                appBar: AppBar(),
                body: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Error: ${s.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }
            return child.call(context);
          }
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
          );
        });
  }
}

Map<String, WidgetBuilder> routers = {
  "列表滑动监听": (context) {
    return ContainerAsyncRouterPage(scroll_listener_demo_page.loadLibrary(),
        (context) {
      return scroll_listener_demo_page.ScrollListenerDemoPage();
    });
  },
  "滑动到指定位置(使用第三方库)": (context) {
    return ContainerAsyncRouterPage(scroll_to_index_demo_page.loadLibrary(),
        (context) {
      return scroll_to_index_demo_page.ScrollToIndexDemoPage();
    });
  },
  "滑动到指定位置(动态计算)": (context) {
    return ContainerAsyncRouterPage(scroll_to_index_demo_page2.loadLibrary(),
        (context) {
      return scroll_to_index_demo_page2.ScrollToIndexDemoPage2();
    });
  },
  "简单上下刷新": (context) {
    return ContainerAsyncRouterPage(refrsh_demo_page.loadLibrary(), (context) {
      return refrsh_demo_page.RefreshDemoPage();
    });
  },
  "简单上下刷新2": (context) {
    return ContainerAsyncRouterPage(refrsh_demo_page2.loadLibrary(), (context) {
      return refrsh_demo_page2.RefreshDemoPage2();
    });
  },
  "共享元素跳转效果": (context) {
    return ContainerAsyncRouterPage(honor_demo_page.loadLibrary(), (context) {
      return honor_demo_page.HonorDemoPage();
    });
  },
  "滑动验证": (context) {
    return ContainerAsyncRouterPage(silder_verify_page.loadLibrary(),
        (context) {
      return silder_verify_page.SlideVerifyPage();
    });
  },
  "列表滑动过程控件停靠效果": (context) {
    return ContainerAsyncRouterPage(sliver_list_demo_page.loadLibrary(),
        (context) {
      return sliver_list_demo_page.SliverListDemoPage();
    });
  },
  "控件动画变形效果": (context) {
    return ContainerAsyncRouterPage(animation_container_demo_page.loadLibrary(),
        (context) {
      return animation_container_demo_page.AnimationContainerDemoPage();
    });
  },
  "列表滑动过程 item 停靠动画效果": (context) {
    return ContainerAsyncRouterPage(list_anim_demo_page.loadLibrary(),
        (context) {
      return list_anim_demo_page.ListAnimDemoPage();
    });
  },
  "列表滑动过程 item 停靠动画效果2": (context) {
    return ContainerAsyncRouterPage(list_anim_demo_page2.loadLibrary(),
        (context) {
      return list_anim_demo_page2.ListAnimDemoPage2();
    });
  },
};
