import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter/controllers/product_controller.dart';
import 'package:udemy_flutter/modules/profile_shopkeeper_for_customer/Profile_Shopkeeper_All_For_Customer.dart';

const Color yellow = Color(0xFFFFBF00);

class Result_Search extends StatelessWidget {
  final String category;
  final String shopNameQuery;
  final String productNameQuery;

  const Result_Search({
    Key? key,
    required this.category,
    required this.shopNameQuery,
    required this.productNameQuery,
  }) : super(key: key);

  Widget buildBatteriesItem({
    required BuildContext context,
    required String sellerName,
    required String imagePath,
    required String price,
    required String batteryType,
    required String batterySize,
    required String productName,
  }) =>
      Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: yellow),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Profile_Shopkeeper_SolarPanel_For_Customer(
                                        sellerName: sellerName),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 10.0,
                            backgroundImage: AssetImage(imagePath),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Profile_Shopkeeper_SolarPanel_For_Customer(
                                        sellerName: sellerName),
                              ),
                            );
                          },
                          child: Text(
                            sellerName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.0),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.info_outline, size: 20.0),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: Container(
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: AssetImage(imagePath), fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(productName,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text('$price\$', style: const TextStyle(color: yellow, fontSize: 14.0)),
                    Text('Battery Type: $batteryType'),
                    Text('Battery Size: $batterySize'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {},
                        child: const Text('Review',
                            style:
                            TextStyle(color: yellow, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: yellow),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Profile_Shopkeeper_SolarPanel_For_Customer(
                                        sellerName: sellerName),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 10.0,
                            backgroundImage: AssetImage(imagePath),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Profile_Shopkeeper_SolarPanel_For_Customer(
                                        sellerName: sellerName),
                              ),
                            );
                          },
                          child: Text(
                            sellerName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.0),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.info_outline, size: 20.0),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: Container(
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: AssetImage(imagePath), fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(productName,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text('$price\$', style: const TextStyle(color: yellow, fontSize: 14.0)),
                    Text('Battery Type: $batteryType'),
                    Text('Battery Size: $batterySize'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {},
                        child: const Text('Review',
                            style:
                            TextStyle(color: yellow, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget buildInvertersItem({
    required BuildContext context,
    required String sellerName,
    required String imagePath,
    required String price,
    required String inverterRating,
    required String maxAc,
    required String defaultAc,
    required String solarRating,
    required String maxSolarVolt,
    required String mppt,
    required String productName,
  }) =>
      Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: yellow),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Profile_Shopkeeper_SolarPanel_For_Customer(
                                      sellerName: sellerName,
                                    ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 10.0,
                            backgroundImage: AssetImage(imagePath),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Profile_Shopkeeper_SolarPanel_For_Customer(
                                      sellerName: sellerName,
                                    ),
                              ),
                            );
                          },
                          child: Text(
                            sellerName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.0),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.info_outline, size: 20.0),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: Container(
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: AssetImage(imagePath), fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(productName,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text('$price\$', style: const TextStyle(color: yellow, fontSize: 14.0)),
                    const Text('Inverter Mode:'),
                    Text('Rated power: $inverterRating Watt'),
                    const Text('AC Charger Mode:'),
                    Text('Max: $maxAc , Default: $defaultAc'),
                    const Text('Solar Charger Mode:'),
                    Text('Rated power: $solarRating'),
                    Text('Max solar voltage: $maxSolarVolt'),
                    Text('MPPT voltage range: $mppt'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {},
                        child: const Text('Review',
                            style:
                            TextStyle(color: yellow, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: yellow),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Profile_Shopkeeper_SolarPanel_For_Customer(
                                      sellerName: sellerName,
                                    ),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 10.0,
                            backgroundImage: AssetImage(imagePath),
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Profile_Shopkeeper_SolarPanel_For_Customer(
                                      sellerName: sellerName,
                                    ),
                              ),
                            );
                          },
                          child: Text(
                            sellerName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.0),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.info_outline, size: 20.0),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: Container(
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: AssetImage(imagePath), fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(productName,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text('$price\$', style: const TextStyle(color: yellow, fontSize: 14.0)),
                    const Text('Inverter Mode:'),
                    Text('Rated power: $inverterRating Watt'),
                    const Text('AC Charger Mode:'),
                    Text('Max: $maxAc , Default: $defaultAc'),
                    const Text('Solar Charger Mode:'),
                    Text('Rated power: $solarRating'),
                    Text('Max solar voltage: $maxSolarVolt'),
                    Text('MPPT voltage range: $mppt'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {},
                        child: const Text('Review',
                            style:
                            TextStyle(color: yellow, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget buildSolarPanelItem({
    required BuildContext context,
    required String sellerName,
    required String imagePath,
    required String productName,
    required double price,
    required String maxPower,
    required String openVoltage,
    required String shortCircuitCurrent,
  }) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: yellow),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Profile_Shopkeeper_SolarPanel_For_Customer(
                                sellerName: sellerName,
                              ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 10.0,
                      backgroundImage: AssetImage(imagePath),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Profile_Shopkeeper_SolarPanel_For_Customer(
                                sellerName: sellerName,
                              ),
                        ),
                      );
                    },
                    child: Text(
                      sellerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.info_outline, size: 20.0),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                productName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$$price',
                style: const TextStyle(
                  color: yellow,
                  fontSize: 14.0,
                ),
              ),
              Text(
                'Maximum power: $maxPower W',
              ),
              Text(
                'Open circuit voltage: $openVoltage V',
              ),
              Text(
                'Short circuit current: $shortCircuitCurrent A',
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Review',
                    style: TextStyle(
                      color: yellow,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    final queryCategory = category.toLowerCase();
    final queryShopName = shopNameQuery.toLowerCase();
    final queryProductName = productNameQuery.toLowerCase();

    final filteredProducts = productController.allProducts.where((product) {
      final productCategory = product.category.toLowerCase();
      final shopName = (product.shop['shopname'] ?? '').toLowerCase();
      final productName = product.name.toLowerCase();

      if (!productCategory.contains(queryCategory)) return false;

      if (queryShopName.isNotEmpty && queryProductName.isNotEmpty) {
        return shopName.contains(queryShopName) && productName.contains(queryProductName);
      }
      if (queryShopName.isNotEmpty) {
        return shopName.contains(queryShopName);
      }
      if (queryProductName.isNotEmpty) {
        return productName.contains(queryProductName);
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
       ),
      body: filteredProducts.isEmpty
          ? const Center(child: Text('No results found.'))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];

          if (product.category.toLowerCase() == 'battery') {
            return buildBatteriesItem(
              context: context,
              sellerName: product.shop['shopname'] ?? 'Seller',
              imagePath: 'assets/images/Batteries1.webp',
              price: product.price.toString(),
              batteryType: product.details['batteryType']?.toString() ?? '',
              batterySize: product.details['batterySize']?.toString() ?? '',
              productName: product.name,
            );
          } else if (product.category.toLowerCase() == 'inverter') {
            return buildInvertersItem(
              context: context,
              sellerName: product.shop['shopname'] ?? 'Seller',
              imagePath: 'assets/images/Inverter.png',
              price: product.price.toString(),
              inverterRating: product.details['inverterRatingP']?.toString() ?? '',
              maxAc: product.details['maxAc']?.toString() ?? '',
              defaultAc: product.details['defaultAc']?.toString() ?? '',
              solarRating: product.details['solarRatingP']?.toString() ?? '',
              maxSolarVolt: product.details['maxSolarVolt']?.toString() ?? '',
              mppt: product.details['Mppt']?.toString() ?? '',
              productName: product.name,
            );
          } else if (product.category.toLowerCase() == 'solar_panel') {
            final solarPanels = filteredProducts
                .where((p) => p.category.toLowerCase() == 'solar_panel')
                .toList();

            final firstIndex = index * 2;
            final secondIndex = firstIndex + 1;

            if (firstIndex >= solarPanels.length) {
              return Container();
            }

            if (secondIndex >= solarPanels.length) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: buildSolarPanelItem(
                          context: context,
                          sellerName:
                          (solarPanels[firstIndex].shop['shopname'] ?? 'No name'),
                          imagePath: 'assets/images/Solar panel.png',
                          productName: solarPanels[firstIndex].name,
                          price: solarPanels[firstIndex].price,
                          maxPower:
                          solarPanels[firstIndex].details['maximumPower']?.toString() ??
                              '',
                          openVoltage:
                          solarPanels[firstIndex].details['openVoltage']?.toString() ?? '',
                          shortCircuitCurrent:
                          solarPanels[firstIndex].details['shortCurrent']?.toString() ?? '',
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              );
            }

            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: buildSolarPanelItem(
                        context: context,
                        sellerName:
                        (solarPanels[firstIndex].shop['shopname'] ?? 'No name'),
                        imagePath: 'assets/images/Solar panel.png',
                        productName: solarPanels[firstIndex].name,
                        price: solarPanels[firstIndex].price,
                        maxPower:
                        solarPanels[firstIndex].details['maximumPower']?.toString() ??
                            '',
                        openVoltage:
                        solarPanels[firstIndex].details['openVoltage']?.toString() ?? '',
                        shortCircuitCurrent:
                        solarPanels[firstIndex].details['shortCurrent']?.toString() ?? '',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: buildSolarPanelItem(
                        context: context,
                        sellerName:
                        (solarPanels[secondIndex].shop['shopname'] ?? 'No name'),
                        imagePath: 'assets/images/Solar panel.png',
                        productName: solarPanels[secondIndex].name,
                        price: solarPanels[secondIndex].price,
                        maxPower:
                        solarPanels[secondIndex].details['maximumPower']?.toString() ??
                            '',
                        openVoltage:
                        solarPanels[secondIndex].details['openVoltage']?.toString() ?? '',
                        shortCircuitCurrent:
                        solarPanels[secondIndex].details['shortCurrent']?.toString() ?? '',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            );
          }

          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.shop['shopname'] ?? 'No shop name'),
            trailing: Text('${product.price}\$'),
          );
        },
      ),
    );
  }
}
