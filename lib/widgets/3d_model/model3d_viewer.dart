import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_gl/flutter_gl.dart';
import 'package:three_dart/three_dart.dart' as three;
import 'package:three_dart_jsm/three_dart_jsm.dart' as three_jsm;

class Model3DViewer extends StatefulWidget {
  const Model3DViewer({super.key});

  @override
  _Model3DViewerState createState() => _Model3DViewerState();
}

class _Model3DViewerState extends State<Model3DViewer> {
  late FlutterGlPlugin _glPlugin;
  late three.WebGLRenderer renderer;
  late three.Scene scene;
  late three.Camera camera;

  late Ticker _ticker;

  Size? screenSize;
  double dpr = 1.0;

  late double width;
  late double height;

  late three.WebGLRenderTarget renderTarget;
  dynamic sourceTexture;

  bool _isInitialized = false;
  bool disposed = false; // Aggiungi una variabile disposed

  final GlobalKey<three_jsm.DomLikeListenableState> _globalKey =
      GlobalKey<three_jsm.DomLikeListenableState>();

  late three_jsm.OrbitControls controls;
  bool verbose = true;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      if (!_isInitialized) {
        initSize(context); // Inizializza solo se non è già stato fatto
      }
      return _buiild(context);
    });
  }

  initSize(BuildContext context) {
    if (screenSize != null) {
      print("Dimensioni già inizializzate: $screenSize");
      return;
    }

    final mqd = MediaQuery.of(context);

    screenSize = mqd.size;
    dpr = mqd.devicePixelRatio;
    print("Dimensioni dello schermo: $screenSize, DPR: $dpr");

    initPlatformState();
  }

  Future<void> initPlatformState() async {
    width = screenSize!.width;
    height = screenSize!.height;

    // Inizializza FlutterGlPlugin
    _glPlugin = FlutterGlPlugin();
    print(
        "Inizializzando FlutterGlPlugin con larghezza: $width, altezza: $height");
    await _glPlugin.initialize(options: {
      "width": width.toInt(),
      "height": height.toInt(),
      "antialias": true,
      "dpr": dpr,
      "alpha": true
    });
    setState(() {});

    Future.delayed(const Duration(milliseconds: 100), () async {
      await _glPlugin.prepareContext();
      _isInitialized = true;
      print("Plugin inizializzato e contesto pronto");

      initScene();
    });
  }

  initScene() {
    initRenderer();
    initPage();
  }

  initRenderer() {
    // Inizializza il renderer Three.js
    renderer = three.WebGLRenderer({
      "gl": _glPlugin.gl,
      "canvas": _glPlugin.element,
      "antialias": true,
      "width": width,
      "height": height,
      "alpha": true
    });

    renderer.setPixelRatio(dpr);
    renderer.setSize(width, height, false);
    renderer.setClearColor(three.Color(0x000000, 0));

    print("Renderer inizializzato con larghezza: $width, altezza: $height");

    if (!kIsWeb) {
      var pars = three.WebGLRenderTargetOptions({
        "minFilter": three.LinearFilter,
        "magFilter": three.LinearFilter,
        "format": three.RGBAFormat
      });
      renderTarget = three.WebGLRenderTarget(
          (width * dpr).toInt(), (height * dpr).toInt(), pars);
      renderTarget.samples = 4;
      renderer.setRenderTarget(renderTarget);
      sourceTexture = renderer.getRenderTargetGLTexture(renderTarget);
    }
  }

  List<double> ensureDoubleList(List<dynamic> list) {
    return list.map((e) => e is num ? e.toDouble() : 0.0).toList();
  }

  initPage() async {
    // Configura la scena e la camera
    scene = three.Scene();
    scene.background = null;
    camera = three.PerspectiveCamera(45, width / height, 0.1, 1000);

    camera.position.set(0, 0, 5); // Avvicina la telecamera

    controls = three_jsm.OrbitControls(camera, _globalKey);
    controls.enableDamping = false;
    controls.dampingFactor = 0.1;
    controls.rotateSpeed = 0.1;

    print(
        "Scena e camera inizializzate. Posizione della camera: ${camera.position.x}");

    // final geometry = three.BoxGeometry(20, 20, 20);
    // final material = three.MeshBasicMaterial({"color": 0x00ff00});
    // final cube = three.Mesh(geometry, material);
    // cube.position.set(0, 0, 0);
    // scene.add(cube);

    // Funzione per convertire una lista dinamica in una lista di double

    final loader = three_jsm.GLTFLoader();

    loader.load(
      'assets/img/3d-model/intact-model.gltf', // Percorso al file .gltf
      (gltf) {
        print(gltf.runtimeType);
        print(gltf); // Stampa l'oggetto caricato per verificare la struttura
        // Verifica se l'oggetto caricato ha una scena come proprietà e aggiungila alla scena di Three.js
        if (gltf is Map && gltf.containsKey('scene')) {
          final model = gltf['scene'];
          print(model);

// Applicazione della funzione al tuo modello
          if (model.position is List<dynamic>) {
            model.position = ensureDoubleList(model.position);
          }
          if (model.scale is List<dynamic>) {
            model.scale = ensureDoubleList(model.scale);
          }
          if (model is three.Object3D) {
            model.position.set(0, 0, 0);
            model.scale.set(1, 1, 1);
            scene.add(model);
          } else {
            print('Errore: il modello caricato non è di tipo Object3D');
          }
        } else {
          print('Errore: l\'oggetto gltf non contiene una scena valida.');
        }
      },
      (progress) {
        print(
            'Caricamento in corso: ${progress.loaded / progress.total * 100}%');
      },
      (error) {
        print('Errore nel caricamento del modello: $error');
      },
    );

    // Lights
    var ambientLight = three.AmbientLight(0x404040);
    scene.add(ambientLight);

    var pointLight = three.PointLight(0xffffff, 0.5);
    pointLight.position.set(0, 0, 0);
    scene.add(pointLight);
    // var sunLight = three.PointLight(0xffffff, 0.7);
    // sunLight.position.set(0, 0, 100);
    // scene.add(sunLight);

    startAnimation();
  }

  render() {
    final gl = _glPlugin.gl;

    // Aggiorna i controlli per riflettere le interazioni
    controls.update();

    renderer.render(scene, camera);

    gl.flush();

    if (!kIsWeb) {
      // three3dRender.updateTexture(sourceTexture);
      _glPlugin.updateTexture(sourceTexture);
    }
  }

  void startAnimation() {
    _ticker = Ticker((elapsed) {
      if (!mounted || disposed) {
        _ticker.dispose();
        return;
      }

      // Aggiorna i controlli per riflettere le interazioni
      controls.update();

      render(); // Chiama la funzione di rendering
    });
    _ticker.start();
  }

  Widget _buiild(BuildContext context) {
    print("BUUUUUUUILD chiamato - isInitialized: ${_glPlugin.isInitialized}");
    return three_jsm.DomLikeListenable(
        key: _globalKey,
        builder: (BuildContext context) {
          return _glPlugin.isInitialized
              ? Texture(
                  textureId: _glPlugin.textureId
                      as int) // Mostra il rendering nel widget
              : const CircularProgressIndicator();
        });
  }

  @override
  void dispose() {
    disposed = true;
    _glPlugin.dispose();
    _ticker.dispose();
    renderer.dispose();
    super.dispose();
  }
}
