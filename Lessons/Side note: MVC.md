# Side note: MVC
> previous:  [Lesson 3: Protocols and Bridging](bear://x-callback-url/open-note?id=06F79FE9-4A48-46E5-BAB0-3D111EA5947F-74998-00003292A1E8E08B)  
#Programming/Objective-c

Dependency & reusable code
`Cocoa` het framework waarmee jullie iOS applicaties maken steunt hevig op het principe van MVC. Dit betekend dat:

**M** -> geeft data aan **V** -> die het dan controleert -> **C** en het op het scherm plaats.

In het geval van meerdere **V** wordt dat wat moeilijker. Dat deel wordt nooit uitgelegd. In ieder geval is het de **M** die de *GLUE* is tussen de verschillende **V**. Als je herbruikbare code wil schrijven moet de **M** dus steeds aangepast kunnen worden.

**V** -> **C** die **M** controleert en een stukje **M** of een transform van **M** aanbied aan -> **V** die **M** controleert in ** C** en aan de gebruiker toont.

### Voorbeeld: EditProfileViewController

Hier staat in code: 
```swift
class EditProfileViewController: UIViewController{    
    let viewModel = EditProfileViewModel() // This prevents flexible data handling
	// More code
}
```
Hierdoor kan deze viewController enkel een profile tonen van 1 user. Bij multiple user gaat dit al *kapot*.

## Use of ViewModels
* Een ViewModel is een View op **M** die specifiek is voor die view. 
* Een ViewModel heeft best maar 1 taak. Geen 2. Als je er meer nodig hebt, gebruik dan meer ViewModellen.

### Voorbeeld: EditProfileViewModel

```swift
class EditProfileViewModel: LanguageViewModel, UserAPI {
    let editProfileTitleLabel = "edit_profile_title"
    let profileUsernameLabel = "profile_username"
    
    let changePictureButtonLabel = "profile_change_picture_button"
    let cancelButtonLabel = "cancel"
    
    let cameraPhotoLibraryLabel = "camera_photo_library"
    let cameraTakePhotoLabel = "camera_take_photo"
    
    let cameraErrorDescription = "camera_error"
    let cameraErrorTitle = "error"
    
    var user: UserInfoResult?
    var newProfilePic: String = "" 
    var newUsername: String = ""
    
    // MARK: - Translations (UIAlertController)
    
    let alertControllerGeneralServerErrorTitle: String = "server_error_title"
    let alertControllerGeneralServerErrorText: String = "server_error_text"
    
    let alertControllerSuccessTitle: String = "edit_profile_success_title"
    let alertControllersSuccessText: String = "edit_profile_success_text"

}
```

Je zet al een mark waar het eigenlijk ergens ander hoeft.

```swift
enum EditProfileError: String {
	case server_error_title
	case 
// ... more
}
```

## Dynamic data views, like TableView & CollectionView
```swift
class GraphCollectionViewCell: UICollectionViewCell {   
    let viewModel = ProfileViewModel()
}
```

Een Cell displayed details van een lijst van **M** die gecontrolleerd **C** worden in een **V** die een `TableViewController` of een `CollectionViewController` kan zijn. 

Typisch heeft een cell dan een methode:

```swift
class FooCell: UICollectionViewCell {
// Never (Or try to never) retain a viewModel
func setup(_ viewModel: DetailViewModel) {
// assign **M** details to view elements
}
}
```

### Voorbeeld: GraphCollectionViewCell
Het is onduidelijk wat deze class doet. Taken die het moet doen

1. 2 hoogtes tonen *Morning* *Afternoon* 
2. Datum tonen -> Dag van de week
Hiervoor is geen heel profile nodig. Enkel die twee zijn voldoende

```swift
class GraphCollectionViewCell: UICollectionViewCell {
    let viewModel = ProfileViewModel()
    func configureCell(userPoints: UserPoints) {   
	    // should handle tasks
    }
}
```

Dit zou moeten zijn

```swift

struct GraphDetailViewModel {
	 let morningHeigth
	 let afternoonHeigth
   let dateFormat
  init(userPoint: UserPoint, dateFormat:...) {
		 // ..
 }
}

class GraphCollectionViewCell: UICollectionViewCell {
    func configureCell(_ graphDetail: GraphDetailViewModel) {   
	    // should handle tasks
    }
}

```

> Go back: [Lesson 3: Protocols and Bridging](bear://x-callback-url/open-note?id=06F79FE9-4A48-46E5-BAB0-3D111EA5947F-74998-00003292A1E8E08B)  