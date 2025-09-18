// main.dart - Complete Blue Carbon MRV App for Coursour
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

final ThemeData cleanGreenTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
    primary: Colors.green[700]!,
    secondary: Colors.lightGreen[400]!,
    background: Colors.white,
    surface: Colors.green[50]!,
  ),
  scaffoldBackgroundColor: Colors.green[50],
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.green[100],
    indicatorColor: Colors.green[700],
    labelTextStyle: MaterialStateProperty.all(
      const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
    ),
  ),
);

void main() {
  runApp(const BlueCarbonApp());
}

class BlueCarbonApp extends StatelessWidget {
  const BlueCarbonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blue Carbon MRV',
      theme: cleanGreenTheme,
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Models
enum UserRole { admin, ngo, community, nccr }

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? organization;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.organization,
  });
}

class Project {
  final String id;
  final String name;
  final String location;
  final double progress;
  final int carbonCredits;
  final String status;
  final String stakeholder;
  final double area;

  const Project({
    required this.id,
    required this.name,
    required this.location,
    required this.progress,
    required this.carbonCredits,
    required this.status,
    required this.stakeholder,
    required this.area,
  });
}

class CarbonRecord {
  final String id;
  final String projectName;
  final int carbonCredits;
  final String transactionHash;
  final String walletAddress;
  final bool isVerified;
  final DateTime createdAt;

  const CarbonRecord({
    required this.id,
    required this.projectName,
    required this.carbonCredits,
    required this.transactionHash,
    required this.walletAddress,
    required this.isVerified,
    required this.createdAt,
  });
}

// Mock Data
class MockData {
  static List<Project> projects = [
    const Project(
      id: 'BC001',
      name: 'Sundarbans Mangrove Restoration',
      location: 'West Bengal',
      progress: 85.0,
      carbonCredits: 1250,
      status: 'Active',
      stakeholder: 'Coastal Panchayat',
      area: 245.0,
    ),
    const Project(
      id: 'BC002',
      name: 'Kerala Backwater Conservation',
      location: 'Kerala',
      progress: 68.0,
      carbonCredits: 890,
      status: 'Monitoring',
      stakeholder: 'NGO Partnership',
      area: 180.0,
    ),
    const Project(
      id: 'BC003',
      name: 'Tamil Nadu Seagrass Restoration',
      location: 'Tamil Nadu',
      progress: 75.0,
      carbonCredits: 650,
      status: 'Active',
      stakeholder: 'Fisher Community',
      area: 120.0,
    ),
  ];

  static List<CarbonRecord> carbonRecords = [
    CarbonRecord(
      id: 'CR001',
      projectName: 'Sundarbans Mangrove Restoration',
      carbonCredits: 500,
      transactionHash: '0x1a2b3c4d5e6f7890abcdef1234567890',
      walletAddress: '0xabcdef1234567890',
      isVerified: true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    CarbonRecord(
      id: 'CR002',
      projectName: 'Kerala Backwater Conservation',
      carbonCredits: 350,
      transactionHash: '0x234567890abcdef1234567890abcdef12',
      walletAddress: '0xabcdef1234567890',
      isVerified: true,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];
}

// Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserRole _selectedRole = UserRole.community;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withOpacity(0.1),
              theme.colorScheme.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo and Title
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.eco,
                    size: 64,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Blue Carbon MRV',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Blockchain Registry for India',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 48),
                // Login Form
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        // Role Selection
                        DropdownButtonFormField<UserRole>(
                          value: _selectedRole,
                          decoration: const InputDecoration(
                            labelText: 'Select Role',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          items: UserRole.values.map((role) {
                            return DropdownMenuItem(
                              value: role,
                              child: Text(_getRoleDisplayName(role)),
                            );
                          }).toList(),
                          onChanged: (role) {
                            if (role != null) {
                              setState(() => _selectedRole = role);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        // Password Field
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 24),
                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _handleLogin,
                            child: const Text('Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Quick Access Buttons
                Text(
                  'Quick Access (Demo)',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: UserRole.values.map((role) {
                    return OutlinedButton(
                      onPressed: () => _quickLogin(role),
                      child: Text(_getRoleDisplayName(role)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getRoleDisplayName(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.ngo:
        return 'NGO';
      case UserRole.community:
        return 'Community User';
      case UserRole.nccr:
        return 'NCCR Officer';
    }
  }

  void _handleLogin() {
    final user = User(
      id: '1',
      name: _getRoleDisplayName(_selectedRole),
      email: _emailController.text.isEmpty ? '${_selectedRole.name}@example.com' : _emailController.text,
      role: _selectedRole,
      organization: _getOrganization(_selectedRole),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainNavigationWrapper(user: user),
      ),
    );
  }

  void _quickLogin(UserRole role) {
    setState(() => _selectedRole = role);
    _emailController.text = '${role.name}@example.com';
    _passwordController.text = 'password';
    _handleLogin();
  }

  String? _getOrganization(UserRole role) {
    switch (role) {
      case UserRole.ngo:
        return 'Coastal Conservation Trust';
      case UserRole.community:
        return 'Sundarbans Community';
      case UserRole.nccr:
        return 'National Centre for Climate Research';
      default:
        return null;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// Main Navigation Wrapper
class MainNavigationWrapper extends StatefulWidget {
  final User user;
  const MainNavigationWrapper({super.key, required this.user});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _currentIndex = 0;

  late final List<Widget> _screens;
  @override
  void initState() {
    super.initState();
    _screens = [
      DashboardScreen(user: widget.user),
      const DataUploadScreen(),
      const CarbonRegistryScreen(),
      widget.user.role == UserRole.admin || widget.user.role == UserRole.nccr
          ? const AdminDashboardScreen()
          : const SmartContractScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          const NavigationDestination(
            icon: Icon(Icons.upload_outlined),
            selectedIcon: Icon(Icons.upload),
            label: 'Upload',
          ),
          const NavigationDestination(
            icon: Icon(Icons.eco_outlined),
            selectedIcon: Icon(Icons.eco),
            label: 'Registry',
          ),
          NavigationDestination(
            icon: widget.user.role == UserRole.admin || widget.user.role == UserRole.nccr
                ? const Icon(Icons.admin_panel_settings_outlined)
                : const Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: widget.user.role == UserRole.admin || widget.user.role == UserRole.nccr
                ? const Icon(Icons.admin_panel_settings)
                : const Icon(Icons.account_balance_wallet),
            label: widget.user.role == UserRole.admin || widget.user.role == UserRole.nccr
                ? 'Admin'
                : 'Wallet',
          ),
        ],
      ),
    );
  }
}

// Dashboard Screen
class DashboardScreen extends StatelessWidget {
  final User user;
  const DashboardScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final totalCredits = MockData.projects.fold(0, (sum, project) => sum + project.carbonCredits);
    final totalArea = MockData.projects.fold(0.0, (sum, project) => sum + project.area);
    final avgProgress = MockData.projects.fold(0.0, (sum, project) => sum + project.progress) / MockData.projects.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.eco,
                        size: 48,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome, ${user.name}',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.organization ?? 'Blue Carbon MRV System',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Monitoring coastal ecosystem restoration across India',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    title: 'Total Credits',
                    value: totalCredits.toString(),
                    subtitle: '₹${(totalCredits * 1500).toStringAsFixed(0)}',
                    icon: Icons.paid,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatsCard(
                    title: 'Projects',
                    value: MockData.projects.length.toString(),
                    subtitle: '${MockData.projects.where((p) => p.status == 'Active').length} active',
                    icon: Icons.nature,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: StatsCard(
                    title: 'Area',
                    value: '${totalArea.toInt()}',
                    subtitle: 'hectares',
                    icon: Icons.landscape,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatsCard(
                    title: 'Progress',
                    value: '${avgProgress.toInt()}%',
                    subtitle: 'average',
                    icon: Icons.trending_up,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Projects Section
            Text(
              'Restoration Projects',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: MockData.projects.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return ProjectCard(project: MockData.projects[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Stats Card Widget
class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Project Card Widget
class ProjectCard extends StatelessWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    project.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: project.status == 'Active'
                        ? Colors.green.withOpacity(0.2)
                        : Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    project.status,
                    style: TextStyle(
                      color: project.status == 'Active' ? Colors.green[700] : Colors.orange[700],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  project.location,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                Text(
                  '${project.area} hectares',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progress',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: project.progress / 100,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          project.progress > 80
                              ? Colors.green
                              : project.progress > 50
                              ? Colors.orange
                              : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${project.progress.toInt()}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Carbon Credits',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${project.carbonCredits}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Data Upload Screen
class DataUploadScreen extends StatefulWidget {
  const DataUploadScreen({super.key});

  @override
  State<DataUploadScreen> createState() => _DataUploadScreenState();
}

class _DataUploadScreenState extends State<DataUploadScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Upload'),
      ),
      body: Column(
        children: [
          // Tab Selection
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedTab == 0 ? Theme.of(context).colorScheme.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Field Data',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _selectedTab == 0 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedTab == 1 ? Theme.of(context).colorScheme.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Drone Data',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _selectedTab == 1 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: _selectedTab == 0 ? _buildFieldDataForm() : _buildDroneDataForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldDataForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Field Survey Data',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Project Selection
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Select Project',
              prefixIcon: Icon(Icons.nature),
            ),
            items: MockData.projects.map((project) {
              return DropdownMenuItem(
                value: project.id,
                child: Text(project.name),
              );
            }).toList(),
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          // Data Type
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Data Type',
              prefixIcon: Icon(Icons.category),
            ),
            items: const [
              DropdownMenuItem(value: 'plantation', child: Text('Plantation Data')),
              DropdownMenuItem(value: 'growth', child: Text('Growth Monitoring')),
              DropdownMenuItem(value: 'biomass', child: Text('Biomass Assessment')),
              DropdownMenuItem(value: 'species', child: Text('Species Survey')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          // Coordinates
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Latitude',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Longitude',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Trees Planted
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Trees Planted',
              prefixIcon: Icon(Icons.eco),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          // Notes
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Notes',
              prefixIcon: Icon(Icons.note_alt_outlined),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          // Submit Button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                // Handle submission logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Field data submitted!')),
                );
              },
              icon: const Icon(Icons.send),
              label: const Text('Submit Field Data'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDroneDataForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Drone & Satellite Data',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Project Selection
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Select Project',
              prefixIcon: Icon(Icons.nature),
            ),
            items: MockData.projects.map((project) {
              return DropdownMenuItem(
                value: project.id,
                child: Text(project.name),
              );
            }).toList(),
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          // File Picker for Drone Data
          OutlinedButton.icon(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['jpg', 'png', 'tiff', 'geojson', 'kml'],
                allowMultiple: true,
              );
              if (result != null) {
                // Process selected files
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${result.files.length} file(s) selected.')),
                );
              }
            },
            icon: const Icon(Icons.cloud_upload_outlined),
            label: const Text('Upload Drone/Satellite Files'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              side: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
            ),
          ),
          const SizedBox(height: 16),
          // Analysis Type
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Analysis Type',
              prefixIcon: Icon(Icons.analytics_outlined),
            ),
            items: const [
              DropdownMenuItem(value: 'biomass', child: Text('Biomass Estimation')),
              DropdownMenuItem(value: 'health', child: Text('Vegetation Health (NDVI)')),
              DropdownMenuItem(value: 'area', child: Text('Area Analysis')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 24),
          // Submit Button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                // Handle submission logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Drone data submitted for processing!')),
                );
              },
              icon: const Icon(Icons.send),
              label: const Text('Submit Drone Data'),
            ),
          ),
        ],
      ),
    );
  }
}

// Carbon Registry Screen
class CarbonRegistryScreen extends StatelessWidget {
  const CarbonRegistryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Registry'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verified Carbon Credits',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: MockData.carbonRecords.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final record = MockData.carbonRecords[index];
                return CarbonRecordCard(record: record);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Carbon Record Card Widget
class CarbonRecordCard extends StatelessWidget {
  final CarbonRecord record;
  const CarbonRecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  record.isVerified ? Icons.verified : Icons.access_time,
                  color: record.isVerified ? Colors.green : Colors.orange,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    record.projectName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${record.carbonCredits} Carbon Credits',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Transaction Hash: ${record.transactionHash.substring(0, 10)}...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Wallet Address: ${record.walletAddress.substring(0, 10)}...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Verified: ${record.isVerified ? 'Yes' : 'Pending'}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: record.isVerified ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Date: ${record.createdAt.day}/${record.createdAt.month}/${record.createdAt.year}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Admin Dashboard Screen (Placeholder)
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.admin_panel_settings,
                size: 80,
                color: Colors.blueGrey,
              ),
              const SizedBox(height: 16),
              Text(
                'Admin Dashboard',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'This section is for administrators and NCCR officers to manage users and projects.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Smart Contract Screen (Placeholder)
class SmartContractScreen extends StatelessWidget {
  const SmartContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_balance_wallet,
                size: 80,
                color: Colors.lightGreen,
              ),
              const SizedBox(height: 16),
              Text(
                'Wallet & Smart Contracts',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'This section shows your personal carbon credit wallet and transaction history.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}