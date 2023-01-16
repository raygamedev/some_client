import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:some_client/api/card.dart';
import 'package:some_client/barcodescanner.dart';
import 'package:some_client/card.dart';
import 'package:some_client/models/models.dart';

class CardsScreen extends HookWidget {
  final String userUUID;
  final String merchantId;
  const CardsScreen(
      {super.key, required this.userUUID, required this.merchantId});

  @override
  Widget build(BuildContext context) {
    final isCameraOpen = useState<bool>(false);
    final card = useState<CardModel?>(null);
    useEffect(() {
      if (userUUID.isNotEmpty) {
        requestNewCard(userUUID, merchantId).then((value) {
          card.value = value;
        });
      }
    }, [userUUID]);

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0, left: 10.0),
            child: IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.house_rounded,
                  color: Colors.grey,
                  size: 55,
                )),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0, right: 35.0),
            child: IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.my_library_books_rounded,
                  color: Colors.grey,
                  size: 50,
                )),
          ),
        ),
        const Positioned(
            child: Padding(
          padding: EdgeInsets.only(top: 100.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Image(
                width: 300,
                fit: BoxFit.contain,
                image: AssetImage('assets/images/nahatLogo.png')),
          ),
        )),
        card.value != null
            ? CardWidget(
                onMarkTap: () => isCameraOpen.value = true,
                color: card.value!.color)
            : const Center(child: CircularProgressIndicator()),
        if (isCameraOpen.value)
          const Positioned(child: Center(child: BarcodeScannerWidget())),
      ],
    );
  }
}
