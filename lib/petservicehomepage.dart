import 'package:flutter/material.dart';

class PetServiceHomePage extends StatelessWidget {
  const PetServiceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Our Services'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(child: Text('See All', style: TextStyle(color: Colors.purple))),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Service Icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _ServiceIcon(label: 'Vaccinations', icon: Icons.local_hospital),
                  _ServiceIcon(label: 'NGO', icon: Icons.group),
                  _ServiceIcon(label: 'Specialists', icon: Icons.medical_services),
                  _ServiceIcon(label: 'Cafe', icon: Icons.local_cafe),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Cafe Image Carousel (placeholder)
            SizedBox(
              height: 160,
              child: PageView(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset('assets/cafe.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Pet Friendly Cafe section
            _SectionHeader(title: 'Pet Friendly Cafe'),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  _CafeCard(
                    image: 'assets/food.jpg',
                    title: 'Homade Food',
                    rating: 5.0,
                    distance: 0.5,
                  ),
                  _CafeCard(
                    image: 'assets/cafe.jpg',
                    title: 'Monn Cafe',
                    rating: 4.8,
                    distance: 0.5,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Best Specialists Nearby
            _SectionHeader(title: 'Best Specialists Nearby'),
            const _SpecialistCard(
              name: 'Dr. Anna Johanson',
              specialization: 'Veterinary Behavioral',
              rating: 4.8,
              distance: 1.0,
              image: 'assets/anna.jpg',
            ),
            const _SpecialistCard(
              name: 'Dr. Vernon Chwe',
              specialization: 'Veterinary Surgery',
              rating: 4.2,
              distance: 1.5,
              image: 'assets/vernon.jpg',
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Service'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _ServiceIcon extends StatelessWidget {
  final String label;
  final IconData icon;

  const _ServiceIcon({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.purple.shade50,
          child: Icon(icon, color: Colors.purple),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: const Text('see all', style: TextStyle(color: Colors.purple)),
    );
  }
}

class _CafeCard extends StatelessWidget {
  final String image;
  final String title;
  final double rating;
  final double distance;

  const _CafeCard({
    required this.image,
    required this.title,
    required this.rating,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(image, height: 100, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(Icons.location_on, size: 14, color: Colors.grey),
                Text('$distance km', style: const TextStyle(fontSize: 12)),
                const Spacer(),
                Icon(Icons.star, size: 14, color: Colors.orange),
                Text('$rating', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text('Open on Tuesday to Saturday,\n10:00 AM to 11:00 PM',
                style: TextStyle(fontSize: 10, color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

class _SpecialistCard extends StatelessWidget {
  final String name;
  final String specialization;
  final double rating;
  final double distance;
  final String image;

  const _SpecialistCard({
    required this.name,
    required this.specialization,
    required this.rating,
    required this.distance,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage(image), radius: 30),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(specialization),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.star, size: 14, color: Colors.purple),
              Text('$rating', style: const TextStyle(fontSize: 12)),
            ]),
            Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.location_on, size: 14, color: Colors.purple),
              Text('$distance km', style: const TextStyle(fontSize: 12)),
            ]),
          ],
        ),
      ),
    );
  }
}
