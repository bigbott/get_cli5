

Unofficial CLI for the GetX5.

This is the fork of [get_cli](https://pub.dev/packages/get_cli) version 1.9.1.

####Changes
The following changes has been made:
1. get_cli5 installs GetX version 5.0.0-release-candidate-9.3.2 (The latest release candidate at the moment) instead of latest stable version (4.7.2). Since the caret syntax doesn't work with RC versions, in case new version will be available in the future, manual fix will be required in *pubspec.yaml*.

2. Removed dialog that enabled choosing between GetXPattern (MVVM) and Clean. Now it is always GetXPattern. 

3. Folder `modules` renamed to `presentation` to better follow MVVM naming convention. 
   Instead of
   ```
   lib\
       app\
	       data\
		   modules\
   ```
   we have
   ```
   lib\
       app\
	       data\
		   presentation\
   ```
    
4. Removed `sub_folder: false` *pubspec.yaml* option. Now it is the flat structure by default: 
```
  home\
       home_binding.dart
       home_controller.dart
       home_view.dart
```
without option for extra folders. 

5. Template for Binding class updated to suit GetX5. 
   Now instead of: 
   ```
   class HomeBinding extends Bindings {
      @override
	  void dependencies() {
        Get.lazyPut<HomeController>(
          () => HomeController(),
        );
     }
   }
   ```
   Will be generated: 
   
   ```
	 class HomeBinding extends Binding {
       @override
       List<Bind> dependencies() {
         return [
            Bind.put<HomeController>(
             HomeController(),
            )
         ];
       }
      }
   ```

6. Added `create service` command. (Read below.)
  


####Installation

First deactivate get_cli (if it has been activated)
`dart pub global deactivate get_cli`

then activate get_cli5
`dart pub global activate get_cli5`

#### Usage
1. **Init project**
   Create Flutter project using *View->Command Pallete...* or by running `flutter create` in terminal. 
   Run `get init` command in terminal
   It will generate following folders and files
   ![init folder structure](/screenshots/getx_init_folders.png)
   
2. **Add a view to the project**   
The command `get create page:settings` will generate folder `settings` inside the `presentation` folder.

![create page folder structure](/screenshots/getx_create_page.png)
Also routes inside the `routes` folder will be updated. 
In case the desired name is "game settings" use `get create page:game-settings` command. 

3. **Add a service to the project**
To create the `AuthService` in `data` folder use `get create service:auth` command. It will generate `auth_service.dart` file with factory singleton. 
```
class AuthService {
  AuthService._();
  static final _instance = AuthService._();
  factory AuthService() {
    return _instance;
  }
}
```
To create the `AuthService` in `data/auth` folder use `get create service:auth on auth` command. If the `auth` folder does not exist, it will be created. 


For more information about other commands of get_cli check official [get_cli documentation.](https://pub.dev/packages/get_cli).

