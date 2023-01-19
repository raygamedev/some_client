import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
    final barcode = useState<String>('');

    Future<CardModel> onCardMark(int markIndex) async {
      try {
        CardModel card = await markCard(userUUID, merchantId, markIndex);
        return card;
      } catch (e) {
        // TODO:// Handle errors better
        debugPrint("error marking card $e");
        return CardModel.error();
      }
    }

    final setBarcodeCallback = useCallback((Barcode val, int markIndex) {
      if (val.rawValue == null) {
        // TODO Present error print!
        return;
      }
      barcode.value = val.rawValue!;
      isCameraOpen.value = false;
      onCardMark(markIndex).then((value) {
        print(value.cardMarks);
        card.value = value;
      });
    }, [barcode, isCameraOpen]);

    useEffect(() {
      if (userUUID.isNotEmpty) {
        // Check for active user card with merchantId
        getActiveCard(userUUID, merchantId).then((value) {
          if (value.cardId.isNotEmpty) {
            card.value = value;
          } else {
            // If card doesn't exists, request a new one!
            requestNewCard(userUUID, merchantId).then((value) {
              card.value = value;
            });
          }
        });
      }
      return null;
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
          Positioned(
              child: Center(
                  child:
                      BarcodeScannerWidget(onBarcodeScan: setBarcodeCallback))),
      ],
    );
  }
}
