'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "1059903c7f3a73a7cd1dae2d08932757",
"index.html": "a350397024be987220ea726fcd45a467",
"/": "a350397024be987220ea726fcd45a467",
"splash/img/light-4x.png": "2d133217840e5c61f881a17d834bef3f",
"splash/img/branding-1x.png": "03c412f11335a7af3df20f35a36fb70c",
"splash/img/dark-4x.png": "b6f3658485d8e6a418d132f36c83a380",
"splash/img/branding-dark-1x.png": "22dc403d557d3aafacdf2745dacdf0a6",
"splash/img/branding-4x.png": "2d133217840e5c61f881a17d834bef3f",
"splash/img/dark-3x.png": "56e6f51c2db502fd090e699db0b12ec0",
"splash/img/branding-dark-2x.png": "8808d6a4ea5bbf893033976328abd864",
"splash/img/dark-1x.png": "22dc403d557d3aafacdf2745dacdf0a6",
"splash/img/branding-dark-4x.png": "b6f3658485d8e6a418d132f36c83a380",
"splash/img/dark-2x.png": "8808d6a4ea5bbf893033976328abd864",
"splash/img/branding-3x.png": "b339112918b31f9cd89b0a39fe3ee769",
"splash/img/light-1x.png": "03c412f11335a7af3df20f35a36fb70c",
"splash/img/branding-dark-3x.png": "56e6f51c2db502fd090e699db0b12ec0",
"splash/img/branding-2x.png": "7958364efa0c775e18aef69a04d6abb7",
"splash/img/light-3x.png": "b339112918b31f9cd89b0a39fe3ee769",
"splash/img/light-2x.png": "7958364efa0c775e18aef69a04d6abb7",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "6399886d4f053859d0bf7cb37d4873a0",
"assets/assets/env": "6151e4c49767da708f8d495a9c54efc1",
"assets/assets/images/google-my-business-logo_1.png": "0c65576d03f4b00cefeaeae618ccdbc2",
"assets/assets/images/AR_LOGO_NEW_JANUARY_(1).png": "74ec951dc77b9d9ebe0a64788964e8aa",
"assets/assets/images/WhatsApp_icon.svg": "9882b9b8621d57c4265cc7b8328f77f1",
"assets/assets/images/fixgoogle.png": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/images/logoWsp.png": "ebe2d0d4564b42f0cba0fb9378a9ae20",
"assets/assets/images/bgNewB.png": "6e0d1d9c650f8d43f514b4fd76eca32f",
"assets/assets/images/logoapple.png": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/images/Ellipse_13_(2).png": "8b8ac6baa5e1f72dd1def169d653ad50",
"assets/assets/images/fixgoogle%2520copy.png": "2a7eaa3e2ac24c131bf27b7bf637abcd",
"assets/assets/images/5183_(1).jpg": "3fff6ca5b72cd87214adb2dc347e90dd",
"assets/assets/images/regis%2520copy.png": "8ff25b337af2cbb07190b89315722821",
"assets/assets/images/3dicons-mail-dynamic-clay.png": "6d3baff8c48759292258144bb6ab9428",
"assets/assets/images/Nuevos_clientes_bg.png": "d3332a597ab1a35bdf2b2e27f8ac50de",
"assets/assets/images/AlertNotification.svg": "dda7d06592c3f5b70bfd799bead8d34f",
"assets/assets/images/top-view-man-relaxing-spa.jpg": "402cbac16a72f84e033dac9d19ee4359",
"assets/assets/images/chatback.svg": "a0f5f92f54ec1a81689028e65b885205",
"assets/assets/images/NotificationSugNight.svg": "e24588a465bd1ad02bb3a89863cf0ba2",
"assets/assets/images/EmptyEvents.png": "7b88a72d5c871bc8e34de2a6ff86cf84",
"assets/assets/images/sunEmoji.png": "478bf2bd25337fa1c7ebe00935a94660",
"assets/assets/images/Icons_(25).png": "e79ed6a1232da3656d5601cc0a0a3265",
"assets/assets/images/conneck_logo_white%2520copy.png": "f2e9ef34b19849ce3dcd2df2a81bb403",
"assets/assets/images/NotificationAvisoLigh.svg": "49bcee3105a2b5fb183aa4a94b8af8cf",
"assets/assets/images/socialempty.png": "5ce95926f9a95ce1710e36b821e4cc10",
"assets/assets/images/logoapple%2520copy.png": "9b55eb6d8aeed2a9ae1dee4832041cbe",
"assets/assets/images/emptyService.png": "82f3b303b1974d6fc5e3f9f1249f86db",
"assets/assets/images/Greg_promo_bg.png": "1407216e95a5292d1bd128cde0338a1f",
"assets/assets/images/app_launcher_icon.jpg": "7e4d26d85699203ffc7e675de617cecd",
"assets/assets/images/mountain.png": "eb1ac1bc8a379167e809541a5605fcc9",
"assets/assets/images/f849924a0287ec9e7f8dcaceef37db54.png": "53cc3b7b6cdf7d52b8bdc09735cc9315",
"assets/assets/images/exploreEmpty.png": "15e74f7f32b4cb7e0cd07f9f4c3a8e23",
"assets/assets/images/Icons_(24).png": "ee9270c6a9cc95d2c1dbe9ea645e45aa",
"assets/assets/images/Interacciones_BG.png": "8e6bfe73cc99d7c92466587aae6f45ed",
"assets/assets/images/Rectangle_3.png": "60b73cbf77b86e30a73dcc381d6df7dd",
"assets/assets/images/Ellipse_12.png": "6794ebdde8d907c05d54a0e01b5496a9",
"assets/assets/images/emptyProducts.png": "6a7e60d5a9f10cd93b89ad49fb2bdfb3",
"assets/assets/images/loginWeb%2520copy.png": "07ab672ca533b203a509526a51d80ba4",
"assets/assets/images/Tasas_de_exito.png": "7d005c83cffc44d72a8087d4f915f75c",
"assets/assets/images/AR_Labs_&_Vision_-_New_Social_Logo_-_June.png": "b0ab8cd8ca17902d93be24741de883e8",
"assets/assets/images/NotificationSugLight.svg": "e72fd476b4f19a83ab5bbfc970b37f3b",
"assets/assets/images/superconnek.jpg": "149bf7c88340639ef3af859090b85592",
"assets/assets/images/8330.jpg": "1b4ffe50134ca6eb86e00303a04bfb1d",
"assets/assets/images/monitor.png": "fc03a485373a024b625aa3f3bdda4e1a",
"assets/assets/images/logoInsta.png": "890254ff4d465032325b4ba58dc5e281",
"assets/assets/images/leftLight.png": "7eb83ca00617e2bc2eb521f036f93051",
"assets/assets/images/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/assets/images/conneck_logo_white.png": "f2e9ef34b19849ce3dcd2df2a81bb403",
"assets/assets/images/loginWeb.png": "07ab672ca533b203a509526a51d80ba4",
"assets/assets/images/docUpload.png": "edab0d00a368f866079fe8c54198c303",
"assets/assets/images/emptyLead.png": "364a23967d84fa75bf837692949f5ca2",
"assets/assets/images/Ellipse_11.png": "9e8e8fde11f269022f9b0c4c46a6419d",
"assets/assets/images/google.png": "9946b7455b6665a72404cf63b9468c7f",
"assets/assets/images/regis.png": "8ff25b337af2cbb07190b89315722821",
"assets/assets/images/error_image.png": "8cc3fd166a3d8df31d62c10e7bf14f3c",
"assets/assets/images/bgbusinessWeb.png": "4ba33ac104d0b5b8138e928deb37079b",
"assets/assets/images/individual.png": "18aeca3ece88768f7340db43533dcedd",
"assets/assets/images/Greg_Top_Bot_CArd.png": "53f761678983bf8e0768632609c096d4",
"assets/assets/images/Connek_Night.svg": "aa727729d85f7985b8922785eeeee4ca",
"assets/assets/images/3dicons-tools-dynamic-clay.png": "752de16dcf2cee524732770f01a3d0e1",
"assets/assets/images/Rectangle_29.png": "1574f2f9581dc4a3fd1f04efe102106e",
"assets/assets/images/Bots_Activos_BG.png": "3dcb6c71d0cc7b55ee33e050f9b8d7d5",
"assets/assets/images/Ellipse_13_(1).png": "140e05a3b493b31c77e2d7b63e89f795",
"assets/assets/images/logoWsp%2520copy.png": "ebe2d0d4564b42f0cba0fb9378a9ae20",
"assets/assets/images/Company.png": "438995e46f82af3d7e7a742081c375de",
"assets/assets/images/GREG_CARD_1.png": "d4d9b8ac114d1ee455ed51c05bd931e8",
"assets/assets/images/SugIaButLight.svg": "e010256b4acb4f63e124be459ecdfea1",
"assets/assets/images/mesh-gradient_(7).png": "55d1300a92f99c209f6cdc39e584418b",
"assets/assets/images/rightDark.png": "d2342adb4436023ed256112bfeaac07a",
"assets/assets/images/Connek_Light.svg": "4e0932cc96b71d405229a8d83e887c5f",
"assets/assets/images/2150911817.jpg": "6b9d15debce605c663257a6f65438500",
"assets/assets/images/Greg_Card_M.png": "2263964b46b51fde17c095cc5867d116",
"assets/assets/images/Ellipse_9.png": "0da8d05219f0aa9b1d180f64bef19c77",
"assets/assets/images/Chip_(1).png": "8a17aca1923e45b446aee58249bb8297",
"assets/assets/images/logofb.png": "ec4c9f730ca236cbb11d97877df154bd",
"assets/assets/images/AlertNotificationLight.svg": "1b9a7d8f7cba425514dab0477876de33",
"assets/assets/images/Sugerencias_IA_Night.svg": "ee760be636c739c406aabf54e3c77185",
"assets/assets/images/leftDark.png": "82d5b06de220c93a29c7a6bfe92aab27",
"assets/assets/images/Ellipse_13.png": "01e76cd8d36491b4ced32c45ef35fdad",
"assets/assets/images/rightLight.png": "15dde21c0e98981007d9f957b36f5cbe",
"assets/assets/images/logo_connek_definitivo.jpg": "7e4d26d85699203ffc7e675de617cecd",
"assets/assets/images/greg-bot.mp4": "30432e267b12e82a3d8131bfa5b80df9",
"assets/assets/images/logofb%2520copy.png": "ec4c9f730ca236cbb11d97877df154bd",
"assets/assets/images/Search_Icon_BG.png": "f25bfa8b7e1c70322d610c6dd4fe34cc",
"assets/assets/images/flag.png": "839bea7edd8b70eeca484afc5b438aa1",
"assets/assets/images/bgBusinessWebDark.png": "9ffad1fb89e406276f2a421845d33b6d",
"assets/assets/images/adaptive_foreground_icon.jpg": "7e4d26d85699203ffc7e675de617cecd",
"assets/assets/images/SeparatorBottomSheet.svg": "89ac296394b607f6238f06462eff6b9d",
"assets/assets/images/note.png": "788514cc657774b6723faf4c7421e73e",
"assets/assets/images/NotificationAvisoNigh.svg": "3f241c61da1f8ccf35e2637e280b1f5f",
"assets/assets/images/Greg_BG.png": "ec6708087ef8a518f2cbb5aea34ecabd",
"assets/assets/images/Marketplace_BG.png": "114155a9900ba7a4a23aeff0561831af",
"assets/assets/images/conneck_logo_dark.png": "7820caa08bbfe13a34eeefff50456079",
"assets/assets/images/Perfil.png": "1e2c162081713cdea075c39d8a1230f9",
"assets/assets/lang/lang_english.json": "88eac4e4bc9f9104dd075421ba0ad238",
"assets/assets/lang/lang_french.json": "18cb8c92a7df47103a253be3f1eeed34",
"assets/assets/lang/lang_spanish.json": "d4cf2e6385627cec6e02665a440bbef4",
"assets/assets/lang/lang_russian.json": "d651c25bb2c1819bbb94cdc4d310c6ad",
"assets/fonts/MaterialIcons-Regular.otf": "a74fdd936f01943c73c2e4c2b409890c",
"assets/NOTICES": "5559a6050e5a49942f3938000a296fd8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/record_web/assets/js/record.fixwebmduration.js": "1f0108ea80c8951ba702ced40cf8cdce",
"assets/packages/record_web/assets/js/record.worklet.js": "6d247986689d283b7e45ccdf7214c2ff",
"assets/packages/liquid_glass_renderer/lib/assets/shaders/liquid_glass_arbitrary.frag": "165123cf809bb7cea0f60cdb8658f67a",
"assets/packages/liquid_glass_renderer/lib/assets/shaders/liquid_glass_filter.frag": "7a69a481c4b01af713dc9d1ba40463fa",
"assets/packages/liquid_glass_renderer/lib/assets/shaders/liquid_glass_geometry_blended.frag": "884d38ba3a7ab0ab72a463611f229e53",
"assets/packages/liquid_glass_renderer/lib/assets/shaders/liquid_glass_final_render.frag": "77416b256a173eb8a39a26e00899bc1a",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "da3d74a13a1f9d218dd9f94fdca93e93",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "c2d610fa166fd53ba8646e7c2ab85f10",
"version.json": "36104bf590144ceb1c6149f5105bf54d",
"main.dart.js": "0dd1b998da4860d1771251d117316ced"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
