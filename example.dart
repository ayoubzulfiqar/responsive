import 'package:flutter/material.dart';
import 'responsive.dart'; // Replace with your actual import path

void main() {
  runApp(
    // Wrap the app with ResponsiveConfigProvider for custom configuration
    ResponsiveConfigProvider(
      config: ResponsiveConfig.desktop(), // Desktop-optimized scaling
      child: const Responsiveness(),
    ),
  );
}

class Responsiveness extends StatelessWidget {
  const Responsiveness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Advanced Responsiveness",
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Get responsive instance (new recommended way)
    final r = context.responsive;

    // Legacy API calls (still fully supported)
    final heightLegacy = 50.sH(context);
    final widthLegacy = 50.sW(context);
    final fontLegacy = 10.sF(context);

    // Modern API calls (cleaner)
    final heightModern = 50.h(context);
    final widthModern = 50.w(context);
    final fontSizeModern = 10.sp(context);
    final radiusModern = 8.r(context);

    // Debug prints
    debugPrint('=== Responsive Debug ===');
    debugPrint('Screen: ${r.screenWidth.toStringAsFixed(1)} x ${r.screenHeight.toStringAsFixed(1)}');
    debugPrint('Device Type: ${context.deviceType}');
    debugPrint('Orientation: ${r.isPortrait ? "Portrait" : "Landscape"}');
    debugPrint('Platform: ${context.platformInfo.isWindows ? "Windows" : context.platformInfo.isLinux ? "Linux" : context.platformInfo.isMacOS ? "macOS" : "Other"}');
    debugPrint('Legacy 50.sH: $heightLegacy | Modern 50.h: $heightModern');
    debugPrint('Legacy 50.sW: $widthLegacy | Modern 50.w: $widthModern');
    debugPrint('Legacy 10.sF: $fontLegacy | Modern 10.sp: $fontSizeModern');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Showcase'),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: r.edgeInsetsAll(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Device & Orientation Info Card
              _buildInfoCard(context),

              r.sizedBox(height: 20),

              // Section: Basic Responsive Containers
              _buildSectionTitle(context, 'Basic Responsive Scaling'),
              r.sizedBox(height: 12),
              _buildComparisonRow(context),

              r.sizedBox(height: 30),

              // Section: Orientation-Aware Layout
              _buildSectionTitle(context, 'Orientation-Aware Layout'),
              r.sizedBox(height: 12),
              _buildOrientationLayout(context),

              r.sizedBox(height: 30),

              // Section: Device-Type Conditional Rendering
              _buildSectionTitle(context, 'Device-Type Conditional'),
              r.sizedBox(height: 12),
              _buildDeviceTypeDemo(context),

              r.sizedBox(height: 30),

              // Section: Responsive Spacing & Radius
              _buildSectionTitle(context, 'Spacing & Radius'),
              r.sizedBox(height: 12),
              _buildSpacingDemo(context),

              r.sizedBox(height: 30),

              // Section: Safe Area Adjusted Values
              _buildSectionTitle(context, 'Safe Area Adjusted'),
              r.sizedBox(height: 12),
              _buildSafeAreaDemo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final r = context.responsive;
    final platform = context.platformInfo;

    return Container(
      width: double.infinity,
      padding: r.edgeInsetsAll(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(r.r(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📱 Device & Platform Info',
            style: TextStyle(
              fontSize: 18.sp(context),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          r.sizedBox(height: 12),
          _infoRow(context, 'Screen Size',
              '${r.screenWidth.toStringAsFixed(0)} x ${r.screenHeight.toStringAsFixed(0)}'),
          _infoRow(context, 'Device Type', context.deviceType.name.toUpperCase()),
          _infoRow(context, 'Orientation', r.isPortrait ? 'Portrait' : 'Landscape'),
          _infoRow(context, 'Platform', _getPlatformName(platform)),
          _infoRow(context, 'Scale Factor',
              'W:${r.scaleWidth.toStringAsFixed(2)} H:${r.scaleHeight.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  String _getPlatformName(PlatformInfo platform) {
    if (platform.isWindows) return 'Windows';
    if (platform.isLinux) return 'Linux';
    if (platform.isMacOS) return 'macOS';
    if (platform.isIOS) return 'iOS';
    if (platform.isAndroid) return 'Android';
    if (platform.isWeb) return 'Web';
    return 'Unknown';
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp(context),
              color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp(context),
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.sp(context),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildComparisonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Responsive container (using modern API)
        Column(
          children: [
            Container(
              color: Colors.yellow,
              height: 50.h(context),
              width: 50.w(context),
              child: Center(
                child: Text(
                  "R",
                  style: TextStyle(
                    fontSize: 10.sp(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h(context)),
            Text(
              'Responsive',
              style: TextStyle(fontSize: 12.sp(context)),
            ),
          ],
        ),
        // Legacy API container
        Column(
          children: [
            Container(
              color: Colors.orange,
              height: 50.sH(context),
              width: 50.sW(context),
              child: Center(
                child: Text(
                  "L",
                  style: TextStyle(
                    fontSize: 10.sF(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h(context)),
            Text(
              'Legacy API',
              style: TextStyle(fontSize: 12.sp(context)),
            ),
          ],
        ),
        // Fixed size container (no scaling)
        Column(
          children: [
            Container(
              color: Colors.blue,
              height: 50,
              width: 50,
              child: const Center(
                child: Text(
                  "F",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h(context)),
            Text(
              'Fixed',
              style: TextStyle(fontSize: 12.sp(context)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrientationLayout(BuildContext context) {
    final r = context.responsive;
    final isPortrait = r.isPortrait;

    return Container(
      padding: r.edgeInsetsAll(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(r.r(12)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                isPortrait ? Icons.stay_current_portrait : Icons.stay_current_landscape,
                size: 24.sp(context),
              ),
              SizedBox(width: 8.w(context)),
              Text(
                isPortrait ? 'Portrait Mode Layout' : 'Landscape Mode Layout',
                style: TextStyle(
                  fontSize: 16.sp(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h(context)),
          // Layout changes based on orientation
          if (isPortrait)
            Column(
              children: [
                _buildOrientationBox(context, Colors.red.shade300, 'Top'),
                SizedBox(height: 12.h(context)),
                _buildOrientationBox(context, Colors.green.shade300, 'Middle'),
                SizedBox(height: 12.h(context)),
                _buildOrientationBox(context, Colors.blue.shade300, 'Bottom'),
              ],
            )
          else
            Row(
              children: [
                Expanded(child: _buildOrientationBox(context, Colors.red.shade300, 'Left')),
                SizedBox(width: 12.w(context)),
                Expanded(child: _buildOrientationBox(context, Colors.green.shade300, 'Center')),
                SizedBox(width: 12.w(context)),
                Expanded(child: _buildOrientationBox(context, Colors.blue.shade300, 'Right')),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildOrientationBox(BuildContext context, Color color, String label) {
    return Container(
      height: 60.h(context),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r(context)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16.sp(context),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceTypeDemo(BuildContext context) {
    final r = context.responsive;

    // Use valueForDevice to return different layouts per device type
    return r.valueForDevice<Widget>(
      mobile: _buildDeviceBox(context, 'Mobile Layout', Icons.phone_android, Colors.teal),
      tablet: _buildDeviceBox(context, 'Tablet Layout', Icons.tablet_android, Colors.indigo),
      desktop: _buildDeviceBox(context, 'Desktop Layout', Icons.desktop_windows, Colors.deepPurple),
    );
  }

  Widget _buildDeviceBox(BuildContext context, String title, IconData icon, Color color) {
    return Container(
      padding: context.responsive.edgeInsetsAll(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12.r(context)),
        border: Border.all(color: color, width: 2),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32.sp(context), color: color),
          SizedBox(width: 16.w(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp(context),
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                SizedBox(height: 4.h(context)),
                Text(
                  'This layout appears when running on a ${context.deviceType.name} device.',
                  style: TextStyle(fontSize: 14.sp(context)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpacingDemo(BuildContext context) {
    final r = context.responsive;
    return Column(
      children: [
        // Responsive padding and margin
        Container(
          margin: r.edgeInsetsAll(12),
          padding: r.edgeInsetsSymmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.amber.shade100,
            borderRadius: BorderRadius.circular(r.r(16)),
          ),
          child: Text(
            'Box with responsive margin & padding',
            style: TextStyle(fontSize: 14.sp(context)),
          ),
        ),
        SizedBox(height: 16.h(context)),
        // Responsive radius demo
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 60.w(context),
              height: 60.h(context),
              decoration: BoxDecoration(
                color: Colors.purple.shade200,
                borderRadius: BorderRadius.circular(8.r(context)),
              ),
              child: Center(
                child: Text('8.r', style: TextStyle(fontSize: 12.sp(context))),
              ),
            ),
            Container(
              width: 60.w(context),
              height: 60.h(context),
              decoration: BoxDecoration(
                color: Colors.purple.shade300,
                borderRadius: BorderRadius.circular(16.r(context)),
              ),
              child: Center(
                child: Text('16.r', style: TextStyle(fontSize: 12.sp(context))),
              ),
            ),
            Container(
              width: 60.w(context),
              height: 60.h(context),
              decoration: BoxDecoration(
                color: Colors.purple.shade400,
                borderRadius: BorderRadius.circular(24.r(context)),
              ),
              child: Center(
                child: Text('24.r', style: TextStyle(fontSize: 12.sp(context))),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSafeAreaDemo(BuildContext context) {
    final r = context.responsive;

    return Column(
      children: [
        // Height without status bar
        Container(
          width: double.infinity,
          height: 60.hns(context), // height without status bar
          decoration: BoxDecoration(
            color: Colors.cyan.shade100,
            borderRadius: BorderRadius.circular(8.r(context)),
          ),
          child: Center(
            child: Text(
              'Height without status bar (hns)',
              style: TextStyle(fontSize: 14.sp(context)),
            ),
          ),
        ),
        SizedBox(height: 12.h(context)),
        // Height without toolbar
        Container(
          width: double.infinity,
          height: 60.hnt(context), // height without toolbar
          decoration: BoxDecoration(
            color: Colors.lightBlue.shade100,
            borderRadius: BorderRadius.circular(8.r(context)),
          ),
          child: Center(
            child: Text(
              'Height without toolbar (hnt)',
              style: TextStyle(fontSize: 14.sp(context)),
            ),
          ),
        ),
        SizedBox(height: 12.h(context)),
        // Width without safe area
        Container(
          width: 200.wns(context), // width without safe area horizontal insets
          height: 50.h(context),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(8.r(context)),
          ),
          child: Center(
            child: Text(
              'Width without safe area (wns)',
              style: TextStyle(fontSize: 14.sp(context)),
            ),
          ),
        ),
        SizedBox(height: 16.h(context)),
        Text(
          'Status Bar Height: ${r.statusBarHeight.toStringAsFixed(1)}',
          style: TextStyle(fontSize: 12.sp(context)),
        ),
        Text(
          'Bottom Safe Area: ${r.bottomBarHeight.toStringAsFixed(1)}',
          style: TextStyle(fontSize: 12.sp(context)),
        ),
      ],
    );
  }
}
