import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constant.dart';
import '../../core/config/approute.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
            size: 20.sp,
          ),
          onPressed: () {},
        ),
        title: Text(
          'Walmart',
          style: TextStyle(
            color: AppColors.primaryGreen,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit_outlined,
              color: AppColors.black,
              size: 24.sp,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: profileGridItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 1.1,
            ),
              itemBuilder: (BuildContext context, int index) {
                final item = profileGridItems[index];
                return GestureDetector(
                  onTap: () {
                    if (item['label'] == 'Manage Address') {
                      Navigator.pushNamed(context, AppRoutes.manageAddress);
                    }
                  },
                  child: _buildGridItem(
                    icon: item['icon'],
                    label: item['label'],
                    color: AppColors.primaryGreen,
                  ),
                );
              },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: AppColors.bottomNavBackground,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined),
            activeIcon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'My Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(
      {required IconData icon, required String label, required Color color}) {
    return Card(
        elevation: 3,
        color: AppColors.white,
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.r),
    ),
    child: Padding(
    padding: EdgeInsets.all(16.w),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Icon(
    icon,
    color: color,
    size: 50.sp,
    ),
    SizedBox(height: 12.h),
    Text(
    label,
    style: TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
    ),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    ),
    ],
    ),
    ),
    );
    }
}